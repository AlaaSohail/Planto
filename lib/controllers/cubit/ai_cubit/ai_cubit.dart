import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:plant_care/controllers/core/api/api_consumer.dart';
import 'package:plant_care/controllers/models/ChatMessage.dart';
import 'package:plant_care/controllers/paths/ApiEndpoints.dart';

import '../../cache/cache_helper.dart';
import '../../core/errors/exceptions.dart';
import '../../core/functions/upload_image.dart';
import '../../models/ai_model.dart';
import '../../services/service_locator.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  AiCubit(this.api) : super(AiInitial());

  ApiConsumer? api;
  final picker = ImagePicker();
  XFile? image;
  XFile? analyzeImage;
  List<ChatMessage> messages = [];

  bool _isChatSending = false;
  bool get isChatSending => _isChatSending;

  Future<void> uploadPostImage(XFile image) async {
    emit(UploadAnalyzeImageLoading());
    try {
      analyzeImage = image;
      emit(UploadAnalyzeImageSuccess());
    } catch (e) {
      emit(UploadAnalyzeImageError(e.toString()));
    }
  }

  Future<String?> chatAiBot(
      String message, {
        XFile? image,
        String imageOnlyPrompt =
        'Please examine this plant photo and suggest how to care for it.',
        String failureMessage =
        'Could not send your message. Please try again.',
      }) async {
    final text = message.trim();
    if (isClosed || _isChatSending || (text.isEmpty && image == null)) {
      return null;
    }

    _isChatSending = true;

    final loadingMessage = ChatMessage(
      message: '',
      isUser: false,
      isLoading: true,
    );

    messages.add(
      ChatMessage(
        message: text,
        isUser: true,
        imagePath: image?.path,
      ),
    );
    messages.add(loadingMessage);
    emit(AiChatLoading());

    // Replace this request's placeholder, even if the list changes later.
    void replaceLoadingMessage(String content) {
      final index = messages.indexWhere(
            (item) => identical(item, loadingMessage),
      );
      if (index >= 0) {
        messages[index] = ChatMessage(
          message: content,
          isUser: false,
          isLoading: false,
        );
      }
    }

    try {
      final data = <String, dynamic>{
        ApiKeys.message: text.isEmpty ? imageOnlyPrompt : text,
      };

      if (image != null) {
        data['image'] = await uploadImageToAPI(image);
      }

      if (isClosed) return null;

      final response = await api!.post(
        ApiEndpoints.chat,
        data: data,
        isFormData: true,
      );

      final aiMessage = response[ApiKeys.message]?.toString().trim();
      if (aiMessage == null || aiMessage.isEmpty) {
        throw const FormatException('AI response is empty');
      }

      if (isClosed) return null;
      replaceLoadingMessage(aiMessage);
      _isChatSending = false;
      emit(AiChatSuccess(aiMessage));
      return aiMessage;
    } on ServerException catch (e) {
      if (!isClosed) {
        final errorMessage = e.errorModel.errorMessage;
        replaceLoadingMessage(errorMessage);
        _isChatSending = false;
        emit(AiChatError(errorMessage));
      }
      return null;
    } catch (_) {
      if (!isClosed) {
        replaceLoadingMessage(failureMessage);
        _isChatSending = false;
        emit(AiChatError(failureMessage));
      }
      return null;
    } finally {
      _isChatSending = false;
    }
  }

  Future<void> getDailyTip() async {
    final cache = getIt<CacheHelper>();
    final savedDate = cache.getDataString(key: ApiKeys.dailyTipDate);
    final today = DateTime.now().toIso8601String().split('T').first;
    if (savedDate == today) {
      final savedTip = cache.getDataString(key: ApiKeys.dailyTip);
      if (savedTip != null && savedTip.trim().isNotEmpty) {
        emit(AiDailyTipSuccess(savedTip));
        return;
      }
    }
    emit(AiDailyTipLoading());
    try {
      final response = await api!.post(
        ApiEndpoints.chat,
        data: {
          ApiKeys.message: 'Give me a useful plant care daily tip in 15 words.',
        },
        isFormData: true,
      );
      final tip = response[ApiKeys.message]?.toString();
      if (tip == null || tip.trim().isEmpty) {
        throw Exception('Daily tip is empty');
      }
      await cache.saveData(key: ApiKeys.dailyTip, value: tip);
      await cache.saveData(key: ApiKeys.dailyTipDate, value: today);
      emit(AiDailyTipSuccess(tip));
    } on ServerException catch (e) {
      emit(AiDailyTipError(e.errorModel.errorMessage));
    } catch (e) {
      emit(AiDailyTipError(e.toString()));
    }
  }

  Future<void> analyzePlant(XFile? image) async {
    if (image == null) {
      emit(AiAnalyzeError('Please select an image'));
      return;
    }
    analyzeImage = image;
    emit(AiLoading());
    try {
      final response = await api!.post(
        ApiEndpoints.analyze,
        data: {'image': await uploadImageToAPI(image)},
        isFormData: true,
      );
      final aiAnalysisModel = AiAnalysisModel.fromJson(response['analysis']);
      emit(AiAnalyzeSuccess(aiAnalysisModel));
    } on ServerException catch (e) {
      emit(AiAnalyzeError(e.errorModel.errorMessage));
    } catch (e) {
      emit(AiAnalyzeError(e.toString()));
    }
  }
}

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

  Future<void> uploadPostImage(XFile image) async {
    emit(UploadAnalyzeImageLoading());

    try {
      analyzeImage = image;

      emit(UploadAnalyzeImageSuccess());
    } catch (e) {
      emit(UploadAnalyzeImageError(e.toString()));
    }
  }

  Future<String?> chatAiBot(String message) async {
    // User message
    messages.add(
      ChatMessage(
        message: message,
        isUser: true,
      ),
    );

    // Temporary AI message
    messages.add(
      ChatMessage(
        message: '',
        isUser: false,
        isLoading: true,
      ),
    );

    emit(AiChatLoading());

    try {
      final response = await api!.post(
        ApiEndpoints.chat,
        data: {
          ApiKeys.message: message,
        },
        isFormData: true,
      );

      final aiMessage = response[ApiKeys.message];

      // Replace loading message with AI response
      messages[messages.length - 1] = ChatMessage(
        message: aiMessage,
        isUser: false,
        isLoading: false,
      );

      emit(AiChatSuccess(aiMessage));

      return aiMessage;
    } on ServerException catch (e) {
      // Replace loading message with error
      messages[messages.length - 1] = ChatMessage(
        message: e.toString(),
        isUser: false,
        isLoading: false,
      );

      emit(AiChatError(e.toString()));
      return null;
    } catch (e) {
      messages[messages.length - 1] = ChatMessage(
        message: e.toString(),
        isUser: false,
        isLoading: false,
      );

      emit(AiChatError(e.toString()));
      return null;
    }
  }
  Future<void> getDailyTip() async {
    final cache = getIt<CacheHelper>();

    final savedDate = cache.getDataString(key: ApiKeys.dailyTipDate);

    final today = DateTime.now().toIso8601String().split('T').first;

    if (savedDate == today) {
      final savedTip = cache.getDataString(key: ApiKeys.dailyTip);

      if (savedTip != null && savedTip.isNotEmpty) {
        emit(AiChatSuccess(savedTip));
        return;
      }
    }

    emit(AiLoading());

    try {
      final response = await api!.post(
        ApiEndpoints.chat,
        data: {ApiKeys.message: 'Give me Daily Tip in 15 words'},
        isFormData: true,
      );

      final tip = response[ApiKeys.message];

      await cache.saveData(key: ApiKeys.dailyTip, value: tip);

      await cache.saveData(key: ApiKeys.dailyTipDate, value: today);

      emit(AiChatSuccess(tip));
    } on ServerException catch (e) {
      emit(AiChatError(e.errorModel.errorMessage));
    } catch (e) {
      emit(AiChatError(e.toString()));
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

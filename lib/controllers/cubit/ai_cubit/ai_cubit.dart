import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:plant_care/controllers/core/api/api_consumer.dart';
import 'package:plant_care/controllers/paths/ApiEndpoints.dart';

import '../../core/errors/exceptions.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  AiCubit(this.api) : super(AiInitial());

  ApiConsumer? api;
  final picker = ImagePicker();
  XFile? image;

  chatAiBot(String message) async {
    emit(AiLoading());
    try {
      final response = await api!.post(
        ApiEndpoints.chat,
        data: {ApiKeys.message: message},
        isFormData: true,
      );

      emit(AiSuccess(response["message"]));
      return response[ApiKeys.message];
    } on ServerException catch (e) {
      emit(AiError(e.toString()));
    } catch (e) {
      emit(AiError(e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:plant_care/controllers/core/api/api_consumer.dart';
import 'package:plant_care/controllers/core/errors/exceptions.dart';
import 'package:plant_care/controllers/models/plant_model.dart';

import '../../core/functions/upload_image.dart';
import '../../paths/ApiEndpoints.dart';

part 'plant_state.dart';

class PlantCubit extends Cubit<PlantState> {
  PlantCubit(this.api) : super(PlantInitial());

  final ApiConsumer api;
  PlantModel? plant;

  XFile? plantImage;

  uploadPlantImage(XFile image) {
    plantImage = image;
    emit(UploadPlantImage());
  }

  addPlant(
    String name,
    String species,
    XFile? imageUrl,
    String description,
  ) async {
    emit(PlantLoading());
    try {
      final response = await api.post(
        ApiEndpoints.plants,
        data: {
          PlantApiKeys.plantName: name,
          PlantApiKeys.species: species,
          PlantApiKeys.imagePlant: await uploadImageToAPI(imageUrl!),
          PlantApiKeys.description: description,
        },
        isFormData: true,
      );

      plant = PlantModel.fromJson(response);
      emit(PlantSuccess(plant!, "Plant Added Successfully"));
      await getPlant();
    } on ServerException catch (e) {
      emit(PlantError(e.errorModel.errorMessage));
    }
  }

  Future<List<PlantModel>> getPlant() async {
    emit(PlantLoading());

    try {
      final response = await api.get(ApiEndpoints.plants);

      final List<PlantModel> plants = (response["plants"] as List<dynamic>)
          .map((plant) => PlantModel.fromJson(plant as Map<String, dynamic>))
          .toList();

      emit(GetALLPlantSuccess(plants, "Plants Loaded Successfully"));

      return plants;
    } on ServerException catch (e) {
      emit(PlantError(e.errorModel.errorMessage));
      return [];
    } catch (e) {
      emit(PlantError(e.toString()));
      return [];
    }
  }

  deletePlant(String id) async {
    emit(PlantLoading());
    try {
      final response = await api.delete(ApiEndpoints.deletePlants(id));
      plant = PlantModel.fromJson(response);
      emit(PlantSuccess(plant!, "Plant Deleted Successfully"));
      await getPlant();
    } on ServerException catch (e) {
      emit(PlantError(e.errorModel.errorMessage));
    }
  }
}

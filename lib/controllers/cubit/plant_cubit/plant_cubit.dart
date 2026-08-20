import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:plant_care/controllers/core/api/api_consumer.dart';
import 'package:plant_care/controllers/core/errors/exceptions.dart';
import 'package:plant_care/controllers/models/plant_model.dart';

import '../../cache/cache_helper.dart';
import '../../core/functions/upload_image.dart';
import '../../paths/ApiEndpoints.dart';
import '../../services/service_locator.dart';

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

      final plantsJson = response["plants"] as List<dynamic>;

      // Save latest plants locally
      await getIt<CacheHelper>().saveData(
        key: ApiKeys.cachedPlants,
        value: jsonEncode(plantsJson),
      );

      final List<PlantModel> plants = plantsJson
          .map((plant) => PlantModel.fromJson(plant as Map<String, dynamic>))
          .toList();

      emit(GetALLPlantSuccess(plants, "Plants Loaded Successfully"));

      return plants;
    } on ServerException catch (e) {
      return _loadCachedPlants(e.errorModel.errorMessage);
    } catch (e) {
      return _loadCachedPlants(e.toString());
    }
  }

  Future<List<PlantModel>> _loadCachedPlants(String errorMessage) async {
    try {
      final cachedData = getIt<CacheHelper>().getDataString(
        key: ApiKeys.cachedPlants,
      );

      if (cachedData == null || cachedData.isEmpty) {
        emit(PlantError(errorMessage));
        return [];
      }

      final List<dynamic> decoded = jsonDecode(cachedData);

      final List<PlantModel> plants = decoded
          .map((plant) => PlantModel.fromJson(plant as Map<String, dynamic>))
          .toList();

      emit(GetALLPlantSuccess(plants, "Loaded from local storage"));

      return plants;
    } catch (e) {
      emit(PlantError(errorMessage));
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

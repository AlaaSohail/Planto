import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:plant_care/controllers/core/api/api_consumer.dart';
import 'package:plant_care/controllers/core/errors/exceptions.dart';
import 'package:plant_care/controllers/models/plant_model.dart';

import '../../cache/cache_helper.dart';
import '../../core/functions/upload_image.dart';
import '../../models/ai_model.dart';
import '../../paths/ApiEndpoints.dart';
import '../../services/service_locator.dart';

part 'plant_state.dart';

class PlantCubit extends Cubit<PlantState> {
  PlantCubit(this.api) : super(PlantInitial());

  final ApiConsumer api;
  PlantModel? plant;

  XFile? plantImage;
  List<PlantModel> plants = [];
  List<PlantModel> filteredPlants = [];
  List<PlantModel> allPlants = [];
  uploadPlantImage(XFile image) {
    plantImage = image;
    emit(UploadPlantImage());
  }

  Future<void> addPlant(
    String name,
    String species,
    XFile? imageUrl,
    String description,

    // AI Data
    String? healthStatus,
    double? healthScore,
    String? wateringAdvice,
    String? sunlightAdvice,
    String? fertilizerAdvice,
    String? disease,
    double? confidence,
    String? recommendation,
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

          // AI Data
          'health_status': healthStatus,
          'health_score': healthScore,
          'watering_advice': wateringAdvice,
          'sunlight_advice': sunlightAdvice,
          'fertilizer_advice': fertilizerAdvice,
          'disease': disease,
          'confidence': confidence,
          'recommendation': recommendation,
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

      await getIt<CacheHelper>().saveData(
        key: ApiKeys.cachedPlants,
        value: jsonEncode(plantsJson),
      );

      allPlants = plantsJson
          .map(
            (plant) => PlantModel.fromJson(
          plant as Map<String, dynamic>,
        ),
      )
          .toList();

      // عند تحميل النباتات من جديد، ألغِ البحث
      filteredPlants = List.from(allPlants);

      emit(
        GetALLPlantSuccess(
          filteredPlants,
          "Plants Loaded Successfully",
        ),
      );

      return allPlants;
    } on ServerException catch (e) {
      return _loadCachedPlants(e.errorModel.errorMessage);
    } catch (e) {
      return _loadCachedPlants(e.toString());
    }
  }

  void searchPlants(String query) {
    final searchQuery = query.trim().toLowerCase();

    if (searchQuery.isEmpty) {
      filteredPlants = List.from(allPlants);
    } else {
      filteredPlants = allPlants.where((plant) {
        final name = plant.name?.toLowerCase() ?? '';
        final species = plant.species?.toLowerCase() ?? '';

        return name.contains(searchQuery) ||
            species.contains(searchQuery);
      }).toList();
    }

    emit(
      GetALLPlantSuccess(
        filteredPlants,
        "Success",
      ),
    );
  }

  Future<List<PlantModel>> _loadCachedPlants(
      String errorMessage,
      ) async {
    try {
      final cachedData = getIt<CacheHelper>().getDataString(
        key: ApiKeys.cachedPlants,
      );

      if (cachedData == null || cachedData.isEmpty) {
        emit(PlantError(errorMessage));
        return [];
      }

      final List<dynamic> decoded = jsonDecode(cachedData);

      allPlants = decoded
          .map(
            (plant) => PlantModel.fromJson(
          plant as Map<String, dynamic>,
        ),
      )
          .toList();

      filteredPlants = List.from(allPlants);

      emit(
        GetALLPlantSuccess(
          filteredPlants,
          "Loaded from local storage",
        ),
      );

      return allPlants;
    } catch (e) {
      emit(PlantError(errorMessage));
      return [];
    }
  }
  void clearSearch() {
    filteredPlants = List.from(allPlants);

    emit(
      GetALLPlantSuccess(
        filteredPlants,
        "Success",
      ),
    );
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

  Future<void> updatePlantAI(String plantId, AiAnalysisModel result) async {
    emit(PlantLoading());

    try {
      print('UPDATE AI URL: ${ApiEndpoints.updatePlantAi(plantId)}');
      final response = await api.put(
        ApiEndpoints.updatePlantAi(plantId),
        data: {
          'health_status': result.healthStatus,
          'health_score': result.healthScore,
          'watering_advice': result.wateringAdvice,
          'sunlight_advice': result.sunlightAdvice,
          'fertilizer_advice': result.fertilizerAdvice,
          'disease': result.disease,
          'confidence': result.confidence,
          'recommendation': result.recommendation,
        },
      );

      plant = PlantModel.fromJson(response['plant']);

      emit(PlantSuccess(plant!, "Plant Analysis Updated Successfully"));

      await getPlant();
    } on ServerException catch (e) {
      emit(PlantError(e.errorModel.errorMessage));
    }
  }
}

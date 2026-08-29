part of 'plant_cubit.dart';

@immutable
sealed class PlantState {}

final class PlantInitial extends PlantState {}

final class PlantLoading extends PlantState {}

final class PlantSuccess extends PlantState {
  final PlantModel plant;
  final String message;

  PlantSuccess(this.plant, this.message);
}

final class GetALLPlantSuccess extends PlantState {
  final List<PlantModel> plants;
  final String message;

  GetALLPlantSuccess(this.plants, this.message);
}

final class PlantError extends PlantState {
  final String message;

  PlantError(this.message);
}

final class UploadPlantImage extends PlantState {}

final class UploadPlantImageSuccess extends PlantState {
  final String message;

  UploadPlantImageSuccess(this.message);
}

final class UploadPlantImageError extends PlantState {
  final String message;

  UploadPlantImageError(this.message);
}

final class UpdatePlantAILoading extends PlantState {}

final class UpdatePlantAIError extends PlantState {
  final String message;

  UpdatePlantAIError(this.message);
}

final class UpdatePlantAISuccess extends PlantState {
  final PlantModel plant;
  final String message;

  UpdatePlantAISuccess(this.plant, this.message);
}

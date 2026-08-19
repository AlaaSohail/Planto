import 'package:plant_care/controllers/paths/ApiEndpoints.dart';

class PlantModel {
  final String? plantId;
  final String? name;
  final String? species;
  final String? imageUrl;
  final String? description;

  PlantModel({
    required this.plantId,
    required this.name,
    required this.species,
    required this.imageUrl,
    this.description,
  });

  factory PlantModel.fromJson(Map<String, dynamic> jsonData) {
    return PlantModel(
      plantId: jsonData[PlantApiKeys.plantId].toString(),
      name: jsonData[PlantApiKeys.plantName],
      species: jsonData[PlantApiKeys.species],
      imageUrl: jsonData[PlantApiKeys.imageUrl],
      description: jsonData[PlantApiKeys.description],
    );
  }
}

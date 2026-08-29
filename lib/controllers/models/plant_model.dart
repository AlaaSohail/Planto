import 'package:plant_care/controllers/paths/ApiEndpoints.dart';

class PlantModel {
  final String? plantId;
  final String? name;
  final String? species;
  final String? imageUrl;
  final String? description;

  // AI Analysis Data
  final String? healthStatus;
  final double? healthScore;
  final String? wateringAdvice;
  final String? sunlightAdvice;
  final String? fertilizerAdvice;
  final String? disease;
  final double? confidence;
  final String? recommendation;

  PlantModel({
    this.plantId,
    this.name,
    this.species,
    this.imageUrl,
    this.description,

    this.healthStatus,
    this.healthScore,
    this.wateringAdvice,
    this.sunlightAdvice,
    this.fertilizerAdvice,
    this.disease,
    this.confidence,
    this.recommendation,
  });

  factory PlantModel.fromJson(Map<String, dynamic> jsonData) {
    return PlantModel(
      plantId: jsonData[PlantApiKeys.plantId]?.toString(),

      name: jsonData[PlantApiKeys.plantName]?.toString(),

      species: jsonData[PlantApiKeys.species]?.toString(),

      imageUrl: jsonData[PlantApiKeys.imageUrl]?.toString(),

      description: jsonData[PlantApiKeys.description]?.toString(),

      // AI Data
      healthStatus: jsonData['health_status']?.toString(),

      healthScore: jsonData['health_score'] != null
          ? double.tryParse(
        jsonData['health_score'].toString(),
      )
          : null,

      wateringAdvice:
      jsonData['watering_advice']?.toString(),

      sunlightAdvice:
      jsonData['sunlight_advice']?.toString(),

      fertilizerAdvice:
      jsonData['fertilizer_advice']?.toString(),

      disease:
      jsonData['disease']?.toString(),

      confidence: jsonData['confidence'] != null
          ? double.tryParse(
        jsonData['confidence'].toString(),
      )
          : null,

      recommendation:
      jsonData['recommendation']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': plantId,
      'name': name,
      'species': species,
      'image_url': imageUrl,
      'description': description,

      'health_status': healthStatus,
      'health_score': healthScore,
      'watering_advice': wateringAdvice,
      'sunlight_advice': sunlightAdvice,
      'fertilizer_advice': fertilizerAdvice,
      'disease': disease,
      'confidence': confidence,
      'recommendation': recommendation,
    };
  }
}
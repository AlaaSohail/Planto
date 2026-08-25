class AiAnalysisModel {
  final int id;
  final int plantId;

  final String disease;
  final double confidence;
  final String recommendation;

  final String? imageUrl;
  final String? imagePublicId;

  final DateTime? createdAt;

  final String plantName;
  final String healthStatus;

  final double healthScore;

  final String wateringAdvice;
  final String sunlightAdvice;
  final String fertilizerAdvice;

  AiAnalysisModel({
    this.id = 0,
    this.plantId = 0,

    required this.disease,
    required this.confidence,
    required this.recommendation,

    this.imageUrl,
    this.imagePublicId,

    this.createdAt,

    required this.plantName,
    required this.healthStatus,

    this.healthScore = 0,

    required this.wateringAdvice,
    required this.sunlightAdvice,
    required this.fertilizerAdvice,
  });

  factory AiAnalysisModel.fromJson(Map<String, dynamic> json) {
    return AiAnalysisModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,

      plantId: int.tryParse(json['plant_id']?.toString() ?? '0') ?? 0,

      disease: json['disease']?.toString() ?? '',

      confidence: double.tryParse(json['confidence']?.toString() ?? '0') ?? 0.0,

      recommendation: json['recommendation']?.toString() ?? '',

      imageUrl: json['image_url']?.toString(),

      imagePublicId: json['image_public_id']?.toString(),

      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,

      plantName: json['plant_name']?.toString() ?? '',

      healthStatus: json['health_status']?.toString() ?? '',

      healthScore:
          double.tryParse(json['health_score']?.toString() ?? '0') ?? 0.0,

      wateringAdvice: json['watering_advice']?.toString() ?? '',

      sunlightAdvice: json['sunlight_advice']?.toString() ?? '',

      fertilizerAdvice: json['fertilizer_advice']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'plant_id': plantId,

      'disease': disease,

      'confidence': confidence,

      'recommendation': recommendation,

      'image_url': imageUrl,

      'image_public_id': imagePublicId,

      'created_at': createdAt?.toIso8601String(),

      'plant_name': plantName,

      'health_status': healthStatus,

      'health_score': healthScore,

      'watering_advice': wateringAdvice,

      'sunlight_advice': sunlightAdvice,

      'fertilizer_advice': fertilizerAdvice,
    };
  }
}

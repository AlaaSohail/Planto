import '../../paths/ApiEndpoints.dart';

class ErrorModel {
  final bool status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      status: jsonData[ApiKeys.success],
      errorMessage: jsonData[ApiKeys.message],
    );
  }
}

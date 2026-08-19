import '../paths/ApiEndpoints.dart';

class RegisterModel {
  final bool success;
  final String message;

  RegisterModel({required this.message, required this.success});

  factory RegisterModel.fromMap(Map<String, dynamic> jsonData) {
    return RegisterModel(
      message: jsonData[ApiKeys.message],
      success: jsonData[ApiKeys.success],
    );
  }
}

import 'package:plant_care/controllers/paths/ApiEndpoints.dart';

class LoginModel {
  final String message;
  final String token;

  LoginModel({required this.message, required this.token});

  factory LoginModel.fromMap(Map<String, dynamic> jsonData) {
    return LoginModel(
      message: jsonData[ApiKeys.message],
      token: jsonData[ApiKeys.token],
    );
  }
}

import 'package:plant_care/controllers/paths/ApiEndpoints.dart';

class UserModel {
  final String name;
  final String email;
  final String? phoneNumber;
  final String? image;
  final double? latitude;
  final double? longitude;
  final String? country;
  final String? city;

  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.image,
    this.latitude,
    this.longitude,
    this.country,
    this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      name: jsonData[ApiKeys.name],
      email: jsonData[ApiKeys.email],
      phoneNumber: jsonData[ApiKeys.phone],
      image: jsonData[ApiKeys.image],
      latitude: jsonData["latitude"] != null
          ? double.parse(jsonData["latitude"].toString())
          : null,
      longitude: jsonData["longitude"] != null
          ? double.parse(jsonData["longitude"].toString())
          : null,
      country: jsonData["country"],
      city: jsonData["city"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.name: name,
      ApiKeys.email: email,
      ApiKeys.phone: phoneNumber,
      ApiKeys.image: image,
      "latitude": latitude,
      "longitude": longitude,
      "country": country,
      "city": city,
    };
  }
}
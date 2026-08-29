import 'package:dio/dio.dart';
import 'error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}

void handleDioExceptions(DioException e) {
  // إذا السيرفر رجّع Response
  if (e.response?.data != null) {
    final data = e.response!.data;

    if (data is Map<String, dynamic>) {
      throw ServerException(
        errorModel: ErrorModel.fromJson(data),
      );
    }
  }

  // لا يوجد اتصال بالإنترنت
  if (e.type == DioExceptionType.connectionError) {
    throw ServerException(
      errorModel: ErrorModel(
        status: false,
        errorMessage: 'No internet connection',
      ),
    );
  }

  // Timeout
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    throw ServerException(
      errorModel: ErrorModel(
        status: false,
        errorMessage: 'Connection timeout',
      ),
    );
  }

  // باقي الأخطاء
  throw ServerException(
    errorModel: ErrorModel(
      status: false,
      errorMessage: 'Something went wrong',
    ),
  );
}
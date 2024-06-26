import 'package:dio/dio.dart';

class ErrorEntity {
  final String message;
  final String? errorMessage;
  final dynamic error;
  final StackTrace? stackTrace;

  ErrorEntity(
      {required this.message, this.errorMessage, this.error, this.stackTrace});

  factory ErrorEntity.fromException(dynamic error) {
    if (error is ErrorEntity) {
      return error;
    }
    final entity = ErrorEntity(
      message: 'Неизветсная ошибка',
    );
    if (error is DioException) {
      try {
        return ErrorEntity(
          message: error.response?.data['message'],
          errorMessage: error.response?.data['error'],
          error: error,
          stackTrace: error.stackTrace,
        );
      } catch (_) {
        return entity;
      }
    }
    return entity;
  }
}

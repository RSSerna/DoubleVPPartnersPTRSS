import 'dart:convert';

abstract class AppException implements Exception {
  final String message;
  final String code;
  final dynamic data;

  AppException({
    required this.message,
    required this.code,
    this.data,
  });

  @override
  String toString() {
    return 'AppException: [$code] $message${data != null ? '\nData: ${jsonEncode(data)}' : ''}';
  }
}

class ValidationException extends AppException {
  ValidationException({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    super.data,
  });
}

class StorageException extends AppException {
  StorageException({
    required super.message,
    super.code = 'STORAGE_ERROR',
    super.data,
  });
}

class UnexpectedException extends AppException {
  UnexpectedException({
    required super.message,
    super.code = 'UNEXPECTED_ERROR',
    super.data,
  });
}

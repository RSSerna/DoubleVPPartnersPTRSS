import 'dart:convert';

import '../constants/app_strings.dart';

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
    String? message,
    super.data,
  }) : super(
          message: message ?? AppStrings.validationExceptionMessage,
          code: AppStrings.validationErrorCode,
        );
}

class StorageException extends AppException {
  StorageException({
    String? message,
    super.data,
  }) : super(
          message: message ?? AppStrings.storageExceptionMessage,
          code: AppStrings.storageErrorCode,
        );
}

class UnexpectedException extends AppException {
  UnexpectedException({
    String? message,
    super.data,
  }) : super(
          message: message ?? AppStrings.unexpectedExceptionMessage,
          code: AppStrings.unexpectedErrorCode,
        );
}

class NetworkException extends AppException {
  NetworkException({
    String? message,
    super.data,
  }) : super(
          message: message ?? AppStrings.networkExceptionMessage,
          code: AppStrings.networkErrorCode,
        );
}

class NotFoundException extends AppException {
  NotFoundException({
    String? message,
    super.data,
  }) : super(
          message: message ?? AppStrings.notFoundExceptionMessage,
          code: AppStrings.notFoundErrorCode,
        );
}

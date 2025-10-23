import 'package:flutter/material.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

class ErrorHandler {
  static Failure handleException(AppException exception,
      [StackTrace? stackTrace]) {
    switch (exception.runtimeType) {
      case ValidationException _:
        return ValidationFailure(
          message: exception.message,
          stackTrace: stackTrace,
        );
      case StorageException _:
        return StorageFailure(
          message: exception.message,
          stackTrace: stackTrace,
        );
      case NetworkException _:
        return NetworkFailure(
          message: exception.message,
          stackTrace: stackTrace,
        );
      case NotFoundException _:
        return NotFoundFailure(
          message: exception.message,
          stackTrace: stackTrace,
        );
      default:
        return UnexpectedFailure(
          message: exception.message,
          stackTrace: stackTrace,
        );
    }
  }

  static void showErrorSnackBar(
    BuildContext context,
    Failure failure, {
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.red,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(failure.message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: duration,
      ),
    );
  }
}

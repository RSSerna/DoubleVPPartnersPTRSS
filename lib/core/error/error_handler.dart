import 'package:flutter/material.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

class ErrorHandler {
  static Failure handleException(AppException exception) {
    switch (exception.runtimeType) {
      case const (ValidationException):
        return ValidationFailure(
          message: exception.message,
        );
      case const (StorageException):
        return StorageFailure(
          message: exception.message,
        );
      default:
        return UnexpectedFailure(
          message: exception.message,
        );
    }
  }

  static void showErrorSnackBar(BuildContext context, Failure failure) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(failure.message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

import 'package:equatable/equatable.dart';

import '../constants/app_strings.dart';

abstract class Failure extends Equatable {
  final String message;
  final String code;
  final StackTrace? stackTrace;

  const Failure({
    required this.message,
    required this.code,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [message, code, stackTrace];

  @override
  String toString() => '$runtimeType: [$code] $message';
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    String? message,
    super.stackTrace,
  }) : super(
          message: message ?? AppStrings.validationExceptionMessage,
          code: AppStrings.validationErrorCode,
        );
}

class StorageFailure extends Failure {
  const StorageFailure({
    String? message,
    super.stackTrace,
  }) : super(
          message: message ?? AppStrings.storageExceptionMessage,
          code: AppStrings.storageErrorCode,
        );
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    String? message,
    super.stackTrace,
  }) : super(
          message: message ?? AppStrings.unexpectedExceptionMessage,
          code: AppStrings.unexpectedErrorCode,
        );
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    String? message,
    super.stackTrace,
  }) : super(
          message: message ?? AppStrings.networkExceptionMessage,
          code: AppStrings.networkErrorCode,
        );
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    String? message,
    super.stackTrace,
  }) : super(
          message: message ?? AppStrings.notFoundExceptionMessage,
          code: AppStrings.notFoundErrorCode,
        );
}

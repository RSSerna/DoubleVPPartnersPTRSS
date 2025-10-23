import 'package:equatable/equatable.dart';

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
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    super.stackTrace,
  });
}

class StorageFailure extends Failure {
  const StorageFailure({
    required super.message,
    super.code = 'STORAGE_ERROR',
    super.stackTrace,
  });
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    required super.message,
    super.code = 'UNEXPECTED_ERROR',
    super.stackTrace,
  });
}

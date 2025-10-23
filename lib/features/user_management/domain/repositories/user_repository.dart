import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  /// Load the cached user (not wrapped in Either). Returns null when not found.
  Future<Either<Failure, UserEntity>> loadUser();
  Future<Either<Failure, UserEntity>> createSaveUser(UserEntity user);
}

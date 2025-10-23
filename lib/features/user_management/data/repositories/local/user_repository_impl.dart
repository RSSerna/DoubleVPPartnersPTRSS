import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/error/error_handler.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../datasources/user_local_data_source.dart';
import '../../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource _localDataSource;
  UserRepositoryImpl({required UserLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<Either<Failure, UserEntity>> createSaveUser(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      await _localDataSource.saveCreateUser(userModel);
      return Right(userModel);
    } on AppException catch (e, stackTrace) {
      return Left(ErrorHandler.handleException(e, stackTrace));
    } catch (e, stackTrace) {
      return Left(UnexpectedFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      ));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loadUser() async {
    try {
      final userModel = await _localDataSource.loadUser();
      if (userModel == null) {
        return Left(StorageFailure(
          message: AppStrings.loadError,
        ));
      }
      return Right(userModel);
    } on AppException catch (e, stackTrace) {
      return Left(ErrorHandler.handleException(e, stackTrace));
    } catch (e, stackTrace) {
      return Left(UnexpectedFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      ));
    }
  }
}

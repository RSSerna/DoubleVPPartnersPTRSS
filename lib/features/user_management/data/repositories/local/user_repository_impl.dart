import 'package:dartz/dartz.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/core/error/failures.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/data/datasources/user_local_data_source.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/domain/entities/user_entity.dart';

import '../../../domain/repositories/user_repository.dart';
import '../../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource _localDataSource;
  UserRepositoryImpl({required UserLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<Either<Failure, UserEntity>> createSaveUser(UserEntity user) {
    try {
      final userModel = user as UserModel;
      return _localDataSource
          .saveCreateUser(userModel)
          .then((_) => Right(userModel));
    } catch (e) {
      return Future.value(Left(StorageFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loadUser() {
    // TODO: implement loadUser
    throw UnimplementedError();
  }
}

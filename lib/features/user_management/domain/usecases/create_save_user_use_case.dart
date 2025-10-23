import 'package:dartz/dartz.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/core/core.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/data/models/user_model.dart';

import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class CreateSaveUserUseCase implements UseCase<UserEntity, UserModel> {
  final UserRepository repository;

  CreateSaveUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UserModel params) async {
    return await repository.createSaveUser(params);
  }
}

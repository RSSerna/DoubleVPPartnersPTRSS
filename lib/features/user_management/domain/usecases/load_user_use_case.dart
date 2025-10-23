import 'package:dartz/dartz.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/core/core.dart';

import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class LoadUserUseCase implements UseCase<UserEntity?, NoParams> {
  final UserRepository repository;

  LoadUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.loadUser();
  }
}

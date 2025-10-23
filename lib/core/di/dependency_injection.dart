import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/data/datasources/local/user_local_data_source_impl.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/data/datasources/user_local_data_source.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/domain/usecases/create_save_user_use_case.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/domain/usecases/load_user_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/user_management/data/repositories/local/user_repository_impl.dart';
import '../../features/user_management/domain/repositories/user_repository.dart';
import '../../features/user_management/presentation/bloc/user_bloc.dart';

final getIt = GetIt.instance;

/// Call this at app startup before runApp. It registers SharedPreferences,
/// the local UserRepository implementation and a factory for UserBloc.
Future<void> configureDependencies() async {
  // SharedPreferences (async)
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  //UseCases
  getIt.registerFactory<CreateSaveUserUseCase>(
      () => CreateSaveUserUseCase(getIt<UserRepository>()));

  getIt.registerFactory<LoadUserUseCase>(
      () => LoadUserUseCase(getIt<UserRepository>()));

  // Repositories
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(localDataSource: getIt<UserLocalDataSource>()),
  );

  //Data Sources
  getIt.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(getIt<SharedPreferences>()),
  );

  // Blocs / Cubits
  getIt.registerFactory(() => UserBloc(
      createSaveUserUseCase: getIt<CreateSaveUserUseCase>(),
      loadUserUseCase: getIt<LoadUserUseCase>()));
}

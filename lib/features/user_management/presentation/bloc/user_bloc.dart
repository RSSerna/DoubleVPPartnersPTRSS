import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/core/core.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/data/models/user_model.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/domain/usecases/load_user_use_case.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/user_management.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserEntity? _user;
  final LoadUserUseCase _loadUserUseCase;
  final CreateSaveUserUseCase _createSaveUserUseCase;

  UserBloc({
    required LoadUserUseCase loadUserUseCase,
    required CreateSaveUserUseCase createSaveUserUseCase,
  })  : _loadUserUseCase = loadUserUseCase,
        _createSaveUserUseCase = createSaveUserUseCase,
        super(UserInitial()) {
    on<CreateUserEvent>(_onCreateUser);
    on<AddAddressEvent>(_onAddAddress);
    on<UpdateUser>(_onUpdateUser);

    // Try to load cached user
    _loadCachedUser();
  }

  Future<void> _loadCachedUser() async {
    final cached = await _loadUserUseCase(NoParams());
    cached.fold((_) => null, (user) {
      _user = user;
      add(UpdateUser(user: user));
    });
  }

  Future<void> _onCreateUser(
      CreateUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      _user = UserEntity(
        firstName: event.firstName,
        lastName: event.lastName,
        birthDate: event.birthDate,
      );
      final result = await _createSaveUserUseCase(UserModel.fromEntity(_user!));

      result.fold((failure) => emit(UserError(failure.message)),
          (_) => emit(UserLoaded(_user!)));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onAddAddress(
      AddAddressEvent event, Emitter<UserState> emit) async {
    try {
      if (_user == null) {
        emit(UserError(AppStrings.userNotCreatedError));
        return;
      }

      emit(UserLoading());
      final updatedAddresses = [..._user!.addresses, event.address];
      _user = _user!.copyWith(addresses: updatedAddresses);

      final result = await _createSaveUserUseCase(UserModel.fromEntity(_user!));
      result.fold((failure) => emit(UserError(failure.message)),
          (_) => emit(UserLoaded(_user!)));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserState> emit) {
    try {
      emit(UserLoading());
      _user = event.user;
      _createSaveUserUseCase(UserModel.fromEntity(_user!));
      emit(UserLoaded(_user!));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_strings.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;
  User? _user;

  UserBloc({UserRepository? repository})
      : _repository = repository ?? UserRepository(),
        super(UserInitial()) {
    on<CreateUser>(_onCreateUser);
    on<AddAddress>(_onAddAddress);
    on<UpdateUser>(_onUpdateUser);

    // Try to load cached user
    _loadCachedUser();
  }

  Future<void> _loadCachedUser() async {
    final cached = await _repository.loadUser();
    if (cached != null) {
      _user = cached;
      add(UpdateUser(user: cached));
    }
  }

  void _onCreateUser(CreateUser event, Emitter<UserState> emit) {
    try {
      emit(UserLoading());
      _user = User(
        firstName: event.firstName,
        lastName: event.lastName,
        birthDate: event.birthDate,
      );
      // persist (fire-and-forget)
      _repository.saveUser(_user!);
      emit(UserLoaded(_user!));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onAddAddress(AddAddress event, Emitter<UserState> emit) {
    try {
      if (_user == null) {
        throw Exception(AppStrings.userNotCreatedError);
      }
      emit(UserLoading());
      final updatedAddresses = [..._user!.addresses, event.address];
      _user = _user!.copyWith(addresses: updatedAddresses);
      _repository.saveUser(_user!);
      emit(UserLoaded(_user!));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserState> emit) {
    try {
      emit(UserLoading());
      _user = event.user;
      _repository.saveUser(_user!);
      emit(UserLoaded(_user!));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}

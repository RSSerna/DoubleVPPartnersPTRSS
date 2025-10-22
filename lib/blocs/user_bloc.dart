import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  User? _user;

  UserBloc() : super(UserInitial()) {
    on<CreateUser>(_onCreateUser);
    on<AddAddress>(_onAddAddress);
    on<UpdateUser>(_onUpdateUser);
  }

  void _onCreateUser(CreateUser event, Emitter<UserState> emit) {
    try {
      emit(UserLoading());
      _user = User(
        firstName: event.firstName,
        lastName: event.lastName,
        birthDate: event.birthDate,
      );
      emit(UserLoaded(_user!));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onAddAddress(AddAddress event, Emitter<UserState> emit) {
    try {
      if (_user == null) {
        throw Exception('User not created yet');
      }
      emit(UserLoading());
      final updatedAddresses = [..._user!.addresses, event.address];
      _user = _user!.copyWith(addresses: updatedAddresses);
      emit(UserLoaded(_user!));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserState> emit) {
    try {
      emit(UserLoading());
      _user = event.user;
      emit(UserLoaded(_user!));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}

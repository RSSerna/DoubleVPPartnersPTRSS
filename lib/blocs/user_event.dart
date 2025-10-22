import 'package:equatable/equatable.dart';

import '../models/address.dart';
import '../models/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class CreateUser extends UserEvent {
  final String firstName;
  final String lastName;
  final DateTime birthDate;

  const CreateUser({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  @override
  List<Object?> get props => [firstName, lastName, birthDate];
}

class AddAddress extends UserEvent {
  final Address address;

  const AddAddress({required this.address});

  @override
  List<Object?> get props => [address];
}

class UpdateUser extends UserEvent {
  final User user;

  const UpdateUser({required this.user});

  @override
  List<Object?> get props => [user];
}

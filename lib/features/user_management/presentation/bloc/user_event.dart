import 'package:equatable/equatable.dart';

import '../../domain/entities/address_entity.dart';
import '../../domain/entities/user_entity.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserEvent extends UserEvent {
  final String firstName;
  final String lastName;
  final DateTime birthDate;

  const CreateUserEvent({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  @override
  List<Object?> get props => [firstName, lastName, birthDate];
}

class AddAddressEvent extends UserEvent {
  final AddressEntity address;

  const AddAddressEvent({required this.address});

  @override
  List<Object?> get props => [address];
}

class UpdateUser extends UserEvent {
  final UserEntity user;

  const UpdateUser({required this.user});

  @override
  List<Object?> get props => [user];
}

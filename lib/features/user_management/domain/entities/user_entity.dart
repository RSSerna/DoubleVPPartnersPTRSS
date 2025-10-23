import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'address_entity.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final List<AddressEntity> addresses;

  UserEntity({
    String? id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    List<AddressEntity>? addresses,
  })  : id = id ?? const Uuid().v4(),
        addresses = addresses ?? [];

  @override
  List<Object?> get props => [id, firstName, lastName, birthDate, addresses];

  UserEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    List<AddressEntity>? addresses,
  }) {
    return UserEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, firstName: $firstName, lastName: $lastName, birthDate: $birthDate, addresses: $addresses)';
  }
}

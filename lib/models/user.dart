import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'address.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final List<Address> addresses;

  User({
    String? id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    List<Address>? addresses,
  })  : id = id ?? const Uuid().v4(),
        addresses = addresses ?? [];

  @override
  List<Object?> get props => [id, firstName, lastName, birthDate, addresses];

  User copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    List<Address>? addresses,
  }) {
    return User(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      addresses: addresses ?? this.addresses,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _id: id,
      _firstName: firstName,
      _lastName: lastName,
      _birthDate: birthDate.toIso8601String(),
      _addresses: addresses.map((address) => address.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json[_id] as String,
      firstName: json[_firstName] as String,
      lastName: json[_lastName] as String,
      birthDate: DateTime.parse(json[_birthDate] as String),
      addresses: (json[_addresses] as List)
          .map((address) => Address.fromJson(address as Map<String, dynamic>))
          .toList(),
    );
  }

  static const String _id = 'id';
  static const String _firstName = 'firstName';
  static const String _lastName = 'lastName';
  static const String _birthDate = 'birthDate';
  static const String _addresses = 'addresses';
}

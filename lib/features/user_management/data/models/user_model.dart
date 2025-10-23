import '../../domain/entities/user_entity.dart';
import 'address_model.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    required super.firstName,
    required super.lastName,
    required super.birthDate,
    List<AddressModel> super.addresses = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[_id] as String,
      firstName: json[_firstName] as String,
      lastName: json[_lastName] as String,
      birthDate: DateTime.parse(json[_birthDate] as String),
      addresses: (json[_addresses] as List)
          .map((address) =>
              AddressModel.fromJson(address as Map<String, dynamic>))
          .toList(),
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      firstName: user.firstName,
      lastName: user.lastName,
      birthDate: user.birthDate,
      addresses: user.addresses
          .map((address) => AddressModel.fromEntity(address))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _id: id,
      _firstName: firstName,
      _lastName: lastName,
      _birthDate: birthDate.toIso8601String(),
      _addresses: addresses
          .map((address) => (address as AddressModel).toJson())
          .toList(),
    };
  }

  static const String _id = 'id';
  static const String _firstName = 'firstName';
  static const String _lastName = 'lastName';
  static const String _birthDate = 'birthDate';
  static const String _addresses = 'addresses';
}

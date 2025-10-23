import '../../domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    super.id,
    required super.country,
    required super.department,
    required super.municipality,
  });

  factory AddressModel.fromEntity(AddressEntity address) {
    return AddressModel(
      country: address.country,
      department: address.department,
      municipality: address.municipality,
    );
  }
  AddressEntity toEntity() {
    return AddressEntity(
      id: id,
      country: country,
      department: department,
      municipality: municipality,
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json[_id] as String?,
      country: json[_country] as String,
      department: json[_department] as String,
      municipality: json[_municipality] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _id: id,
      _country: country,
      _department: department,
      _municipality: municipality,
    };
  }

  static const String _id = 'id';
  static const String _country = 'country';
  static const String _department = 'department';
  static const String _municipality = 'municipality';
}

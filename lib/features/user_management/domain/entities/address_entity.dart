import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class AddressEntity extends Equatable {
  final String id;
  final String country;
  final String department;
  final String municipality;

  AddressEntity({
    String? id,
    required this.country,
    required this.department,
    required this.municipality,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [id, country, department, municipality];

  AddressEntity copyWith({
    String? country,
    String? department,
    String? municipality,
  }) {
    return AddressEntity(
      id: id,
      country: country ?? this.country,
      department: department ?? this.department,
      municipality: municipality ?? this.municipality,
    );
  }

  @override
  String toString() {
    return 'AddressEntity(id: $id, country: $country, department: $department, municipality: $municipality)';
  }
}

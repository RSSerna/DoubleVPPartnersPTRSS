import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Address extends Equatable {
  final String id;
  final String country;
  final String department;
  final String municipality;

  Address({
    String? id,
    required this.country,
    required this.department,
    required this.municipality,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [id, country, department, municipality];

  Address copyWith({
    String? country,
    String? department,
    String? municipality,
  }) {
    return Address(
      id: id,
      country: country ?? this.country,
      department: department ?? this.department,
      municipality: municipality ?? this.municipality,
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

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json[_id] as String,
      country: json[_country] as String,
      department: json[_department] as String,
      municipality: json[_municipality] as String,
    );
  }

  static const String _id = 'id';
  static const String _country = 'country';
  static const String _department = 'department';
  static const String _municipality = 'municipality';
}

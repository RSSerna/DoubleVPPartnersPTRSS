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
      'id': id,
      'country': country,
      'department': department,
      'municipality': municipality,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as String,
      country: json['country'] as String,
      department: json['department'] as String,
      municipality: json['municipality'] as String,
    );
  }
}

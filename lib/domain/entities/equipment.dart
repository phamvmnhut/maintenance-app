// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Equipment extends Equatable {
  final String id;
  final String model_id;
  final String name;

  const Equipment({
    required this.id,
    required this.model_id,
    required this.name,
  });

  @override
  List<Object> get props => [id, model_id, name];

  Equipment copyWith({
    String? id,
    String? model_id,
    String? name,
  }) {
    return Equipment(
      id: id ?? this.id,
      model_id: model_id ?? this.model_id,
      name: name ?? this.name,
    );
  }

  factory Equipment.fromJson(json) {
    return Equipment(
      id: json.id,
      model_id: json['model_id'],
      name: json["name"],
    );
  }
  Map<String, Object?> toJson() => <String, dynamic>{
        'model_id': model_id,
        'name': name,
      };
}

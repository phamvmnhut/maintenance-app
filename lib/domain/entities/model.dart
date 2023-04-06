// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Model extends Equatable {
  final String id;
  final String device_id;
  final String name;
  final int count;

  const Model({
    required this.id,
    required this.device_id,
    required this.name,
     required this.count,
  });

  @override
  List<Object> get props => [id, device_id, name, count];

  Model copyWith({
    String? id,
    String? device_id,
    String? name,
    int? count,
  }) {
    return Model(
      id: id ?? this.id,
      device_id: device_id ?? this.device_id,
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }

  factory Model.fromJson(json) {
    return Model(
      id: json.id,
      device_id: json['device_id'],
      name: json["name"],
      count: json['count'],
    );
  }
    Map<String, Object?> toJson() =>
      <String, dynamic>{
        'device_id': device_id,
        'name': name,
        'count': count
      };
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Model extends Equatable {
  final String name;
  final String id;
  final String device_id;
  final int count;

  const Model({
    required this.name,
    required this.id,
    required this.device_id,
    required this.count,
  });

  @override
  List<Object> get props => [name, id, device_id, count];

  Model copyWith({
    String? name,
    String? id,
    String? device_id,
    int? count,
  }) {
    return Model(
      name: name ?? this.name,
      id: id ?? this.id,
      device_id: device_id ?? this.device_id,
      count: count ?? this.count,
    );
  }

  factory Model.fromJson(json) {
    return Model(
      name: json["name"],
      id: json.id,
      device_id: json['device_id'],
      count: json['count'],
    );
  }
}

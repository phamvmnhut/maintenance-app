// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Equipment extends Equatable {
  final String name;
  final String id;
  final String model_id;

  const Equipment({
    required this.name,
    required this.id,
    required this.model_id,
  });

  @override
  List<Object> get props => [name, id, model_id];

  Equipment copyWith({
    String? name,
    String? id,
    String? model_id,
  }) {
    return Equipment(
      name: name ?? this.name,
      id: id ?? this.id,
      model_id: model_id ?? this.model_id,
    );
  }
}

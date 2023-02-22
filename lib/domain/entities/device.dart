// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Device extends Equatable {
  final String name;
  final String id;
  final int count;

  const Device({
    required this.name,
    required this.id,
    required this.count,
  });

  @override
  List<Object> get props => [name, id, count];

  Device copyWith({
    String? name,
    String? id,
    int? count,
  }) {
    return Device(
      name: name ?? this.name,
      id: id ?? this.id,
      count: count ?? this.count,
    );
  }

  factory Device.fromJson(DocumentSnapshot json) {
    return Device(
      name: json["name"],
      id: json.id,
      count: json['count'] as int,
    );
  }

  Map<String, Object?> toJson() =>
    <String, dynamic>{
      'name': name,
      'id': id,
      'count': count,
    };
}

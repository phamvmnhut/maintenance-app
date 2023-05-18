// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Device extends Equatable {
  final String id;
  final String name;
  final int count;

  const Device({
    required this.id,
    required this.name,
    required this.count,
  });

  @override
  List<Object> get props => [id, name, count];

  Device copyWith({
    String? id,
    String? name,
    int? count,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }

  factory Device.fromJson(DocumentSnapshot json) {
    return Device(
      id: json.id,
      name: json["name"],
      count: json['count'] as int,
    );
  }

  Map<String, Object?> toJson() =>
    <String, dynamic>{
      'name': name,
      'count': count,
    };
}

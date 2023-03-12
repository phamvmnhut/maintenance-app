// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Care extends Equatable {
  final String name;
  final String id;
  final int count;

  const Care({
    required this.name,
    required this.id,
    required this.count,
  });

  @override
  List<Object> get props => [name, id, count];

  Care copyWith({
    String? name,
    String? id,
    int? count,
  }) {
    return Care(
      name: name ?? this.name,
      id: id ?? this.id,
      count: count ?? this.count,
    );
  }

  factory Care.fromJson(DocumentSnapshot json) {
    return Care(
      name: json["name"],
      id: json.id,
      count: json['count'] as int,
    );
  }

  Map<String, Object?> toJson() => <String, dynamic>{
        'name': name,
        'id': id,
        'count': count,
      };
}

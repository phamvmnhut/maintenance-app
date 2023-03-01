// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CareHistory extends Equatable {
  final String memo;
  final String id;
  final String care_id;
  final DateTime date;
  final String image;

  const CareHistory({
    required this.memo,
    required this.id,
    required this.care_id,
    required this.date,
    required this.image,
  });

  @override
  List<Object> get props => [memo, id, care_id, date];

  CareHistory copyWith({
    String? meno,
    String? id,
    String? care_id,
    DateTime? date,
    String? image,
  }) {
    return CareHistory(
      memo: meno ?? this.memo,
      id: id ?? this.id,
      care_id: care_id ?? this.care_id,
      date: date ?? this.date,
      image: image ?? this.image,
    );
  }

  factory CareHistory.fromJson(DocumentSnapshot json) {
    return CareHistory(
      memo: json["memo"],
      id: json.id,
      care_id: json['care_id'],
      date: (json['date'] as Timestamp).toDate(),
      image: json['care_id'],
    );
  }

  Map<String, Object?> toJson() =>
      <String, dynamic>{
        'meno': memo,
        'id': id,
        'care_id': care_id,
        'date': date,
        'care_id': image,
      };
}

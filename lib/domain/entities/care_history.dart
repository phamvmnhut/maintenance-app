// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CareHistory extends Equatable {
  final String id;
  final String care_id;
  final String memo;
  final DateTime date;
  final String image;

  const CareHistory({
    required this.id,
    required this.care_id,
    required this.memo,
    required this.date,
    required this.image,
  });

  static CareHistory newEmpty() {
    return CareHistory(
      id: '',
      care_id: '',
      memo: '',
      date: DateTime.now(),
      image: '',
    );
  }

  @override
  List<Object> get props => [id, care_id, memo, date];

  CareHistory copyWith({
    String? id,
    String? care_id,
    String? memo,
    DateTime? date,
    String? image,
  }) {
    return CareHistory(
      id: id ?? this.id,
      care_id: care_id ?? this.care_id,
      memo: memo ?? this.memo,
      date: date ?? this.date,
      image: image ?? this.image,
    );
  }

  factory CareHistory.fromJson(DocumentSnapshot json) {
    return CareHistory(
      id: json.id,
      care_id: json['care_id'],
      memo: json["memo"],
      date: (json['date'] as Timestamp).toDate(),
      image: json['image'],
    );
  }

  Map<String, Object?> toJson() => <String, dynamic>{
        'care_id': care_id,
        'memo': memo,
        'date': Timestamp.fromDate(
          DateTime(
            date.year,
            date.month,
            date.day,
            date.hour,
            date.minute,
          ),
        ),
        'image': image,
      };
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class CareHistory extends Equatable {
  final String meno;
  final String id;
  final String care_id;
  final DateTime date;
  final String image;

  const CareHistory({
    required this.meno,
    required this.id,
    required this.care_id,
    required this.date,
    required this.image,
  });

  @override
  List<Object> get props => [meno, id, care_id, date];

  CareHistory copyWith({
    String? meno,
    String? id,
    String? care_id,
    DateTime? date,
    String? image,
  }) {
    return CareHistory(
      meno: meno ?? this.meno,
      id: id ?? this.id,
      care_id: care_id ?? this.care_id,
      date: date ?? this.date,
      image: image ?? this.image,
    );
  }
}

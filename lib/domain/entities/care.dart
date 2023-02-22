// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Care extends Equatable {
  final String memo_name;
  final String id;
  final String user_id;
  final String image;
  final String equipment_id;
  final String repeat;
  final String routine;
  final DateTime start_date;

  const Care({
    required this.memo_name,
    required this.id,
    required this.user_id,
    required this.image,
    required this.equipment_id,
    required this.repeat,
    required this.routine,
    required this.start_date,
  });

  @override
  List<Object> get props => [memo_name, id, user_id, image, equipment_id, repeat, routine, start_date];

  Care copyWith({
    String? memo_name,
    String? id,
    String? user_id,
    String? image,
    String? equipment_id,
    String? repeat,
    String? routine,
    DateTime? start_date,
  }) {
    return Care(
      memo_name: memo_name ?? this.memo_name,
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      image: image ?? this.image,
      equipment_id: equipment_id ?? this.equipment_id,
      repeat: repeat ?? this.repeat,
      routine: routine ?? this.routine,
      start_date: start_date ?? this.start_date,
    );
  }
}

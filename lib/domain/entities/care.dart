// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Care extends Equatable {
  final String id;
  final String user_id;
  final String equipment_id;
  final String memo_name;
  final String image;
  final Timestamp care_next_time;
  final String routine;
  final Timestamp start_date;
  final String status;

  const Care(
      {required this.id,
      required this.user_id,
      required this.equipment_id,
      required this.memo_name,
      required this.image,
      required this.care_next_time,
      required this.routine,
      required this.start_date,
      required this.status});

  @override
  List<Object> get props => [
        id,
        user_id,
        equipment_id,
        memo_name,
        image,
        care_next_time,
        routine,
        start_date,
        status
      ];

  Care copyWith({
    String? id,
    String? user_id,
    String? equipment_id,
    String? memo_name,
    String? image,
    Timestamp? care_next_time,
    String? routine,
    Timestamp? start_date,
    String? status,
  }) {
    return Care(
      memo_name: memo_name ?? this.memo_name,
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      image: image ?? this.image,
      equipment_id: equipment_id ?? this.equipment_id,
      care_next_time: care_next_time ?? this.care_next_time,
      routine: routine ?? this.routine,
      start_date: start_date ?? this.start_date,
      status: status ?? this.status,
    );
  }

  factory Care.fromJson(DocumentSnapshot json) {
    return Care(
      id: json.id,
      user_id: json['user_id'],
      equipment_id: json['equipment_id'],
      memo_name: json["memo_name"],
      image: json['image'],
      care_next_time: json['care_next_time'],
      routine: json['routine'],
      start_date: json['start_date'],
      status: json['status'],
    );
  }
  Map<String, Object?> toJson() => <String, dynamic>{
        'user_id': user_id,
        'equipment_id': equipment_id,
        'memo_name': memo_name,
        'image': image,
        'care_next_time': care_next_time,
        'routine': routine,
        'start_date': start_date,
        'status': status,
      };
  static List<String> RoutineType() {
    return <String>['Days', 'Weeks', 'Months', 'Years'];
  }

  int getNumberInRoutine() {
    return int.parse(routine.split("_")[0]);
  }

  String getTypeInRoutine() {
    return routine.split("_")[1];
  }
}

List<String> list = <String>['Days', 'Weeks', 'Months', 'Years'];

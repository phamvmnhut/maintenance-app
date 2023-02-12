// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'device.dart';

enum DeviceCareTaskStatus {
  notStarted,
  expired,
  done,
}

class DeviceCareTask extends Equatable {
  final Device device;
  final DeviceCareTaskStatus status;
  final String note;
  final DateTime dueDate;
  
  const DeviceCareTask({
    required this.device,
    required this.status,
    required this.note,
    required this.dueDate,
  });

  @override
  List<Object> get props => [device, status, note, dueDate];

  DeviceCareTask copyWith({
    Device? device,
    DeviceCareTaskStatus? status,
    String? note,
    DateTime? dueDate,
  }) {
    return DeviceCareTask(
      device: device ?? this.device,
      status: status ?? this.status,
      note: note ?? this.note,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Device extends Equatable {
  final String name;
  final String code;

  const Device({
    required this.name,
    required this.code,
  });

  @override
  List<Object> get props => [name, code];

  Device copyWith({
    String? name,
    String? code,
  }) {
    return Device(
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }
}

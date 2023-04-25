// ignore_for_file: non_constant_identifier_names

import 'package:divice/domain/entities/care_history.dart';

class CareHistoryRepositoryGetListParam {
  final String care_id;
  CareHistoryRepositoryGetListParam({required this.care_id});
}

abstract class CareHistoryRepository {
  Future<List<CareHistory>> getList({required CareHistoryRepositoryGetListParam param});
  Future<CareHistory> get({required String id});
  Future<bool> update({required String id, required CareHistory data});
  Future<bool> create({required CareHistory d});
  Future<bool> delete({required String id});
}

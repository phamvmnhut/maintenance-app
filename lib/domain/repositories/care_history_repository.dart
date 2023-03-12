import 'package:divice/domain/entities/care_history.dart';

class CareRepositoryGetListParam {
  final String care_id;
  CareRepositoryGetListParam({required this.care_id});
}

abstract class CareRepository {
  Future<List<Care>> getList({required CareRepositoryGetListParam param});
  Future<Care> get({required String id});
  Future<bool> update({required String id, required Care data});
  Future<bool> create({required Care d});
  Future<bool> delete({required String id});
}

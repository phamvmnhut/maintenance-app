import '../entities/care.dart';

class CareRepositoryGetListParam {
  final String careId;
  CareRepositoryGetListParam({
    required this.careId,
  });
}

abstract class CareRepository {
  Future<List<Care>> getList({required CareRepositoryGetListParam param});
  Future<Care> get({required String id});
  Future<bool> update({required String id, required Care data});
  Future<bool> create({required Care d});
  Future<bool> delete({required String id});
}

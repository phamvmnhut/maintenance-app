import '../entities/care.dart';

class CareRepositoryGetListParam {
  final String name;
  bool isSortByCareNextTime = false;
  CareRepositoryGetListParam({required this.name, bool? isSortByCareNextTime}) {
    isSortByCareNextTime = isSortByCareNextTime ?? this.isSortByCareNextTime;
  }
}

class CareRepositorySearchParam {
  final String name;
  CareRepositorySearchParam({
    required this.name,
  });
}

abstract class CareRepository {
  Future<List<Care>> getList({
    required CareRepositoryGetListParam param,
    required userId,
  });
  Future<List<Care>> search({
    required CareRepositorySearchParam param,
    required userId,
  });
  Future<Care?> get({required String id});
  Future<bool> update({required String id, required Care data});
  Future<String> create({required Care d});
  Future<bool> delete({required String id});
}

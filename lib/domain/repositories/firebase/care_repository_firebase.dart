import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divice/domain/entities/care.dart';
import 'package:divice/domain/repositories/care_repository.dart';

class CareRepositoryFireBase extends CareRepository {
  final CollectionReference _careCollection =
      FirebaseFirestore.instance.collection('cares');

  @override
  Future<Care> get({required String id}) {
    return _careCollection.doc(id).get().then((value) => Care.fromJson(value));
  }

  @override
  Future<bool> create({required Care d}) {
    return _careCollection.add(d.toJson()).then((value) => true);
  }

  @override
  Future<bool> delete({required String id}) {
    return _careCollection.doc(id).delete().then((value) => true);
  }

  @override
  Future<List<Care>> getList({required CareRepositoryGetListParam param}) {
    if (param.isSortByCareNextTime) {
      return _careCollection
          .orderBy("care_next_time", descending: true)
          .get()
          .then((value) => value.docs.map((e) => Care.fromJson(e)).toList());
    } else {
      return _careCollection
          .get()
          .then((value) => value.docs.map((e) => Care.fromJson(e)).toList());
    }
  }

  @override
  Future<List<Care>> search({required CareRepositorySearchParam param}) {
    print(param.name);
    return _careCollection
        .where("memo_name", isGreaterThanOrEqualTo: param.name.toUpperCase())
        .get()
        .then((value) => value.docs.map((e) => Care.fromJson(e)).toList());
  }

  @override
  Future<bool> update({required String id, required Care data}) {
    return _careCollection.doc(id).update(data.toJson()).then((value) => true);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maintenance/domain/entities/care.dart';
import 'package:maintenance/domain/repositories/care_repository.dart';

class CareRepositoryFireBase extends CareRepository {
  final CollectionReference _careCollection =
      FirebaseFirestore.instance.collection('cares');

  @override
  Future<Care?> get({required String id}) {
    return _careCollection.doc(id).get().then((value) {
      if (value.exists) {
        return Care.fromJson(value);
      } else {
        return null;
      }
    });
  }

  @override
  Future<String> create({required Care d}) {
    return _careCollection.add(d.toJson()).then((value) => value.id);
  }

  @override
  Future<bool> delete({required String id}) {
    return _careCollection.doc(id).delete().then((value) => true);
  }

  @override
  Future<List<Care>> getList({
    required CareRepositoryGetListParam param,
    required userId,
  }) {
    if (param.isSortByCareNextTime) {
      return _careCollection
          .where('user_id', isEqualTo: userId)
          .orderBy("care_next_time", descending: true)
          .get()
          .then((value) => value.docs.map((e) => Care.fromJson(e)).toList());
    } else {
      return _careCollection
          .where('user_id', isEqualTo: userId)
          .get()
          .then((value) => value.docs.map((e) => Care.fromJson(e)).toList());
    }
  }

  @override
  Future<List<Care>> search({
    required CareRepositorySearchParam param,
    required userId,
  }) {
    return _careCollection
        .where('user_id', isEqualTo: userId)
        .where("memo_name", isGreaterThanOrEqualTo: param.name.toUpperCase())
        .get()
        .then((value) => value.docs.map((e) => Care.fromJson(e)).toList());
  }

  @override
  Future<bool> update({required String id, required Care data}) {
    return _careCollection.doc(id).update(data.toJson()).then((value) => true);
  }
}

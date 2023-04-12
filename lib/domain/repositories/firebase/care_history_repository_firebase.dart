import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divice/domain/entities/care_history.dart';
import 'package:divice/domain/repositories/care_history_repository.dart';

class CareHistoryRepositoryFireBase extends CareHistoryRepository {
  final CollectionReference _deviceCollection =
      FirebaseFirestore.instance.collection('care_histories');

  @override
  Future<CareHistory> get({required String id}) {
    return _deviceCollection
        .doc(id)
        .get()
        .then((value) => CareHistory.fromJson(value));
  }

  @override
  Future<bool> create({required CareHistory d}) {
    return _deviceCollection.add(d.toJson()).then((value) => true);
  }

  @override
  Future<bool> delete({required String id}) {
    return _deviceCollection.doc(id).delete().then((value) => true);
  }

  @override
  Future<List<CareHistory>> getList({required CareHistoryRepositoryGetListParam param}) {
    return _deviceCollection
        .where("care_id", isEqualTo: param.care_id)
        .orderBy('date')
        .get()
        .then(
          (value) => value.docs.map((e) => CareHistory.fromJson(e)).toList(),
        );
  }

  @override
  Future<bool> update({required String id, required CareHistory data}) {
    return _deviceCollection
        .doc(id)
        .update(data.toJson())
        .then((value) => true);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divice/domain/entities/device.dart';
import 'package:divice/domain/repositories/device_repository.dart';

class DeviceRepositoryFireBase extends CareRepository {
  final CollectionReference _deviceCollection =
      FirebaseFirestore.instance.collection('devices');

  @override
  Future<Care> get({required String id}) {
    return _deviceCollection
        .doc(id)
        .get()
        .then((value) => Care.fromJson(value));
  }

  @override
  Future<bool> create({required Care d}) {
    return _deviceCollection.add(d.toJson()).then((value) => true);
  }

  @override
  Future<bool> delete({required String id}) {
    return _deviceCollection.doc(id).delete().then((value) => true);
  }

  @override
  Future<List<Care>> getList({required CareRepositoryGetListParam param}) {
    return _deviceCollection
        .get()
        .then((value) => value.docs.map((e) => Care.fromJson(e)).toList());
  }

  @override
  Future<bool> update({required String id, required Care data}) {
    return _deviceCollection
        .doc(id)
        .update(data.toJson())
        .then((value) => true);
  }
}

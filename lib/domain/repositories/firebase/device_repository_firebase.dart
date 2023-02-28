import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divice/domain/entities/device.dart';
import 'package:divice/domain/repositories/device_repository.dart';

class DeviceRepositoryFireBase extends DeviceRepository {
  final CollectionReference _deviceCollection =
      FirebaseFirestore.instance.collection('devices');

  @override
  Future<Device> get({required String id}) {
    return _deviceCollection
        .doc(id)
        .get()
        .then((value) => Device.fromJson(value));
  }

  @override
  Future<bool> create({required Device d}) {
    return _deviceCollection.add(d.toJson()).then((value) => true);
  }

  @override
  Future<bool> delete({required String id}) {
    return _deviceCollection.doc(id).delete().then((value) => true);
  }

  @override
  Future<List<Device>> getList({required DeviceRepositoryGetListParam param}) {
    return _deviceCollection
        .get()
        .then((value) => value.docs.map((e) => Device.fromJson(e)).toList());
  }

  @override
  Future<bool> update({required String id, required Device data}) {
    return _deviceCollection.doc(id).update(data.toJson()).then((value) => true);
  }
}

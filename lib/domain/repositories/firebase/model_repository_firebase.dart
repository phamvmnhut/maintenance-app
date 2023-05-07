// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divice/domain/entities/model.dart';
import 'package:divice/domain/repositories/model_repository.dart';

class ModelRepositoryFirebase extends ModelRepository {
  final CollectionReference _modelCollection =
      FirebaseFirestore.instance.collection('models');

  @override
  Future<List<Model>> getListModel({required String deviceID}) {
    return _modelCollection
        .where('device_id', isEqualTo: deviceID)
        .get()
        .then((value) {
      return value.docs.map((e) => Model.fromJson(e)).toList();
    });
  }

  @override
  Future<Model> get({required String id}) {
    return _modelCollection
        .doc(id)
        .get()
        .then((value) => Model.fromJson(value));
  }

  @override
  Future<String> create({required Model model}) {
    return _modelCollection.add(model.toJson()).then((value) => value.id);
  }

  @override
  Future<bool> update({required String id, required Model model}) {
    return _modelCollection
        .doc(id)
        .update(model.toJson())
        .then((value) => true);
  }

  @override
  Future<bool> delete({required String id}) {
    return _modelCollection.doc(id).delete().then((value) => true);
  }

  @override
  Future<void> deleteWithDeviceId({required String deviceId}) {
    return _modelCollection
        .where('device_id', isEqualTo: deviceId)
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.delete();
            }));
  }
}

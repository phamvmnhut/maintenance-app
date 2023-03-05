import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divice/domain/entities/model.dart';
import 'package:divice/domain/entities/device.dart';
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
}

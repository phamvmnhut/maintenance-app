// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divice/domain/entities/equipment.dart';
import '../equipment_repository.dart';

class EquipmentRepositoryFirebase extends EquipmentRepository {
  final CollectionReference _equipmentCollection =
      FirebaseFirestore.instance.collection('equipments');
  @override
  Future<List<Equipment>> getListEquipment({required String modelID}) {
    return _equipmentCollection
        .where('model_id', isEqualTo: modelID)
        .get()
        .then((value) {
      return value.docs.map((e) => Equipment.fromJson(e)).toList();
    });
  }

  @override
  Future<Equipment> get({required String id}) {
    return _equipmentCollection
        .doc(id)
        .get()
        .then((value) => Equipment.fromJson(value));
  }

  @override
  Future<bool> create({required Equipment equipment}) {
    return _equipmentCollection.add(equipment.toJson()).then((value) => true);
  }

  @override
  Future<bool> update({required String id, required Equipment equipment}) {
    return _equipmentCollection
        .doc(id)
        .update(equipment.toJson())
        .then((value) => true);
  }

  @override
  Future<bool> delete({required String id}) {
    return _equipmentCollection.doc(id).delete().then((value) => true);
  }

  @override
  Future<void> deleteWithModelId({required String modelId}) {
    return _equipmentCollection
        .where('model_id', isEqualTo: modelId)
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.delete();
            }));
  }
}

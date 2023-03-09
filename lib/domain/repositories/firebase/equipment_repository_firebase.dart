import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divice/domain/entities/equipment.dart';

import '../equipment_repository.dart';

class EquipmentRepositoryFirebase extends EquipmentRepository{
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

}
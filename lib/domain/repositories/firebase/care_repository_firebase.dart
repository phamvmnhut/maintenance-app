import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divice/domain/entities/care.dart';

import '../care_repository.dart';

class CareRepositoryFirebase extends CareRepository {
  final CollectionReference _careCollection =
      FirebaseFirestore.instance.collection('cares');
  @override
  Future<List<Care>> getListEquipment({required String equipmentID}) {
    return _careCollection
        .where('equipment_id', isEqualTo: equipmentID)
        .get()
        .then((value) {
      return value.docs.map((e) => Care.fromJson(e)).toList();
    });
  }
}

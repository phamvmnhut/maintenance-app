import 'package:divice/domain/entities/equipment.dart';

abstract class EquipmentRepository {
  Future<List<Equipment>> getListEquipment({required String modelID});
}
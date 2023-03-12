import 'package:divice/domain/entities/equipment.dart';

abstract class EquipmentRepository {
  Future<List<Equipment>> getListEquipment({required String modelID});
  Future<Equipment> get({required String id});
}

import 'package:divice/domain/entities/equipment.dart';

abstract class EquipmentRepository {
  Future<List<Equipment>> getListEquipment({required String modelID});
  Future<bool> update({required String id, required Equipment equipment});
  Future<bool> create({required Equipment equipment});
  Future<Equipment> get({required String id});
  Future<bool> delete({required String id});
  Future<void> deleteWithModelId({required String modelId});
}

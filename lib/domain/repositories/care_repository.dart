import 'package:divice/domain/entities/care.dart';

abstract class CareRepository{
  Future<List<Care>> getListEquipment({required String equipmentID});
}
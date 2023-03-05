
import 'package:divice/domain/entities/device.dart';
import 'package:divice/domain/entities/model.dart';

abstract class ModelRepository {
  Future<List<Model>> getListModel({required String deviceID});
}
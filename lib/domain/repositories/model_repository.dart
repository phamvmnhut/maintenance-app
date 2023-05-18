import 'package:maintenance/domain/entities/model.dart';

abstract class ModelRepository {
  Future<List<Model>> getListModel({required String deviceID});
  Future<bool> update({required String id, required Model model});
  Future<String> create({required Model model});
  Future<Model> get({required String id});
  Future<bool> delete({required String id});
  Future<void> deleteWithDeviceId({required String deviceId});
}
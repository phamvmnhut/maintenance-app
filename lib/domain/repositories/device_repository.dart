import 'package:divice/domain/entities/device.dart';

class DeviceRepositoryGetListParam {
  final String searchText;
  DeviceRepositoryGetListParam({required this.searchText});
}

abstract class CareRepository {
  Future<List<Device>> getList({required DeviceRepositoryGetListParam param});
  Future<Device> get({required String id});
  Future<bool> update({required String id, required Device data});
  Future<bool> create({required Device d});
  Future<bool> delete({required String id});
}

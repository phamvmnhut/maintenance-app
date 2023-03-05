import 'package:divice/domain/entities/device.dart';
import 'package:divice/domain/entities/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:divice/domain/repositories/device_repository.dart';

import '../domain/repositories/model_repository.dart';

abstract class DeviceEvent {}

class DeviceEventGetList extends DeviceEvent {}

class DeviceEventGetListModel extends DeviceEvent {
  final String deviceID;
  DeviceEventGetListModel({required this.deviceID});
}

class DeviceState {
  List<Device> list;
  Map<String, List<Model>> listModel;

  DeviceState(
      {this.list = const [], this.listModel = const <String, List<Model>>{}});
  DeviceState.initialState() : this(list: []);

  DeviceState copyWith({
    List<Device>? list,
    Map<String, List<Model>>? listModel,
  }) {
    return DeviceState(
        list: list ?? this.list, listModel: listModel ?? this.listModel);
  }
}

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRepository _repository;
  final ModelRepository _modelRepository;

  DeviceBloc(this._repository, this._modelRepository)
      : super(DeviceState.initialState()) {
    on<DeviceEventGetList>(_getList);
    on<DeviceEventGetListModel>(_getListModel);
  }
  void _getList(DeviceEventGetList event, Emitter<DeviceState> emit) async {
    List<Device> l = await _repository.getList(
        param: DeviceRepositoryGetListParam(searchText: ""));
    emit(DeviceState(list: l));
  }

  void _getListModel(
      DeviceEventGetListModel event, Emitter<DeviceState> emit) async {
    List<Model> lstModel =
        await _modelRepository.getListModel(deviceID: event.deviceID);

    Map<String, List<Model>> newListModel = Map.of(state.listModel);

    newListModel[event.deviceID] = lstModel;
    
    emit(state.copyWith(listModel: newListModel));
  }
}

import 'package:dartz/dartz_unsafe.dart';
import 'package:divice/domain/entities/device.dart';
import 'package:divice/domain/entities/equipment.dart';
import 'package:divice/domain/entities/model.dart';
import 'package:divice/domain/repositories/equipment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:divice/domain/repositories/device_repository.dart';

import '../domain/repositories/model_repository.dart';

abstract class DeviceEvent {}

class DeviceEventGetList extends DeviceEvent {}

class DeviceEventGetListModel extends DeviceEvent {
  final String deviceID;
  DeviceEventGetListModel({required this.deviceID});
}

class DeviceEventGetListEquipment extends DeviceEvent {
  final String modelID;
  DeviceEventGetListEquipment({required this.modelID});
}

class DeviceState {
  List<Care> list;
  Map<String, List<Model>> listModel;
  Map<String, List<Equipment>> listEquipment;

  DeviceState(
      {this.list = const [],
      this.listModel = const <String, List<Model>>{},
      this.listEquipment = const <String, List<Equipment>>{}});
  DeviceState.initialState() : this(list: []);

  DeviceState copyWith({
    List<Care>? list,
    Map<String, List<Model>>? listModel,
    Map<String, List<Equipment>>? listEquipment,
  }) {
    return DeviceState(
        list: list ?? this.list,
        listModel: listModel ?? this.listModel,
        listEquipment: listEquipment ?? this.listEquipment);
  }
}

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final CareRepository _repository;
  final ModelRepository _modelRepository;
  final EquipmentRepository _equipmentRepository;

  DeviceBloc(this._repository, this._modelRepository, this._equipmentRepository)
      : super(DeviceState.initialState()) {
    on<DeviceEventGetList>(_getList);
    on<DeviceEventGetListModel>(_getListModel);
    on<DeviceEventGetListEquipment>(_getListEquipment);
  }
  void _getList(DeviceEventGetList event, Emitter<DeviceState> emit) async {
    List<Care> l = await _repository.getList(
        param: CareRepositoryGetListParam(searchText: ""));
    emit(DeviceState(list: l));

    //Sau khi emit danh sách Device thì emit danh sách Model theo device
    Map<String, List<Model>> newListModel = Map.of(state.listModel);
    List<String> listDeviceID = l.map((e) => e.id).toList();
    List<Model> listModel;
    List<Equipment> listEquipment;

    for (var deviceID in listDeviceID) {
      listModel = await _modelRepository.getListModel(deviceID: deviceID);
      newListModel[deviceID] = listModel;

      //Sau khi emit danh sách Model thì emit danh sách Equipment theo Device
      Map<String, List<Equipment>> newListEquipment =
          Map.of(state.listEquipment);
      List<String> listModelID = listModel.map((e) => e.id).toList();

      for (var modelID in listModelID) {
        listEquipment =
            await _equipmentRepository.getListEquipment(modelID: modelID);
        newListEquipment[modelID] = listEquipment;
      }
      emit(state.copyWith(listEquipment: newListEquipment));
    }
    emit(state.copyWith(listModel: newListModel));
  }

  void _getListModel(
      DeviceEventGetListModel event, Emitter<DeviceState> emit) async {
    List<Model> lstModel =
        await _modelRepository.getListModel(deviceID: event.deviceID);

    Map<String, List<Model>> newListModel = Map.of(state.listModel);

    newListModel[event.deviceID] = lstModel;

    emit(state.copyWith(listModel: newListModel));
  }

  void _getListEquipment(
      DeviceEventGetListEquipment event, Emitter<DeviceState> emit) async {
    List<Equipment> lstEquipment =
        await _equipmentRepository.getListEquipment(modelID: event.modelID);

    Map<String, List<Equipment>> newListEquipment = Map.of(state.listEquipment);

    newListEquipment[event.modelID] = lstEquipment;

    emit(state.copyWith(listEquipment: newListEquipment));
  }
}

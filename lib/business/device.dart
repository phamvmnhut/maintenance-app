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

class DeviceEventAddDevice extends DeviceEvent {
  final Device device;
  DeviceEventAddDevice({required this.device});
}

class DeviceEventUpdateDevice extends DeviceEvent {
  final Device device;
  DeviceEventUpdateDevice({required this.device});
}

class DeviceEventAddModel extends DeviceEvent {
  final String modelName;
  final String deviceId;
  DeviceEventAddModel({required this.deviceId, required this.modelName});
}

class DeviceEventUpdateModel extends DeviceEvent {
  final Model model;
  DeviceEventUpdateModel({required this.model});
}

class DeviceEventAddEquipment extends DeviceEvent {
  final Equipment equipment;
  DeviceEventAddEquipment({required this.equipment});
}

class DeviceEventUpdateEquipment extends DeviceEvent {
  final Equipment equipment;
  DeviceEventUpdateEquipment({required this.equipment});
}

class DeviceState {
  List<Device> list;
  Map<String, List<Model>> listModel;
  Map<String, List<Equipment>> listEquipment;

  DeviceState(
      {this.list = const [],
      this.listModel = const <String, List<Model>>{},
      this.listEquipment = const <String, List<Equipment>>{}});
  DeviceState.initialState() : this(list: []);

  DeviceState copyWith({
    List<Device>? list,
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
  final DeviceRepository _repository;
  final ModelRepository _modelRepository;
  final EquipmentRepository _equipmentRepository;

  DeviceBloc(this._repository, this._modelRepository, this._equipmentRepository)
      : super(DeviceState.initialState()) {
    on<DeviceEventGetList>(_getList);
    on<DeviceEventGetListModel>(_getListModel);
    on<DeviceEventGetListEquipment>(_getListEquipment);

    on<DeviceEventAddDevice>(_addDevice);
    on<DeviceEventUpdateDevice>(_updateDevice);
    on<DeviceEventAddModel>(_addModel);
    on<DeviceEventUpdateModel>(_updateModel);

    on<DeviceEventAddEquipment>(_addEquipment);
    on<DeviceEventUpdateEquipment>(_updateEquipment);
  }
  void _getList(DeviceEventGetList event, Emitter<DeviceState> emit) async {
    List<Device> l = await _repository.getList(
        param: DeviceRepositoryGetListParam(searchText: ""));
    // emit(DeviceState(list: l));

    //Sau khi emit danh sách Device thì emit danh sách Model theo device
    Map<String, List<Model>> newListModel = Map.of(state.listModel);
    List<String> listDeviceID = l.map((e) => e.id).toList();
    List<Model> listModel;
    //Equiment
    Map<String, List<Equipment>> newListEquipment = Map.of(state.listEquipment);
    List<Equipment> listEquipment;

    for (var deviceID in listDeviceID) {
      listModel = await _modelRepository.getListModel(deviceID: deviceID);
      newListModel[deviceID] = listModel;

      //Sau khi emit danh sách Model thì emit danh sách Equipment theo Device

      List<String> listModelID = listModel.map((e) => e.id).toList();

      for (var modelID in listModelID) {
        listEquipment =
            await _equipmentRepository.getListEquipment(modelID: modelID);
        newListEquipment[modelID] = listEquipment;
      }
      // emit(state.copyWith(listEquipment: newListEquipment));
    }
    emit(state.copyWith(
        list: l, listModel: newListModel, listEquipment: newListEquipment));
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

  void _addModel(DeviceEventAddModel event, Emitter<DeviceState> emit) async {
    var newModel = Model(
        name: event.modelName, id: '', device_id: event.deviceId, count: 1);
    var modelId = await _modelRepository.create(model: newModel);
    await _equipmentRepository.create(
        equipment: Equipment(name: 'All', id: '', model_id: modelId));
    emit(state);
  }

  void _updateModel(
      DeviceEventUpdateModel event, Emitter<DeviceState> emit) async {
    await _modelRepository.update(id: event.model.id, model: event.model);
    emit(state);
  }

  void _addEquipment(
      DeviceEventAddEquipment event, Emitter<DeviceState> emit) async {
    await _equipmentRepository.create(equipment: event.equipment);
    Model modelOld = await _modelRepository.get(id: event.equipment.model_id);

    await _modelRepository.update(
        id: event.equipment.model_id,
        model: Model(
            name: modelOld.name,
            id: modelOld.id,
            device_id: modelOld.device_id,
            count: modelOld.count + 1));
    emit(state);
  }

  void _updateEquipment(
      DeviceEventUpdateEquipment event, Emitter<DeviceState> emit) async {
    await _equipmentRepository.update(
        id: event.equipment.id, equipment: event.equipment);
    emit(state);
  }

  void _addDevice(DeviceEventAddDevice event, Emitter<DeviceState> emit) async {
    await _repository.create(d: event.device);
    emit(state);
  }

  void _updateDevice(
      DeviceEventUpdateDevice event, Emitter<DeviceState> emit) async {
    await _repository.update(id: event.device.id, data: event.device);
    emit(state);
  }
}

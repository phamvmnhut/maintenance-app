import 'package:divice/domain/entities/device.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:divice/domain/repositories/device_repository.dart';

abstract class DeviceEvent {}
class DeviceEventGetList extends DeviceEvent{}

class DeviceState {
  List<Device> list;

  DeviceState({required this.list});
  DeviceState.initialState()
      : this(list: []);
}

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRepository _repository;

  DeviceBloc(this._repository) : super(DeviceState.initialState()) {
    on<DeviceEventGetList>(_getList);
  }
  void _getList(DeviceEventGetList event, Emitter<DeviceState> emit) async {
    List<Device> l = await _repository.getList(param: DeviceRepositoryGetListParam(searchText: ""));
    emit(DeviceState(list: l));
  }

}


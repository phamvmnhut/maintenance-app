
// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import 'package:divice/core/error/failures.dart';
import 'package:divice/core/usecases/usecase.dart';

import '../entities/device_care_task.dart';
import '../repositories/device_care_task_repository.dart';

class GetDeviceCareTaskListResult {
  final List<DeviceCareTask> deviceCareTaskList;

  GetDeviceCareTaskListResult({
    required this.deviceCareTaskList,
  });
}

class GetDeviceCareTaskListParams {
  final String? searchText;

  GetDeviceCareTaskListParams({
    this.searchText,
  });
}

class GetDeviceCareTaskListUseCase implements UseCase<GetDeviceCareTaskListResult, GetDeviceCareTaskListParams> {
  final DeviceCareTaskRepository _deviceCareTaskRepository;

  GetDeviceCareTaskListUseCase({
    required DeviceCareTaskRepository deviceCareTaskRepository,
  }) : _deviceCareTaskRepository = deviceCareTaskRepository;

  @override
  Future<Either<GetDeviceCareTaskListResult, Failure>> invoke({
    GetDeviceCareTaskListParams? params,
  }) async {
    final deviceCareTaskList = await _deviceCareTaskRepository
      .getDeviceCareTaskList(searchText: params?.searchText);

    return deviceCareTaskList
      .bimap(
        (l) => GetDeviceCareTaskListResult(deviceCareTaskList: l), 
        (r) => r,
      );
  }
}

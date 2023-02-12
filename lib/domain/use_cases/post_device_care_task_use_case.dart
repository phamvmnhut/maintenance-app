// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import 'package:divice/core/error/failures.dart';
import 'package:divice/core/usecases/usecase.dart';

import '../entities/device_care_task.dart';
import '../repositories/device_care_task_repository.dart';


class PostDeviceCareTaskResult {
  final String message;

  PostDeviceCareTaskResult({
    required this.message,
  });
}

class PostDeviceCareTaskParams {
  final DeviceCareTask device;

  PostDeviceCareTaskParams({
    required this.device,
  });
}

class PostDeviceUseCase implements UseCase<PostDeviceCareTaskResult, PostDeviceCareTaskParams> {
  final DeviceCareTaskRepository _deviceCareTaskRepository;

  PostDeviceUseCase({
    required DeviceCareTaskRepository deviceCareTaskRepository,
  }) : _deviceCareTaskRepository = deviceCareTaskRepository;

  @override
  Future<Either<PostDeviceCareTaskResult, Failure>> invoke({
    PostDeviceCareTaskParams? params,
  }) async {
    if (params == null) {
      return const Right(Failure('Missing PostDeviceCareTaskParams'));
    }
    
    final deviceListResult = await _deviceCareTaskRepository
      .postDeviceCareTask(params.device);

    return deviceListResult
      .bimap(
        (l) => PostDeviceCareTaskResult(message: l), 
        (r) => r,
      );
  }
}

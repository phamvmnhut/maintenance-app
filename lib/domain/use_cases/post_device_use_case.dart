// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import 'package:divice/core/error/failures.dart';
import 'package:divice/core/usecases/usecase.dart';

import '../entities/device.dart';
import '../repositories/device_repostitory.dart';

class PostDeviceResult {
  final String message;

  PostDeviceResult({
    required this.message,
  });
}

class PostDeviceParams {
  final Device device;

  PostDeviceParams({
    required this.device,
  });
}

class PostDeviceUseCase implements UseCase<PostDeviceResult, PostDeviceParams> {
  final DeviceRepository _deviceRepository;

  PostDeviceUseCase({
    required DeviceRepository deviceRepository,
  }) : _deviceRepository = deviceRepository;

  @override
  Future<Either<PostDeviceResult, Failure>> invoke({
    PostDeviceParams? params,
  }) async {
    if (params == null) {
      return const Right(Failure('Missing PostDeviceParams'));
    }
    
    final deviceListResult = await _deviceRepository
      .postDevice(params.device);

    return deviceListResult
      .bimap(
        (l) => PostDeviceResult(message: l), 
        (r) => r,
      );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import 'package:divice/core/error/failures.dart';
import 'package:divice/core/usecases/usecase.dart';
import 'package:divice/domain/repositories/device_repostitory.dart';

import '../entities/device.dart';

class GetDeviceListResult {
  final List<Device> deviceList;

  GetDeviceListResult({
    required this.deviceList,
  });
}

class GetDeviceListParams {
  final String? searchText;

  GetDeviceListParams({
    this.searchText,
  });
}

class GetDeviceListUseCase implements UseCase<GetDeviceListResult, GetDeviceListParams> {
  final DeviceRepository _deviceRepository;

  GetDeviceListUseCase({
    required DeviceRepository deviceRepository,
  }) : _deviceRepository = deviceRepository;

  @override
  Future<Either<GetDeviceListResult, Failure>> invoke({
    GetDeviceListParams? params,
  }) async {
    final deviceListResult = await _deviceRepository
      .getDeviceList(searchText: params?.searchText);

    return deviceListResult
      .bimap(
        (l) => GetDeviceListResult(deviceList: l), 
        (r) => r,
      );
  }
}

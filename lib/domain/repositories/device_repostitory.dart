
import 'package:dartz/dartz.dart';
import 'package:divice/core/error/failures.dart';

import '../entities/device.dart';

abstract class DeviceRepository {
  Future<Either<List<Device>, Failure>> getDeviceList({
    String? searchText,
  });

  Future<Either<String, Failure>> postDevice(Device device);
}

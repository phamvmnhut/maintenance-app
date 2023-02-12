
import 'package:dartz/dartz.dart';
import 'package:divice/core/error/failures.dart';

import '../entities/device_care_task.dart';

abstract class DeviceCareTaskRepository {
  Future<Either<List<DeviceCareTask>, Failure>> getDeviceCareTaskList({
    String? searchText,
  });

  Future<Either<String, Failure>> postDeviceCareTask(DeviceCareTask task);
}

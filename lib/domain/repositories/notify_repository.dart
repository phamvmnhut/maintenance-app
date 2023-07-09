import '../entities/notification.dart';

abstract class NotifyRepository {
  Future<int?> updateSeen(int id);
  Future<List<NotificationModel>> getAll();
  Future<int?> insertNotify(NotificationModel? model);
  Future<int?> getHaveNotify();
}

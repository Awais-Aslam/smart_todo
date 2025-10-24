import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/core/common/unit.dart';

import '../entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Result<Unit>> sendNotification(NotificationEntity entity);
}

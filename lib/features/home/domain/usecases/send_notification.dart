import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/core/common/unit.dart';

import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class SendNotificationUsecase {
  final NotificationRepository repository;

  SendNotificationUsecase(this.repository);

  Future<Result<Unit>> call(NotificationEntity entity) {
    return repository.sendNotification(entity);
  }
}

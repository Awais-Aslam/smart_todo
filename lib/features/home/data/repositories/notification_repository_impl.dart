import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/core/common/unit.dart';

import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_data_source.dart';
import '../models/notification_request_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<Unit>> sendNotification(NotificationEntity entity) async {
    try {
      final notificationRequestModel = NotificationRequestModel(
        message: Message(
          token: entity.token,
          notification: NotificationBody(
            title: entity.title,
            body: entity.body,
          ),
          data: entity.data,
        ),
      );

      await remoteDataSource.sendNotification(
          notificationRequestModel: notificationRequestModel);
      return Result.success(const Unit());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}

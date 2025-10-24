import 'package:smart_todo/core/network/rest_api_client.dart';

import '../models/notification_request_model.dart';

abstract class NotificationRemoteDataSource {
  Future<void> sendNotification(
      {required NotificationRequestModel notificationRequestModel});
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final RestApiClient restApiClient;

  NotificationRemoteDataSourceImpl(this.restApiClient);

  @override
  Future<void> sendNotification({
    required NotificationRequestModel notificationRequestModel,
  }) async {
    return await restApiClient.sendNotification(notificationRequestModel);
  }
}

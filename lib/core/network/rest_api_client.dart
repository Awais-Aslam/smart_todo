import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_todo/features/home/data/models/notification_request_model.dart';
import 'api_constants.dart';

part 'rest_api_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RestApiClient {
  factory RestApiClient(Dio dio, {String baseUrl}) = _RestApiClient;

  @POST(ApiConstants.sendNotification)
  Future<void> sendNotification(@Body() NotificationRequestModel request);
}

import 'package:json_annotation/json_annotation.dart';

part 'notification_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationRequestModel {
  final Message message;

  NotificationRequestModel({required this.message});

  factory NotificationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationRequestModelToJson(this);
}

@JsonSerializable()
class Message {
  final String token;
  final NotificationBody? notification;
  final Map<String, dynamic>? data;

  Message({
    required this.token,
    this.notification,
    this.data,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class NotificationBody {
  final String title;
  final String body;

  NotificationBody({
    required this.title,
    required this.body,
  });

  factory NotificationBody.fromJson(Map<String, dynamic> json) =>
      _$NotificationBodyFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationBodyToJson(this);
}

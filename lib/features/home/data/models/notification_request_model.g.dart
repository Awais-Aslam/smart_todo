// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationRequestModel _$NotificationRequestModelFromJson(
        Map<String, dynamic> json) =>
    NotificationRequestModel(
      message: Message.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationRequestModelToJson(
        NotificationRequestModel instance) =>
    <String, dynamic>{
      'message': instance.message.toJson(),
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      token: json['token'] as String,
      notification: json['notification'] == null
          ? null
          : NotificationBody.fromJson(
              json['notification'] as Map<String, dynamic>),
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'token': instance.token,
      'notification': instance.notification,
      'data': instance.data,
    };

NotificationBody _$NotificationBodyFromJson(Map<String, dynamic> json) =>
    NotificationBody(
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$NotificationBodyToJson(NotificationBody instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };

class NotificationEntity {
  final String token;
  final String title;
  final String body;
  final Map<String, dynamic>? data;

  NotificationEntity({
    required this.token,
    required this.title,
    required this.body,
    this.data,
  });
}

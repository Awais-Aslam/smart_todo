import 'package:cloud_firestore/cloud_firestore.dart';

class TodoEntity {
  final String id;
  final String title;
  final String description;
  final String category;
  final String priority;
  final Timestamp dueDate;

  TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.dueDate,
  });
}

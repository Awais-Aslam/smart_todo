import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_todo/features/home/domain/entities/todo_entity.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String priority;
  final Timestamp dueDate;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.dueDate,
  });

  /// Convert Firestore map → TodoModel
  factory TodoModel.fromMap(Map<String, dynamic> map, String docId) {
    return TodoModel(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      priority: map['priority'] ?? '',
      dueDate: map['dueDate'] ?? '',
    );
  }

  /// Convert TodoModel → Firestore map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'dueDate': dueDate,
    };
  }

  /// Convert Model → Entity
  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      description: description,
      category: category,
      priority: priority,
      dueDate: dueDate,
    );
  }
}

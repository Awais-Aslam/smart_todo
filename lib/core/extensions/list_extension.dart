import 'package:smart_todo/features/home/domain/entities/todo_entity.dart';

extension TodoListSorting on List<TodoEntity> {
  List<TodoEntity> sortByPriority() {
    return List<TodoEntity>.from(this)
      ..sort((a, b) {
        final priorityOrder = {'high': 0, 'medium': 1, 'low': 2};
        return priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!);
      });
  }
}

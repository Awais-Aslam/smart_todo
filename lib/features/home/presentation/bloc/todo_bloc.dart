import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo/features/home/domain/entities/notification_entity.dart';
import 'package:smart_todo/features/home/domain/entities/todo_entity.dart';
import 'package:smart_todo/features/home/domain/repositories/notification_repository.dart';
import 'package:smart_todo/features/home/domain/repositories/todo_repository.dart';
import 'package:smart_todo/features/home/domain/usecases/add_todo.dart';
import 'package:smart_todo/features/home/domain/usecases/fetch_todo.dart';
import 'package:smart_todo/features/home/domain/usecases/send_notification.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  final NotificationRepository notificationRepository;
  final AddTodo addTodo;
  final FetchTodo fetchTodo;
  final SendNotificationUsecase sendNotificationUsecase;

  TodoBloc({
    required this.todoRepository,
    required this.notificationRepository,
  })  : addTodo = AddTodo(todoRepository),
        fetchTodo = FetchTodo(todoRepository),
        sendNotificationUsecase =
            SendNotificationUsecase(notificationRepository),
        super(TodoInitial()) {
    on<AddTodoEvent>(_addTodoEventHandler);
    on<FetchTodosEvent>(_fetchTodosEventHandler);
  }

  Future<void> _addTodoEventHandler(
    AddTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());

    final result = await addTodo(
      title: event.title,
      description: event.description,
      category: event.category,
      priority: event.priority,
      dueDate: event.dueDate,
    );

    if (result.isSuccess) {
      await sendNotificationUsecase(
        NotificationEntity(
          token:
              "cSiMTXxAT9KIvjf5XwHsXX:APA91bEPMwGKyeZEgm47jTcYcbF4fvTbpyUoOHsAFB4_GSmWaay-B8WEBk53OFbCwDF7A0VlownbndmuyACd1cOD_l523RdN2aIZbVo07hC3dQ3ihEr1noM",
          title: "${event.title} Added",
          body: event.description,
        ),
      );
      emit(AddTodoSuccess());
    } else {
      emit(AddTodoError(result.error!));
    }
  }

  Future<void> _fetchTodosEventHandler(
    FetchTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());

    final result = await fetchTodo();

    if (result.isSuccess) {
      emit(FetchTodosSuccess(todoList: result.data!));
    } else {
      emit(FetchTodosError(result.error!));
    }
  }
}

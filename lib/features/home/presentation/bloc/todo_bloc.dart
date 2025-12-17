import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo/core/di/injection.dart';
import 'package:smart_todo/core/services/notification_service.dart';
import 'package:smart_todo/core/services/secure_storage_service.dart';
import 'package:smart_todo/features/home/domain/entities/notification_entity.dart';
import 'package:smart_todo/features/home/domain/entities/todo_entity.dart';
import 'package:smart_todo/features/home/domain/repositories/notification_repository.dart';
import 'package:smart_todo/features/home/domain/repositories/todo_repository.dart';
import 'package:smart_todo/features/home/domain/usecases/add_todo.dart';
import 'package:smart_todo/features/home/domain/usecases/delete_todo.dart';
import 'package:smart_todo/features/home/domain/usecases/edit_todo.dart';
import 'package:smart_todo/features/home/domain/usecases/fetch_todo.dart';
import 'package:smart_todo/features/home/domain/usecases/send_notification.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  final NotificationRepository notificationRepository;
  final AddTodo addTodo;
  final EditTodo editTodo;
  final FetchTodo fetchTodo;
  final SendNotificationUsecase sendNotificationUsecase;
  final DeleteTodoUsecase deleteTodoUsecase;

  TodoBloc({
    required this.todoRepository,
    required this.notificationRepository,
  })  : addTodo = AddTodo(todoRepository),
        editTodo = EditTodo(todoRepository),
        fetchTodo = FetchTodo(todoRepository),
        deleteTodoUsecase = DeleteTodoUsecase(todoRepository),
        sendNotificationUsecase =
            SendNotificationUsecase(notificationRepository),
        super(TodoInitial()) {
    on<AddTodoEvent>(_addTodoEventHandler);
    on<EditTodoEvent>(_editTodoEventHandler);
    on<DeleteTodoEvent>(_deleteTodoEventHandler);
    on<FetchTodosEvent>(_fetchTodosEventHandler);
  }

  Future<void> _deleteTodoEventHandler(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());

    final result = await deleteTodoUsecase(uid: event.uid);

    if (result.isSuccess) {
      emit(DeleteTodoSuccess());
    } else {
      emit(DeleteTodoError(result.error ?? "Failed to Delete Todo"));
    }
  }

  Future<void> _editTodoEventHandler(
    EditTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());

    final result = await editTodo(
      title: event.title,
      description: event.description,
      category: event.category,
      priority: event.priority,
      dueDate: event.dueDate,
      uid: event.uid,
    );

    if (result.isSuccess) {
      try {
        final fcmToken = await getIt<SecureStorageService>().getFcmToken();
        if (fcmToken != null && fcmToken.isNotEmpty) {
          await sendNotificationUsecase(
            NotificationEntity(
              token: fcmToken,
              title: "Todo Updated: ${event.title}",
              body: event.description,
            ),
          );
        } else {
          // Optionally log or handle missing token
          debugPrint("No FCM token available, skipping notification.");
        }

        // Schedule local notification safely
        final notificationService = getIt<NotificationService>();
        notificationService.scheduleNotification(
          title: "Don't forget!",
          body: "Your task '${event.title}' is due soon.",
          hour: 12,
          minute: 00,
          dueDateString: event.dueDate,
        );

        emit(EditTodoSuccess());
      } catch (e, stack) {
        debugPrint("Error while sending notification: $e\n$stack");
        emit(EditTodoError("Todo added, but failed to send notification."));
      }
    } else {
      emit(EditTodoError(result.error ?? "Failed to Edit Todo"));
    }
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
      try {
        final fcmToken = await getIt<SecureStorageService>().getFcmToken();
        if (fcmToken != null && fcmToken.isNotEmpty) {
          await sendNotificationUsecase(
            NotificationEntity(
              token: fcmToken,
              title: "New Todo Added: ${event.title}",
              body: event.description,
            ),
          );
        } else {
          // Optionally log or handle missing token
          debugPrint("No FCM token available, skipping notification.");
        }

        // Schedule local notification safely
        final notificationService = getIt<NotificationService>();
        notificationService.scheduleNotification(
          title: "Don't forget!",
          body: "Your task '${event.title}' is due soon.",
          hour: 12,
          minute: 00,
          dueDateString: event.dueDate,
        );

        emit(AddTodoSuccess());
      } catch (e, stack) {
        debugPrint("Error while sending notification: $e\n$stack");
        emit(AddTodoError("Todo added, but failed to send notification."));
      }
    } else {
      emit(AddTodoError(result.error ?? "Failed to add Todo"));
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

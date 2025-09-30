import 'package:flutter_bloc/flutter_bloc.dart';

enum TodoType {
  all,
  work,
  personal,
  study,
}

class TodoTypeCubit extends Cubit<String> {
  TodoTypeCubit() : super(TodoType.values[0].name);

  void todoTypeSelected(String type) => emit(type);
}

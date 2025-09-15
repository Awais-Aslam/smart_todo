import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(Locale('en'))) {
    on<ChangeLocaleEvent>(_changeLocaleEventHandler);
  }

  void _changeLocaleEventHandler(
    ChangeLocaleEvent event,
    Emitter<LocaleState> emit,
  ) {
    emit(LocaleState(event.locale));
  }
}

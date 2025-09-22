import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo/features/auth/domain/entities/user_entity.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';
import 'package:smart_todo/features/auth/domain/usecases/logout_user.dart';
import 'package:smart_todo/features/auth/domain/usecases/signup_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final SignUpUser signUpUser;
  final LogoutUser logoutUser;

  AuthBloc({required this.authRepository})
      : signUpUser = SignUpUser(authRepository),
        logoutUser = LogoutUser(authRepository),
        super(AuthInitial()) {
    on<SignupButtonPressed>(_signupButtonPressedEventHandler);
    on<LogoutButtonPressed>(_logoutButtonPressedEventHandler);
  }

  Future<void> _signupButtonPressedEventHandler(
    SignupButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    // Call the use case
    final result = await signUpUser(event.email, event.password);

    if (result.isSuccess) {
      emit(SignupSuccess(userEntity: result.data!));
    } else {
      emit(SignupError(message: result.error!));
    }
  }

  Future<void> _logoutButtonPressedEventHandler(
    LogoutButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    await Future.delayed(const Duration(seconds: 10));

    final result = await logoutUser();

    if (result.isSuccess) {
      emit(LogoutSuccess());
    } else {
      emit(LogoutError(message: result.error!));
    }
  }
}

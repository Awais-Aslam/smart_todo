import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo/core/services/secure_storage_service.dart';
import 'package:smart_todo/features/auth/data/models/user_model.dart';
import 'package:smart_todo/features/auth/domain/entities/user_entity.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';
import 'package:smart_todo/features/auth/domain/usecases/login_user.dart';
import 'package:smart_todo/features/auth/domain/usecases/logout_user.dart';
import 'package:smart_todo/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:smart_todo/features/auth/domain/usecases/signup_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final SecureStorageService storage;
  final SignUpUser signUpUser;
  final LogoutUser logoutUser;
  final LoginUser loginUser;
  final SignInWithGoogle signInWithGoogle;

  AuthBloc({
    required this.authRepository,
    required this.storage,
  })  : signUpUser = SignUpUser(authRepository),
        logoutUser = LogoutUser(authRepository),
        loginUser = LoginUser(authRepository),
        signInWithGoogle = SignInWithGoogle(authRepository),
        super(AuthInitial()) {
    on<SignupButtonPressed>(_signupButtonPressedEventHandler);
    on<LogoutButtonPressed>(_logoutButtonPressedEventHandler);
    on<LoginButtonPressed>(_loginButtonPressedEventHandler);
    on<GoogleSignInRequested>(_googleSignInEventHandler);
  }

  Future<void> _signupButtonPressedEventHandler(
    SignupButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    // Call the use case
    final result = await signUpUser(
      event.email,
      event.password,
      event.username,
    );

    if (result.isSuccess) {
      final userModel = UserModel.fromEntity(result.data!);
      await storage.saveUserData(jsonEncode(userModel.toJson()));
      emit(SignupSuccess(userEntity: result.data!));
    } else {
      emit(SignupError(message: result.error!));
    }
  }

  Future<void> _loginButtonPressedEventHandler(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    // Call the use case
    final result = await loginUser(event.email, event.password);

    if (result.isSuccess) {
      final userModel = UserModel.fromEntity(result.data!);
      await storage.saveUserData(jsonEncode(userModel.toJson()));
      emit(LoginSuccess(userEntity: result.data!));
    } else {
      emit(LoginError(message: result.error!));
    }
  }

  Future<void> _googleSignInEventHandler(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    // Call the use case
    final result = await signInWithGoogle();

    if (result.isSuccess) {
      final userModel = UserModel.fromEntity(result.data!);
      await storage.saveUserData(jsonEncode(userModel.toJson()));
      emit(LoginSuccess(userEntity: result.data!));
    } else if (result.data == null && result.error == null) {
      emit(AuthInitial());
    } else {
      emit(LoginError(message: result.error!));
    }
  }

  Future<void> _logoutButtonPressedEventHandler(
    LogoutButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    // await Future.delayed(const Duration(seconds: 10));

    final result = await logoutUser();

    if (result.isSuccess) {
      emit(LogoutSuccess());
    } else {
      emit(LogoutError(message: result.error!));
    }
  }
}

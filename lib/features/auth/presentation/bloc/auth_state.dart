part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class SignupSuccess extends AuthState {
  final UserEntity userEntity;

  SignupSuccess({required this.userEntity});
}

final class SignupError extends AuthState {
  final String message;

  SignupError({required this.message});
}

final class LoginSuccess extends AuthState {
  final UserEntity userEntity;

  LoginSuccess({required this.userEntity});
}

final class LoginError extends AuthState {
  final String message;

  LoginError({required this.message});
}

final class GoogleSignInSuccess extends AuthState {
  final UserEntity userEntity;

  GoogleSignInSuccess({required this.userEntity});
}

final class GoogleSignInError extends AuthState {
  final String message;

  GoogleSignInError({required this.message});
}

final class LogoutSuccess extends AuthState {}

final class LogoutError extends AuthState {
  final String message;

  LogoutError({required this.message});
}

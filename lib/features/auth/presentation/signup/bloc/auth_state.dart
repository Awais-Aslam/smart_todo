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

final class LogoutSuccess extends AuthState {}

final class LogoutError extends AuthState {
  final String message;

  LogoutError({required this.message});
}

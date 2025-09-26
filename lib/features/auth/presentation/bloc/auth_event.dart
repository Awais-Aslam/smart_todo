part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignupButtonPressed extends AuthEvent {
  final String email;
  final String password;
  final String username;

  SignupButtonPressed({
    required this.email,
    required this.password,
    required this.username,
  });
}

final class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressed({
    required this.email,
    required this.password,
  });
}

final class GoogleSignInRequested extends AuthEvent {}

final class LogoutButtonPressed extends AuthEvent {}

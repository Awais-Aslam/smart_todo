part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignupButtonPressed extends AuthEvent {
  final String email;
  final String password;

  SignupButtonPressed({
    required this.email,
    required this.password,
  });
}

final class LogoutButtonPressed extends AuthEvent {}

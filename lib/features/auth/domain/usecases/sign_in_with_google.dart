import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/features/auth/domain/entities/user_entity.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<Result<UserEntity>> call() async =>
      await repository.signInWithGoogle();
}

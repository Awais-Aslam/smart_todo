import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/features/auth/domain/entities/user_entity.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';

class SignUpUser {
  final AuthRepository repository;

  SignUpUser(this.repository);

  Future<Result<UserEntity>> call(
    String email,
    String password,
    String username,
  ) async {
    return await repository.registerUser(
      email: email,
      password: password,
      username: username,
    );
  }
}

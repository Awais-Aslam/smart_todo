import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/features/auth/domain/entities/user_entity.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<Result<UserEntity>> call(
    String email,
    String password,
  ) async {
    return await repository.loginUser(
      email: email,
      password: password,
    );
  }
}

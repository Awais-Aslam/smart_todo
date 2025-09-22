import 'package:smart_todo/core/domain/result.dart';
import 'package:smart_todo/core/domain/unit.dart';
import 'package:smart_todo/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> registerUser({
    required String email,
    required String password,
  });

  Future<Result<Unit>> logoutUser();
}

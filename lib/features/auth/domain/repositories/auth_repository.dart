import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/core/common/unit.dart';
import 'package:smart_todo/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> registerUser({
    required String email,
    required String password,
    required String username,
  });

  Future<Result<UserEntity>> loginUser({
    required String email,
    required String password,
  });

  Future<Result<UserEntity>> signInWithGoogle();

  Future<Result<Unit>> logoutUser();
}

import 'package:smart_todo/core/domain/result.dart';
import 'package:smart_todo/core/domain/unit.dart';
import 'package:smart_todo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_todo/features/auth/domain/entities/user_entity.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Result<UserEntity>> registerUser(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final userModel = await authRemoteDataSource.registerUser(
        email: email,
        password: password,
        username: username,
      );

      return Result.success(userModel.toEntity());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<Unit>> logoutUser() async {
    try {
      await authRemoteDataSource.logoutUser();
      return Result.success(const Unit());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<UserEntity>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await authRemoteDataSource.loginUser(
        email: email,
        password: password,
      );

      return Result.success(userModel.toEntity());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}

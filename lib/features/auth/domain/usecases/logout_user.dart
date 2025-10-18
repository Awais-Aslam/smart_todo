import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/core/common/unit.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';

class LogoutUser {
  final AuthRepository repository;

  LogoutUser(this.repository);

  Future<Result<Unit>> call() async => await repository.logoutUser();
}

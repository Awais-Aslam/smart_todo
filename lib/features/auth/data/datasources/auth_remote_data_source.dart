import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_todo/core/network/auth_server_exception.dart';
import 'package:smart_todo/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> registerUser({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // will inject through DI
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserModel> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserModel(
        uid: result.user!.uid,
        email: result.user!.email!,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthServerException(message: e.message ?? 'Auth failed');
      // return Result.failure(e.toString());
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_todo/core/network/auth_server_exception.dart';
import 'package:smart_todo/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> registerUser({
    required String email,
    required String password,
    required String username,
  });

  Future<UserModel> loginUser({
    required String email,
    required String password,
  });

  Future<void> logoutUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // will inject through DI
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserModel> registerUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = result.user;
      if (user != null) {
        await user.updateDisplayName(username);

        await user.reload();
      }

      user = firebaseAuth.currentUser;

      return UserModel(
        uid: user!.uid,
        email: user.email!,
        displayName: user.displayName!,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthServerException(message: e.message ?? 'Auth failed');
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthServerException(message: e.message ?? 'Auth failed');
    }
  }

  @override
  Future<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserModel(
        uid: result.user!.uid,
        email: result.user!.email!,
        displayName: result.user!.displayName!,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        throw AuthServerException(message: 'Email or password is incorrect');
      }
      throw AuthServerException(message: e.message ?? 'Auth failed');
    }
  }
}

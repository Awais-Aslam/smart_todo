import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<UserModel?> signInWithGoogle();

  Future<void> logoutUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // will inject through DI
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.googleSignIn);

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
      await googleSignIn.signOut();
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

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow.
      final googleUser = await googleSignIn.signIn();

      // User canceled the sign-in.
      if (googleUser == null) return null;

      // Retrieve the authentication details from the Google account.
      final googleAuth = await googleUser.authentication;

      // Create a new credential using the Google authentication details.
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential.
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);

      return UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!,
        displayName: userCredential.user!.displayName!,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        throw AuthServerException(message: 'Email or password is incorrect');
      }
      throw AuthServerException(message: e.message ?? 'Auth failed');
    }
  }
}

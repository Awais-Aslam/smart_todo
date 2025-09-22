import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_todo/core/domain/result.dart';
import 'package:smart_todo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_todo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:smart_todo/features/auth/domain/entities/user_entity.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late AuthRepositoryImpl authRepositoryImpl;

  setUp(
    () async {
      mockFirebaseAuth = MockFirebaseAuth();
      authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockFirebaseAuth);
      authRepositoryImpl = AuthRepositoryImpl(authRemoteDataSourceImpl);
    },
  );

  group('auth repository impl ...', () {
    group('register user function', () {
      test(
        'given auth repository impl class when the register user function is called and response is 200 then it should return User Entity',
        () async {
          final mockCredential = MockUserCredential();

          when(
            () => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((value) async {
            return mockCredential;
          });

          final result = await authRepositoryImpl.registerUser(
            email: '',
            password: '',
          );

          expect(result, isA<Result<UserEntity>>());
        },
      );

      test(
        'given auth repository impl class when the register user function is called and response is not 200 then it should return error',
        () async {
          // Arrange
          when(
            () => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((value) async {
            return Future.error(
              FirebaseAuthException(
                code: 'invalid-email',
                message: 'Invalid Email',
              ),
            );
          });

          // act
          final result = await authRepositoryImpl.registerUser(
            email: '',
            password: '',
          );

          // assert
          expect(result.error, 'Invalid Email');
        },
      );
    });
  });
}

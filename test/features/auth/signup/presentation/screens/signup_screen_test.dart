import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_todo/core/app/locale/bloc/locale_bloc.dart';
import 'package:smart_todo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_todo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';
import 'package:smart_todo/features/auth/presentation/screens/login_screen.dart';
import 'package:smart_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smart_todo/features/auth/presentation/screens/signup_screen.dart';
import 'package:smart_todo/l10n/l10n.dart';

import '../../../../splash/presentation/mock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets(
    'signup screen widget tests',
    (tester) async {
      final testRouter = GoRouter(
        initialLocation: '/register',
        routes: <RouteBase>[
          GoRoute(
            path: '/login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginScreen();
            },
          ),
          GoRoute(
            path: '/register',
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpScreen();
            },
          ),
        ],
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<LocaleBloc>(
              create: (BuildContext context) => LocaleBloc(),
            ),
            RepositoryProvider<AuthRepository>(
              create: (BuildContext context) => AuthRepositoryImpl(
                AuthRemoteDataSourceImpl(
                  FirebaseAuth.instance,
                  GoogleSignIn(),
                ),
              ),
            ),
            BlocProvider<AuthBloc>(
              create: (BuildContext context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
          ],
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: testRouter,
          ),
        ),
      );

      // to check the Register text at the top
      expect(find.text('Register').first, findsOneWidget);

      // to test name, email, password and confirm password field
      expect(find.byKey(const Key('name_key')), findsOneWidget);
      expect(find.byKey(const Key('email_key')), findsOneWidget);
      expect(find.byKey(const Key('password_key')), findsOneWidget);
      expect(find.byKey(const Key('confirm_password_key')), findsOneWidget);

      // to test register button
      expect(find.byKey(const Key('register_btn_key')), findsOneWidget);

      // to test text back to login
      expect(find.text('Back To Login'), findsOneWidget);

      await tester.ensureVisible(find.text("Back To Login"));

      // to test the navigation to login screen
      await tester.tap(find.text('Back To Login'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
    },
  );
}

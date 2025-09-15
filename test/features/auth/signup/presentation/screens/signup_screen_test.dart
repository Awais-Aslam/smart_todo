import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_todo/features/auth/presentation/login/screens/login_screen.dart';
import 'package:smart_todo/features/auth/presentation/signup/screens/signup_screen.dart';
import 'package:smart_todo/l10n/l10n.dart';

void main() {
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
        MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: testRouter,
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

      // to test the navigation to login screen
      await tester.tap(find.text('Back To Login'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
    },
  );
}

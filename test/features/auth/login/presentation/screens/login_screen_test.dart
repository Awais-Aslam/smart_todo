import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_todo/features/auth/presentation/login/screens/login_screen.dart';
import 'package:smart_todo/features/auth/presentation/signup/screens/signup_screen.dart';
import 'package:smart_todo/l10n/l10n.dart';

void main() {
  testWidgets(
    'login screen widget testing',
    (tester) async {
      final testRouter = GoRouter(
        initialLocation: '/login',
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

      // to check the login text at the top
      expect(find.text('Login').first, findsOneWidget);

      // to test email and password field
      expect(find.byKey(const Key('email_key')), findsOneWidget);
      expect(find.byKey(const Key('password_key')), findsOneWidget);

      // to test login button
      expect(find.byKey(const Key('login_btn_key')), findsOneWidget);

      // to test google login button
      expect(find.byKey(const Key('g_login_btn_key')), findsOneWidget);

      // to test don't have an account text
      expect(find.byKey(const Key('register_text_key')), findsOneWidget);

      // to test the navigation to signup screen
      await tester.tap(find.byKey(const Key('register_text_key')));
      await tester.pumpAndSettle();
      expect(find.byType(SignUpScreen), findsOneWidget);
    },
  );
}

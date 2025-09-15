import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_todo/features/auth/presentation/login/screens/login_screen.dart';
import 'package:smart_todo/features/auth/presentation/signup/screens/signup_screen.dart';
import 'package:smart_todo/features/home/presentation/home_screen.dart';
import 'package:smart_todo/features/splash/presentation/screens/splash_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final appContext = rootNavigatorKey.currentContext!;

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen(
            delay: Duration(seconds: 5),
            enableNavigation: true,
          );
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
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
}

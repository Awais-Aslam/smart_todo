import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_todo/core/routes/app_routes.dart';
import 'package:smart_todo/features/auth/presentation/screens/login_screen.dart';
import 'package:smart_todo/features/auth/presentation/screens/signup_screen.dart';
import 'package:smart_todo/features/home/presentation/screens/home_screen.dart';
import 'package:smart_todo/features/splash/presentation/screens/splash_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final appContext = rootNavigatorKey.currentContext!;

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen(
            delay: Duration(seconds: 5),
            enableNavigation: true,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpScreen();
        },
      ),
    ],
  );
}

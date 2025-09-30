import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo/core/app/locale/bloc/locale_bloc.dart';
import 'package:smart_todo/core/di/injection.dart';
import 'package:smart_todo/core/routes/app_router.dart';
import 'package:smart_todo/core/theme/app_theme.dart';
import 'package:smart_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smart_todo/features/home/presentation/cubit/todo_type_cubit.dart';
import 'package:smart_todo/firebase_options.dart';
import 'package:smart_todo/l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleBloc>(
          create: (context) => getIt<LocaleBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => getIt<AuthBloc>(),
        ),
        BlocProvider<TodoTypeCubit>(
          create: (BuildContext context) => getIt<TodoTypeCubit>(),
        ),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          final locale = context.watch<LocaleBloc>().state.locale;
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: TAppTheme.lightTheme,
            darkTheme: TAppTheme.darkTheme,
            themeMode: ThemeMode.system,
            title: 'Flutter Demo',
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}

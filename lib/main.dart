import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo/core/app/locale/bloc/locale_bloc.dart';
import 'package:smart_todo/core/routes/app_router.dart';
import 'package:smart_todo/core/theme/app_theme.dart';
import 'package:smart_todo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_todo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';
import 'package:smart_todo/features/auth/presentation/signup/bloc/signup_bloc.dart';
import 'package:smart_todo/firebase_options.dart';
import 'package:smart_todo/l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          create: (BuildContext context) => LocaleBloc(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (BuildContext context) => AuthRepositoryImpl(
            AuthRemoteDataSourceImpl(FirebaseAuth.instance),
          ),
        ),
        BlocProvider<SignupBloc>(
          create: (BuildContext context) => SignupBloc(
            authRepository: context.read<AuthRepository>(),
          ),
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

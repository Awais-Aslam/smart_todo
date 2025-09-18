import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_todo/features/splash/presentation/screens/splash_screen.dart';
import 'package:smart_todo/l10n/l10n.dart';

import 'mock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  group(
    'Splash Screen Widget Testing',
    () {
      testWidgets(
        'displays the logo icon',
        (tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: SplashScreen(
                delay: Duration(seconds: 5),
                enableNavigation: false,
              ),
            ),
          );

          expect(find.byType(Icon), findsOneWidget);
        },
      );

      testWidgets(
        'displays main and subtitle texts',
        (tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: SplashScreen(
                delay: Duration(seconds: 5),
                enableNavigation: false,
              ),
            ),
          );

          expect(find.text('Smart Todo'), findsOneWidget);
          expect(find.text('Organize Your Life'), findsOneWidget);
          expect(find.text('Loading...'), findsOneWidget);
        },
      );

      // testWidgets(
      //   'SplashScreen renders logo correctly initially',
      //   (tester) async {
      //     await tester.pumpWidget(
      //       const MaterialApp(
      //         home: SplashScreen(
      //           delay: Duration(seconds: 5),
      //           enableNavigation: false,
      //         ),
      //       ),
      //     );

      //     final transformFinder = find.byType(Transform).at(0);

      //     final transformWidget = tester.widget<Transform>(transformFinder);

      //     // Extract the matrix
      //     final matrix = transformWidget.transform;

      //     // Extract angle from matrix
      //     final angle = math.atan2(matrix.entry(1, 0), matrix.entry(0, 0));

      //     expect(angle, closeTo(0.0, 0.0001));

      //     expect(matrix[0], 0);
      //   },
      // );

      // testWidgets(
      //   'SplashScreen renders logo correctly finally',
      //   (tester) async {
      //     await tester.pumpWidget(
      //       const MaterialApp(
      //         home: SplashScreen(
      //           delay: Duration(seconds: 5),
      //           enableNavigation: false,
      //         ),
      //       ),
      //     );

      //     await tester.pump(const Duration(seconds: 5)); // after full delay

      //     final transformFinder = find.byType(Transform).at(0);

      //     final transformWidget = tester.widget<Transform>(transformFinder);

      //     // Extract the matrix
      //     final matrix = transformWidget.transform;

      //     // Extract angle from matrix
      //     final angle = math.atan2(matrix.entry(1, 0), matrix.entry(0, 0));

      //     expect(angle, closeTo(1.0, 1.0001));

      //     expect(matrix[0], 1);
      //   },
      // );
    },
  );
}

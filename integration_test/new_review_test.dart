import 'package:flutter_test/flutter_test.dart';
import 'package:kemon/core/config/config.dart';
import 'package:kemon/core/shared/shared.dart';
import 'package:kemon/features/authentication/authentication.dart';
import 'package:kemon/features/whats_new/whats_new.dart';
import 'package:kemon/main.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolSetUp(() async {
    await AppConfig.init();
  });
  patrolTest(
    'New review test',
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.fullyLive,
    ($) async {
      await $.pumpWidgetAndSettle(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => WhatsNewBloc()),
            BlocProvider(create: (_) => sl<ThemeBloc>()),
            BlocProvider(create: (_) => sl<AuthenticationBloc>()),
          ],
          child: const MainApp(),
        ),
      );

      $(Keys.home.search).tap();
      $(Keys.search.suggestion.field).enterText('seagull');

      await Future.delayed(2.seconds);
    },
  );
}

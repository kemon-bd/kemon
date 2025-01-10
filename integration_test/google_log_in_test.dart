import 'package:flutter_test/flutter_test.dart';
import 'package:kemon/core/config/config.dart';
import 'package:kemon/core/shared/shared.dart';
import 'package:kemon/features/authentication/authentication.dart';
import 'package:kemon/features/profile/profile.dart';
import 'package:kemon/features/whats_new/whats_new.dart';
import 'package:kemon/main.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolSetUp(() async {
    await AppConfig.init();
  });
  patrolTest(
    'Google Login test',
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.fullyLive,
    config: const PatrolTesterConfig(printLogs: true),
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
      await $(MyProfilePictureWidget).tap();
      // await $(SvgPicture.asset(
      //   'images/logo/google.svg',
      //   width: Dimension.radius.eighteen,
      //   height: Dimension.radius.eighteen,
      // )).tap();
      await Future.delayed(3.seconds);
    },
  );
}

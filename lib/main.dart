import 'core/config/config.dart';
import 'core/shared/shared.dart';
import 'features/authentication/authentication.dart';
import 'features/leaderboard/leaderboard.dart';
import 'features/version/version.dart';
import 'features/whats_new/whats_new.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfig.init();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<WhatsNewBloc>()),
          BlocProvider(create: (_) => sl<ThemeBloc>()),
          BlocProvider(create: (_) => sl<AuthenticationBloc>()),
          BlocProvider(create: (_) => sl<LeaderboardFilterBloc>()),
          BlocProvider(create: (_) => sl<FindVersionBloc>()),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        return MaterialApp.router(
          themeMode: state.mode,
          routerConfig: router,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          theme: AppConfig.themeData(context: context, mode: state.mode),
          darkTheme: AppConfig.themeData(context: context, mode: state.mode),
          // builder: (mqContext, child) {
          //   return MediaQuery(
          //     data: MediaQuery.of(mqContext).copyWith(
          //       textScaler: TextScaler.linear(1.0),
          //       accessibleNavigation: false,
          //       devicePixelRatio: MediaQuery.of(mqContext).devicePixelRatio,
          //     ),
          //     child: child!,
          //   );
          // },
        );
      },
    );
  }
}

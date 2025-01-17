import 'core/config/config.dart';
import 'core/shared/shared.dart';
import 'features/authentication/authentication.dart';
import 'features/leaderboard/leaderboard.dart';
import 'features/whats_new/whats_new.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfig.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WhatsNewBloc()),
        BlocProvider(create: (_) => sl<ThemeBloc>()),
        BlocProvider(create: (_) => sl<AuthenticationBloc>()),
        BlocProvider(create: (_) => sl<LeaderboardFilterBloc>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    ScreenUtil.init(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        return MaterialApp.router(
          themeMode: state.mode,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          theme: AppConfig.themeData(context: context, mode: state.mode),
          darkTheme: AppConfig.themeData(context: context, mode: state.mode),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
              child: child!,
            );
          },
        );
      },
    );
  }
}

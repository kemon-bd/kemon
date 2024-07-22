import 'core/config/config.dart';
import 'core/shared/shared.dart';
import 'features/authentication/authentication.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all the configurations
  await AppConfig.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthenticationBloc>()),
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

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        return MaterialApp.router(
          themeMode: state.mode,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          theme: AppConfig.themeData(context: context, mode: state.mode),
          darkTheme: AppConfig.themeData(context: context, mode: state.mode),
          themeAnimationStyle: AnimationStyle(
            duration: const Duration(milliseconds: 250),
            curve: Curves.fastLinearToSlowEaseIn,
          ),
        );
      },
    );
  }
}

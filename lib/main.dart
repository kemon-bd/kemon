import 'core/config/config.dart';
import 'core/shared/shared.dart';
import 'features/authentication/authentication.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfig.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeBloc>()),
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
    ScreenUtil.init(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        return MaterialApp.router(
          themeMode: state.mode,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          theme: AppConfig.themeData(context: _, mode: state.mode),
          darkTheme: AppConfig.themeData(context: _, mode: state.mode),
        );
      },
    );
  }
}

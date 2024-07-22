// import '../../features/home/home.dart';
import '../../features/login/login.dart';
import '../../features/profile/profile.dart';
import '../config/config.dart';
import 'shared.dart';

final router = GoRouter(
  initialLocation: LoginPage.path,
  routes: [
    GoRoute(
      path: LoginPage.path,
      name: LoginPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<CheckProfileBloc>()),
          BlocProvider(create: (context) => sl<LoginBloc>()),
        ],
        child: const LoginPage(),
      ),
    ),
  ],
);

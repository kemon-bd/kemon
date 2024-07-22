import '../../features/dashboard/dashboard.dart';
import '../../features/login/login.dart';
import '../../features/profile/profile.dart';
import '../config/config.dart';
import 'shared.dart';

final router = GoRouter(
  initialLocation: DashboardPage.path,
  routes: [
    GoRoute(
      name: DashboardPage.name,
      path: DashboardPage.path,
      builder: (context, state) {
        return const DashboardPage();
      },
      redirect: (context, state) => context.auth.authenticated ? null : LoginPage.path,
    ),
    GoRoute(
      name: ProfilePage.name,
      path: ProfilePage.path,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<FindProfileBloc>()
                ..add(
                  const FindProfile(),
                ),
            ),
          ],
          child: const ProfilePage(),
        );
      },
      redirect: (context, state) => context.auth.authenticated ? null : LoginPage.path,
    ),
    GoRoute(
      name: LoginPage.name,
      path: LoginPage.path,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<LoginBloc>()),
          ],
          child: const LoginPage(),
        );
      },
    ),
    GoRoute(
      name: ForgotPasswordPage.name,
      path: ForgotPasswordPage.path,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<ForgotPasswordBloc>()),
          ],
          child: const ForgotPasswordPage(),
        );
      },
    ),
  ],
);

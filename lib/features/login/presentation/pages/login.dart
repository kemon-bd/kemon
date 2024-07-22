import '../../../../core/shared/shared.dart';

class LoginPage extends StatelessWidget {
  static const String path = '/login';
  static const String name = 'LoginPage';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          body: Placeholder(),
        );
      },
    );
  }
}

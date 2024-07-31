import '../../../../core/shared/shared.dart';

class ProfilePage extends StatelessWidget {
  static const String path = '/profile';
  static const String name = 'ProfilePage';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          body: const Placeholder(),
        );
      },
    );
  }
}

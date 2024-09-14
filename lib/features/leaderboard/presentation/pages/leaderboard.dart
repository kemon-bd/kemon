import '../../../../core/shared/shared.dart';

class LeaderboardPage extends StatelessWidget {
  static const String path = '/leaderboard';
  static const String name = 'LeaderboardPage';
  const LeaderboardPage({super.key});

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

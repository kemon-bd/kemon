import '../../../../core/shared/shared.dart';

class LocationPage extends StatelessWidget {
  static const String path = '/location';
  static const String name = 'LocationPage';
  const LocationPage({super.key});

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

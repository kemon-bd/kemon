import '../../../../core/shared/shared.dart';

class LookupPage extends StatelessWidget {
  static const String path = '/lookup';
  static const String name = 'LookupPage';
  const LookupPage({super.key});

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

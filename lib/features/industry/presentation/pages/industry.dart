import '../../../../core/shared/shared.dart';

class IndustryPage extends StatelessWidget {
  static const String path = '/industry';
  static const String name = 'IndustryPage';
  const IndustryPage({super.key});

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

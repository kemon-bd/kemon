import '../../../../core/shared/shared.dart';

class WhatsNewPage extends StatelessWidget {
  static const String path = '/whats-new';
  static const String name = 'WhatsNewPage';
  const WhatsNewPage({super.key});

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

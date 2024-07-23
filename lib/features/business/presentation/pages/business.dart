import '../../../../core/shared/shared.dart';

class BusinessPage extends StatelessWidget {
  static const String path = '/business';
  static const String name = 'BusinessPage';
  const BusinessPage({super.key});

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

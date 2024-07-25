import '../../../../core/shared/shared.dart';

class SearchPage extends StatelessWidget {
  static const String path = '/search';
  static const String name = 'SearchPage';
  const SearchPage({super.key});

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

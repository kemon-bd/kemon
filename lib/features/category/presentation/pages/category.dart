import '../../../../core/shared/shared.dart';

class CategoryPage extends StatelessWidget {
  static const String path = '/category';
  static const String name = 'CategoryPage';
  const CategoryPage({super.key});

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

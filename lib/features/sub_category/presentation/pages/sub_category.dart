import '../../../../core/shared/shared.dart';

class SubCategoryPage extends StatelessWidget {
  static const String path = '/sub-category';
  static const String name = 'SubCategoryPage';
  const SubCategoryPage({super.key});

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

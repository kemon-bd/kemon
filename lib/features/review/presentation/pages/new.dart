import '../../../../core/shared/shared.dart';

class NewReviewPage extends StatelessWidget {
  static const String path = '/business/:urlSlug/new-review';
  static const String name = 'NewReviewPage';
  const NewReviewPage({super.key});

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

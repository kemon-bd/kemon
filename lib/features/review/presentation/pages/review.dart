import '../../../../core/shared/shared.dart';

class ReviewPage extends StatelessWidget {
  static const String path = '/review';
  static const String name = 'ReviewPage';
  const ReviewPage({super.key});

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

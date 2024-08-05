import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class UserReviewsPage extends StatelessWidget {
  static const String path = '/:user/reviews';
  static const String name = 'UserReviewsPage';
  const UserReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: theme.backgroundPrimary,
            surfaceTintColor: theme.backgroundPrimary,
            title: ProfileNameWidget(style: TextStyles.miniHeadline(context: context, color: theme.textPrimary)),
            centerTitle: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: theme.textPrimary),
              onPressed: context.pop,
            ),
          ),
          body: const UserReviewsWidget(),
        );
      },
    );
  }
}

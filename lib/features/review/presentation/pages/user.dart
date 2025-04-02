import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class UserReviewsPage extends StatelessWidget {
  static const String path = '/:user/reviews';
  static const String name = 'UserReviewsPage';

  final Identity identity;

  const UserReviewsPage({
    super.key,
    required this.identity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final mine = identity.guid.same(as: context.auth.guid ?? '');
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            backgroundColor: theme.backgroundPrimary,
            surfaceTintColor: theme.backgroundPrimary,
            title: BlocBuilder<FindProfileBloc, FindProfileState>(
              builder: (context, state) {
                if (state is FindProfileDone) {
                  final name = state.profile.name.first;
                  return Text('${mine ? 'My' : '$name’s'} reviews');
                } else {
                  return const Text('Reviews');
                }
              },
            ),
            titleTextStyle: context.text.titleMedium?.copyWith(
              color: theme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: theme.textPrimary),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(HomePage.name);
                }
              },
            ),
          ),
          body: UserReviewsWidget(user: identity),
        );
      },
    );
  }
}

import '../../../../core/shared/shared.dart';
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
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            backgroundColor: theme.backgroundPrimary,
            surfaceTintColor: theme.backgroundPrimary,
            title: BlocBuilder<FindProfileBloc, FindProfileState>(
              builder: (context, state) {
                if (state is FindProfileDone) {
                  final identity = state.profile.identity;
                  final name = state.profile.name.first;
                  return Text(
                    '${identity.guid.same(as: context.auth.guid ?? '') ? 'My' : '$name’s'} reviews',
                    style: TextStyles.h6(
                        context: context, color: theme.textPrimary),
                  );
                } else {
                  return const Text('reviews');
                }
              },
            ),
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

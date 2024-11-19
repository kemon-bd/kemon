import '../../../../../core/shared/shared.dart';
import '../../../review/review.dart';
import '../../profile.dart';

class ProfileFeatureOptionsWidget extends StatelessWidget {
  const ProfileFeatureOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Text(
              'Account',
              style: TextStyles.subTitle(context: context, color: theme.textSecondary.withAlpha(100)),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: theme.backgroundSecondary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.backgroundTertiary, width: .25),
              ),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  BlocBuilder<FindProfileBloc, FindProfileState>(
                    builder: (context, state) {
                      if (state is FindProfileDone) {
                        final identity = state.profile.identity;
                        final name = state.profile.name.first;
                        return ListTile(
                          leading: const CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.reviews_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: Text(
                            '${identity.guid.like(as: context.auth.guid ?? '') ? 'My' : '$name’s'} reviews',
                            style: TextStyles.title(context: context, color: theme.textPrimary),
                          ),
                          trailing: Icon(Icons.open_in_new_rounded, color: theme.backgroundTertiary, size: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                          onTap: () {
                            context.pushNamed(
                              UserReviewsPage.name,
                              pathParameters: {'user': identity.guid},
                            );
                          },
                        );
                      } else {
                        return const Text('reviews');
                      }
                    },
                  ),
                  const Divider(height: .1, thickness: .1),
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.deepOrangeAccent,
                      child: Icon(
                        Icons.emoji_events_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    title: Text(
                      'Points',
                      style: TextStyles.title(context: context, color: theme.textPrimary),
                    ),
                    trailing: ProfilePointWidget(style: TextStyles.title(context: context, color: theme.positive)),
                    // onTap: () {
                    //   context.pushNamed(LeaderboardPage.name);
                    // },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

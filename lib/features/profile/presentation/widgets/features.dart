import '../../../../../core/shared/shared.dart';
import '../../../leaderboard/leaderboard.dart';
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
          padding: EdgeInsets.all(Dimension.radius.sixteen),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Text(
              'Account',
              style: TextStyles.subTitle(context: context, color: theme.textSecondary),
            ),
            SizedBox(height: Dimension.padding.vertical.medium),
            Container(
              decoration: BoxDecoration(
                color: theme.backgroundSecondary,
                borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
                border: Border.all(color: theme.backgroundTertiary, width: .25),
              ),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: Dimension.padding.vertical.small),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  BlocBuilder<FindProfileBloc, FindProfileState>(
                    builder: (context, state) {
                      if (state is FindProfileDone) {
                        final identity = state.profile.identity;
                        final name = state.profile.name.first;
                        return ListTile(
                          leading: CircleAvatar(
                            radius: Dimension.radius.sixteen,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.reviews_rounded,
                              color: theme.white,
                              size: Dimension.radius.sixteen,
                            ),
                          ),
                          title: Text(
                            '${identity.guid.same(as: context.auth.guid ?? '') ? 'My' : '$name’s'} reviews',
                            style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                          ),
                          trailing: Icon(
                            Icons.open_in_new_rounded,
                            color: theme.backgroundTertiary,
                            size: Dimension.radius.sixteen,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(Dimension.radius.sixteen)),
                          ),
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
                  Divider(height: Dimension.padding.vertical.small, thickness: .25, color: theme.backgroundTertiary),
                  ListTile(
                    leading: CircleAvatar(
                      radius: Dimension.radius.sixteen,
                      backgroundColor: Colors.deepOrangeAccent,
                      child: Icon(
                        Icons.leaderboard_rounded,
                        color: theme.white,
                        size: Dimension.radius.sixteen,
                      ),
                    ),
                    title: ProfilePointWidget(
                      style: TextStyles.subTitle(context: context, color: theme.positive).copyWith(
                        fontSize: Dimension.radius.sixteen,
                        height: 1,
                      ),
                    ),
                    subtitle: Text(
                      'Points',
                      style: TextStyles.caption(context: context, color: theme.textSecondary),
                    ),
                    trailing: Icon(
                      Icons.open_in_new_rounded,
                      color: theme.backgroundTertiary,
                      size: Dimension.radius.sixteen,
                    ),
                    visualDensity: VisualDensity(vertical: -4),
                    onTap: () {
                      context.pushNamed(LeaderboardPage.name);
                    },
                  ),
                  BlocBuilder<FindProfileBloc, FindProfileState>(
                    builder: (context, state) {
                      if (state is FindProfileDone) {
                        final identity = state.profile.identity;
                        final mine = identity.guid.same(as: context.auth.guid ?? '');
                        return !mine
                            ? SizedBox.shrink()
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Divider(
                                    height: Dimension.padding.vertical.small,
                                    thickness: .25,
                                    color: theme.backgroundTertiary,
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: Dimension.radius.sixteen,
                                      backgroundColor: Colors.deepPurpleAccent,
                                      child: Icon(
                                        Icons.lock_rounded,
                                        color: theme.white,
                                        size: Dimension.radius.sixteen,
                                      ),
                                    ),
                                    title: Text(
                                      "Change password",
                                      style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                                    ),
                                    trailing: Icon(
                                      Icons.open_in_new_rounded,
                                      color: theme.backgroundTertiary,
                                      size: Dimension.radius.sixteen,
                                    ),
                                    onTap: () async {
                                      final confirmed = await showDialog<bool>(
                                        context: context,
                                        builder: (_) => DeleteConfirmationWidget(affirm: 'Continue'),
                                      );
                                      if (!(confirmed ?? false)) return;
                                      if (!context.mounted) return;

                                      context.pushNamed(ChangePasswordPage.name);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(Dimension.radius.sixteen)),
                                    ),
                                  ),
                                ],
                              );
                      }
                      return SizedBox.shrink();
                    },
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

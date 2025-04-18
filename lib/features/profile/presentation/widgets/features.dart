import '../../../../../core/shared/shared.dart';
import '../../../../core/config/config.dart';
import '../../../leaderboard/leaderboard.dart';
import '../../../lookup/lookup.dart';
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
              style: context.text.labelMedium?.copyWith(
                color: theme.textSecondary,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
            SizedBox(height: Dimension.padding.vertical.medium),
            Container(
              decoration: BoxDecoration(
                color: theme.backgroundSecondary,
                borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
                border: Border.all(color: theme.backgroundTertiary, width: .25),
              ),
              child: BlocBuilder<FindProfileBloc, FindProfileState>(
                builder: (context, state) {
                  if (state is FindProfileDone) {
                    final identity = state.profile.identity;
                    final name = state.profile.name.first;
                    final mine = identity.guid.same(as: context.auth.guid ?? '');
                    return ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: Dimension.padding.vertical.small),
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ListTile(
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
                            style: context.text.bodyMedium?.copyWith(
                              color: theme.textPrimary,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
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
                          title: Text(
                            state.profile.kemonIdentity.point.toString(),
                            style: context.text.bodyMedium?.copyWith(
                              color: theme.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Points',
                            style: context.text.labelSmall?.copyWith(
                              color: theme.textSecondary.withAlpha(150),
                              fontWeight: FontWeight.normal,
                            ),
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
                        if (mine) ...[
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
                              style: context.text.bodyMedium?.copyWith(
                                color: theme.textPrimary,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
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
                        if (!mine) ...[
                          Divider(
                            height: Dimension.padding.vertical.small,
                            thickness: .25,
                            color: theme.backgroundTertiary,
                          ),
                          BlocProvider(
                            create: (context) => sl<BlockBloc>(),
                            child: BlocConsumer<BlockBloc, BlockState>(
                              listener: (context, state) {
                                if (state is BlockDone) {
                                  context.warningNotification(
                                    message: "$name has been blocked. You will no longer see their activities.",
                                  );
                                  context.goNamed(
                                    BlockedAccountsPage.name,
                                    pathParameters: {'user': context.auth.identity?.guid ?? ""},
                                  );
                                } else if (state is BlockError) {
                                  context.errorNotification(message: state.failure.message);
                                }
                              },
                              builder: (blockContext, state) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: Dimension.radius.sixteen,
                                    backgroundColor: theme.negative,
                                    child: Icon(
                                      Icons.block_rounded,
                                      color: theme.white,
                                      size: Dimension.radius.sixteen,
                                    ),
                                  ),
                                  title: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Block ",
                                          style: context.text.bodyMedium?.copyWith(
                                            color: theme.textSecondary,
                                            fontWeight: FontWeight.normal,
                                            height: 1,
                                          ),
                                        ),
                                        TextSpan(
                                          text: name,
                                          style: context.text.bodyMedium?.copyWith(
                                            color: theme.negative,
                                            fontWeight: FontWeight.bold,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.open_in_new_rounded,
                                    color: theme.backgroundTertiary,
                                    size: Dimension.radius.sixteen,
                                  ),
                                  onTap: () async {
                                    final confirmed = await showDialog<bool>(
                                      context: blockContext,
                                      builder: (_) => DeleteConfirmationWidget(affirm: 'Continue'),
                                    );
                                    if (!(confirmed ?? false)) return;
                                    if (!blockContext.mounted) return;

                                    final ProfileModel? authorization = await blockContext.pushNamed<ProfileModel>(
                                      CheckProfilePage.name,
                                      queryParameters: {'authorize': 'true'},
                                    );
                                    if (!blockContext.mounted) return;

                                    if (authorization == null) {
                                      return;
                                    } else if (authorization.identity.guid.same(as: identity.guid)) {
                                      context.read<FindProfileBloc>().add(FindProfile(identity: identity));
                                      return;
                                    }

                                    final reason = await showDialog<LookupEntity>(
                                      context: blockContext,
                                      builder: (_) => const BlockReasonFilter(selection: null),
                                    );
                                    if (!blockContext.mounted) return;

                                    blockContext
                                        .read<BlockBloc>()
                                        .add(BlockAbuser(abuser: identity, reason: reason?.text ?? ''));
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(Dimension.radius.sixteen)),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

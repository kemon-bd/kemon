import '../../../features/lookup/lookup.dart';
import '../../../features/profile/profile.dart';
import '../../config/config.dart';
import '../shared.dart';

class ProfileCheckAlert extends StatelessWidget {
  final List<LookupEntity> checks;
  const ProfileCheckAlert({
    super.key,
    required this.checks,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return BlocProvider(
          create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: context.auth.profile!.identity)),
          child: Container(
            decoration: BoxDecoration(
              color: theme.backgroundPrimary,
              borderRadius: BorderRadius.circular(0).copyWith(
                topLeft: const Radius.circular(32),
                topRight: const Radius.circular(32),
              ),
              border: Border(
                top: BorderSide(color: theme.backgroundSecondary, width: 8),
              ),
            ),
            padding: const EdgeInsets.all(16).copyWith(bottom: 16 + context.bottomInset),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              children: [
                const SizedBox(height: 8),
                Text(
                  'Incomplete profile',
                  style: TextStyles.title(context: context, color: theme.primary),
                ),
                const SizedBox(height: 4),
                Text(
                  'KEMON enforces ALL users to complete 50% of their public profile to prevent spam, troll, in-appropriate behavior and keeping the community safe.',
                  style: TextStyles.body(context: context, color: theme.textSecondary),
                ),
                Divider(height: 42, thickness: .25, color: theme.backgroundTertiary),
                Text(
                  'Here is the missing information about your profile:',
                  style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                ),
                Container(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: context.height * 0.5,
                  ),
                  child: BlocConsumer<FindProfileBloc, FindProfileState>(
                    listener: (context, state) {
                      if (state is FindProfileError) {
                        context.errorNotification(message: state.failure.message);
                      } else if (state is FindProfileDone) {
                        final profile = state.profile;
                        final checkpoints = (context.read<FindLookupBloc>().state as FindLookupDone).lookups;
                        if (profile.progress(checks: checkpoints) >= 90) {
                          context.pop(true);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is FindProfileDone) {
                        final profile = state.profile;
                        return ListView.separated(
                          itemBuilder: (_, index) {
                            final checkpoint = checks[index];
                            return ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              leading: Icon(Icons.warning_rounded, color: theme.warning),
                              title: Text(
                                checkpoint.text.sentenceCase,
                                style: TextStyles.body(context: context, color: theme.warning),
                              ),
                              subtitle: Text(
                                "+ ${checkpoint.point}",
                                style: TextStyles.caption(context: context, color: theme.warning),
                              )
                                  .animate(
                                    onComplete: (controller) => controller.repeat(reverse: true),
                                  )
                                  .fade(duration: 600.milliseconds),
                              trailing: checkpoint.text.match(like: "verified")
                                  ? IconButton(
                                      padding: EdgeInsets.all(0),
                                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                      onPressed: () async {
                                        if (checkpoint.text.match(like: "phone") && (profile.phone?.number ?? "").isEmpty) {
                                          context.pushNamed(EditProfilePage.name);
                                        } else if (checkpoint.text.match(like: "email") &&
                                            (profile.email?.address ?? "").isEmpty) {
                                          context.pushNamed(EditProfilePage.name);
                                        }
                                        final confirmed = await showDialog<bool>(
                                          context: context,
                                          builder: (_) => VerificationConfirmationWidget(affirm: 'Continue'),
                                        );

                                        if (!(confirmed ?? false)) return;
                                        if (!context.mounted) return;

                                        final verified = await showModalBottomSheet<bool>(
                                          context: context,
                                          isScrollControlled: true,
                                          barrierColor: context.barrierColor,
                                          builder: (_) => MultiBlocProvider(
                                            providers: [
                                              BlocProvider(
                                                create: (_) => sl<RequestOtpForPasswordChangeBloc>()
                                                  ..add(
                                                    RequestOtpForPhoneOrEmailVerification(
                                                        username: checkpoint.text.match(like: "phone")
                                                            ? profile.phone!.number
                                                            : profile.email!.address),
                                                  ),
                                              ),
                                              BlocProvider(create: (_) => sl<UpdateProfileBloc>()),
                                            ],
                                            child: Padding(
                                              padding: context.viewInsets,
                                              child: VerifyPhoneOrEmailWidget(
                                                username: checkpoint.text.match(like: "phone")
                                                    ? profile.phone!.number
                                                    : profile.email!.address,
                                              ),
                                            ),
                                          ),
                                        );
                                        if (!(verified ?? true)) return;
                                        if (!context.mounted) return;
                                        context
                                            .read<FindProfileBloc>()
                                            .add(RefreshProfile(identity: context.auth.profile!.identity));
                                      },
                                      icon: Icon(Icons.verified_outlined, color: theme.link),
                                    )
                                  : null,
                            );
                          },
                          separatorBuilder: (_, __) => Divider(height: Dimension.padding.vertical.large),
                          itemCount: checks.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          physics: const ScrollPhysics(),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

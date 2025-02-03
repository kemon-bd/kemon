import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';
import '../../profile.dart';

class ProfileProgressWidget extends StatelessWidget {
  const ProfileProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<FindProfileBloc, FindProfileState>(
          builder: (_, state) {
            if (state is FindProfileDone) {
              final profile = state.profile;
              return ProfilePointsBuilder(
                builder: (checks) {
                  final progress = (state.profile.progress(checks: checks)) / 100;
                  final missing = state.profile.missing(checks: checks);
                  return progress == 1
                      ? SizedBox.shrink()
                      : Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimension.radius.sixteen,
                            vertical: Dimension.radius.eight,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimension.radius.sixteen,
                            vertical: Dimension.radius.eight,
                          ),
                          decoration: BoxDecoration(
                            color: progress < 50 ? theme.warning.withAlpha(15) : theme.backgroundSecondary,
                            borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
                            border: Border.all(
                              color: progress < 50 ? theme.warning.withAlpha(125) : theme.backgroundTertiary,
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${(progress * 100).round()}% Progress',
                                style: TextStyles.body(
                                  context: context,
                                  color: progress < 50 ? theme.warning : theme.textSecondary,
                                ),
                              )
                                  .animate(
                                    onComplete: (controller) => controller.repeat(reverse: true),
                                  )
                                  .fade(
                                    begin: 1.0,
                                    end: .1,
                                    duration: Durations.medium2,
                                    delay: Durations.extralong4,
                                  ),
                              SizedBox(height: Dimension.padding.vertical.small),
                              LinearProgressIndicator(
                                value: progress,
                                backgroundColor: theme.backgroundTertiary,
                                valueColor: AlwaysStoppedAnimation(progress < 50 ? theme.warning : theme.primary),
                                borderRadius: BorderRadius.circular(Dimension.radius.max),
                              ),
                              SizedBox(height: Dimension.padding.vertical.large),
                              ...missing.mapIndexed(
                                (index, checkpoint) => Padding(
                                  padding: const EdgeInsets.all(0).copyWith(
                                    bottom: index == (missing.length - 1) ? 0 : Dimension.padding.vertical.small,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.warning_rounded,
                                        size: Dimension.radius.twelve,
                                        color: theme.warning,
                                      ),
                                      SizedBox(width: Dimension.padding.horizontal.small),
                                      Text(
                                        checkpoint.text.sentenceCase,
                                        style: TextStyles.body(context: context, color: theme.warning),
                                      ),
                                      if (checkpoint.text.match(like: "verified")) ...[
                                        SizedBox(width: Dimension.padding.horizontal.small),
                                        IconButton(
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
                                            if (!(confirmed  ?? false)) return;
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
                                                              : profile.email!.address,
                                                        ),
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
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                },
              );
            }
            return Container();
          },
        );
      },
    );
  }
}

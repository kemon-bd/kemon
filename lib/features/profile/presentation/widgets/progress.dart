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
                                backgroundColor: theme.backgroundPrimary,
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
                                      if (checkpoint.text.match(like: "email")) ...[
                                        SizedBox(width: Dimension.padding.horizontal.small),
                                        if (checkpoint.text.match(like: "verif") && (profile.email?.address ?? "").isNotEmpty)
                                          VerifyEmailButton(email: TextEditingController(text: profile.email!.address)),
                                        if (!checkpoint.text.match(like: "verif") && (profile.email?.address ?? "").isEmpty)
                                          MissingEmailButton(),
                                      ],
                                      if (checkpoint.text.match(like: "phone")) ...[
                                        SizedBox(width: Dimension.padding.horizontal.small),
                                        if (checkpoint.text.match(like: "verif") && (profile.phone?.number ?? "").isNotEmpty)
                                          VerifyPhoneButton(phone: TextEditingController(text: profile.phone!.number)),
                                        if (!checkpoint.text.match(like: "verif") && (profile.phone?.number ?? "").isEmpty)
                                          MissingPhoneButton(),
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

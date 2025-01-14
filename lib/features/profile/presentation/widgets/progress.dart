
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
              return ProfilePointsBuilder(
                builder: (checks) {
                  final progress = (state.profile.progress(checks: checks)) / 100;
                  final missing = state.profile.missing(checks: checks);
                  return progress == 100
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
                            color: theme.backgroundSecondary,
                            borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
                            border: Border.all(
                              color: theme.backgroundTertiary,
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
                                style: TextStyles.body(context: context, color: theme.textSecondary),
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
                                valueColor: AlwaysStoppedAnimation(theme.primary),
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

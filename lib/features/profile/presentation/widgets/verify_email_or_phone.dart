import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class VerifyPhoneOrEmailWidget extends StatefulWidget {
  final String username;
  const VerifyPhoneOrEmailWidget({super.key, required this.username});

  @override
  State<VerifyPhoneOrEmailWidget> createState() => _VerifyPhoneOrEmailWidgetState();
}

class _VerifyPhoneOrEmailWidgetState extends State<VerifyPhoneOrEmailWidget> {
  bool verified = false;
  late final VerifyOtpForChangePasswordWidget verification;

  @override
  void initState() {
    super.initState();
    verification = VerifyOtpForChangePasswordWidget(
      onVerified: () {
        setState(() {
          verified = true;
        });
        late ProfileEntity profile;

        if (widget.username.match(like: '@')) {
          profile = context.auth.profile!.copyWith(emailVerified: true);
        } else {
          profile = context.auth.profile!.copyWith(phoneVerified: true);
        }

        context.read<UpdateProfileBloc>().add(UpdateProfile(profile: profile));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Container(
          color: theme.backgroundPrimary,
          child: verified
              ? Center(
                  child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                    listener: (context, state) {
                      if (state is UpdateProfileError) {
                        context.errorNotification(message: state.failure.message);
                      } else if (state is UpdateProfileDone) {
                        context.successNotification(
                          message: 'Congratulations. Your profile has been updated :)',
                        );
                        context.pop(true);
                      }
                    },
                    builder: (context, state) {
                      if (state is UpdateProfileLoading) {
                        return Icon(
                          Icons.verified_rounded,
                          color: theme.backgroundTertiary,
                          size: Dimension.size.horizontal.oneTwentyEight,
                        )
                            .animate(
                              onComplete: (controller) => controller.repeat(reverse: true),
                            )
                            .fade()
                            .scale(
                              begin: Offset(1.25, 1.25),
                              end: Offset(1, 1),
                              duration: 600.milliseconds,
                            );
                      }
                      return Icon(
                        Icons.verified_rounded,
                        color: theme.positive,
                        size: Dimension.size.horizontal.oneTwentyEight,
                      );
                    },
                  ),
                )
              : verification,
        );
      },
    );
  }
}

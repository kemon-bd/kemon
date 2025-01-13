import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class VerifyOtpForChangePasswordWidget extends StatefulWidget {
  final VoidCallback onVerified;
  const VerifyOtpForChangePasswordWidget({
    super.key,
    required this.onVerified,
  });

  @override
  State<VerifyOtpForChangePasswordWidget> createState() =>
      _VerifyOtpForChangePasswordWidgetState();
}

class _VerifyOtpForChangePasswordWidgetState
    extends State<VerifyOtpForChangePasswordWidget> {
  String code = '';
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? endTime;
  final Duration _duration = const Duration(seconds: 90);

  @override
  void initState() {
    super.initState();
    code = '';
    otpController.text = "";
    endTime = DateTime.now().add(_duration);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final defaultPinTheme = PinTheme(
          width: context.width * 0.125,
          height: context.width * 0.125,
          textStyle:
              TextStyles.body1(context: context, color: theme.textPrimary),
          decoration: BoxDecoration(
              color: theme.backgroundSecondary,
              borderRadius: BorderRadius.circular(8)),
        );

        final focusedPinTheme = defaultPinTheme.copyWith(
          textStyle:
              TextStyles.subTitle1(context: context, color: theme.textPrimary),
          decoration: defaultPinTheme.decoration!.copyWith(
            color: theme.backgroundSecondary,
            border: Border.all(color: theme.textPrimary, width: 2),
          ),
        );

        final submittedPinTheme = defaultPinTheme.copyWith(
          textStyle: TextStyles.subTitle1(context: context, color: theme.primary)
              .copyWith(
            fontWeight: FontWeight.bold,
          ),
          decoration: defaultPinTheme.decoration!.copyWith(
            color: theme.positiveBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.primary, width: 1),
          ),
        );

        final errorPinTheme = defaultPinTheme.copyWith(
          textStyle:
              TextStyles.subTitle1(context: context, color: theme.negative)
                  .copyWith(
            fontWeight: FontWeight.bold,
          ),
          decoration: defaultPinTheme.decoration!.copyWith(
            color: theme.negative.withAlpha(50),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.negative, width: 1),
          ),
        );
        return KeyboardDismissOnTap(
          child: BlocListener<RequestOtpForPasswordChangeBloc,
              RequestOtpForPasswordChangeState>(
            listener: (context, state) {
              if (state is RequestOtpForPasswordChangeDone) {
                setState(() {
                  endTime = DateTime.now().add(_duration);
                  code = state.otp;
                });
              }
            },
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                padding: EdgeInsets.all(Dimension.radius.sixteen),
                children: [
                  Text(
                    'Verify OTP',
                    style: TextStyles.subTitle(
                            context: context, color: theme.textPrimary)
                        .copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: Dimension.padding.vertical.small),
                  Text(
                    'A 6 digit verification code has been sent to your phone / email address',
                    style: TextStyles.body1(
                            context: context, color: theme.textSecondary)
                        .copyWith(
                      height: 1,
                    ),
                  ),
                  SizedBox(height: Dimension.size.vertical.seventyTwo),
                  Pinput(
                    length: 6,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    closeKeyboardWhenCompleted: true,
                    controller: otpController,
                    pinAnimationType: PinAnimationType.fade,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    errorPinTheme: errorPinTheme,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    validator: (value) => ((value ?? "") == code) ? null : "",
                  ),
                  SizedBox(height: Dimension.size.vertical.twentyFour),
                  Center(
                    child: BlocBuilder<RequestOtpForPasswordChangeBloc,
                        RequestOtpForPasswordChangeState>(
                      builder: (context, state) {
                        if (state is RequestOtpForPasswordChangeLoading) {
                          return Text(
                            'Please wait...',
                            style: TextStyles.body1(
                                context: context, color: theme.textSecondary),
                          );
                        }
                        return endTime != null
                            ? TimerCountdown(
                                format: CountDownTimerFormat.minutesSeconds,
                                onEnd: () {
                                  setState(() {
                                    endTime = null;
                                  });
                                },
                                spacerWidth: 4,
                                endTime:
                                    endTime ?? DateTime.now().add(_duration),
                                enableDescriptions: false,
                                timeTextStyle: TextStyles.body1(
                                    context: context, color: theme.textPrimary),
                                colonsTextStyle: TextStyles.body1(
                                    context: context, color: theme.textPrimary),
                              )
                            : Text.rich(
                                TextSpan(
                                  text: "",
                                  children: [
                                    TextSpan(
                                      text: "Didn't receive the OTP? ",
                                      style: TextStyles.body1(
                                          context: context,
                                          color: theme.textSecondary),
                                    ),
                                    TextSpan(
                                      text: "Resend OTP",
                                      style: TextStyles.body1(
                                              context: context,
                                              color: theme.primary)
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context
                                              .read<
                                                  RequestOtpForPasswordChangeBloc>()
                                              .add(RequestOtpForPasswordChange(
                                                  username:
                                                      context.auth.username!));

                                          otpController.clear();
                                        },
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              );
                      },
                    ),
                  ),
                  SizedBox(height: Dimension.size.vertical.seventyTwo),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (formKey.currentState?.validate() ?? false) {
                          widget.onVerified();
                        }
                      },
                      child: Text(
                        "Verify".toUpperCase(),
                        style: TextStyles.button(context: context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

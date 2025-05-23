import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../../profile/profile.dart';
import '../../../registration/registration.dart';

class VerifyOTPPage extends StatefulWidget {
  static const String path = '/verify-otp';
  static const String name = 'VerifyOTPPage';

  final bool authorize;
  final String otp;
  final String username;

  const VerifyOTPPage({
    super.key,
    required this.otp,
    required this.username,
    this.authorize = false,
  });

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  late String code;
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? endTime;
  final Duration _duration = const Duration(seconds: 90);

  @override
  void initState() {
    super.initState();

    if (kReleaseMode) {
      InAppUpdate.checkForUpdate().then(
        (event) async {
          if (event.updateAvailability == UpdateAvailability.updateAvailable) {
            await InAppUpdate.performImmediateUpdate();
          }
        },
      );
    }
    code = widget.otp;
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
          textStyle: TextStyles.body(context: context, color: theme.textPrimary),
          decoration: BoxDecoration(color: theme.backgroundSecondary, borderRadius: BorderRadius.circular(8)),
        );

        final focusedPinTheme = defaultPinTheme.copyWith(
          textStyle: TextStyles.subTitle(context: context, color: theme.textPrimary),
          decoration: defaultPinTheme.decoration!.copyWith(
            color: theme.backgroundSecondary,
            border: Border.all(color: theme.textPrimary, width: 2),
          ),
        );

        final submittedPinTheme = defaultPinTheme.copyWith(
          textStyle: TextStyles.subTitle(context: context, color: theme.primary).copyWith(
            fontWeight: FontWeight.bold,
          ),
          decoration: defaultPinTheme.decoration!.copyWith(
            color: theme.positiveBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.primary, width: 1),
          ),
        );

        final errorPinTheme = defaultPinTheme.copyWith(
          textStyle: TextStyles.subTitle(context: context, color: theme.negative).copyWith(
            fontWeight: FontWeight.bold,
          ),
          decoration: defaultPinTheme.decoration!.copyWith(
            color: theme.negative.withAlpha(50),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.negative, width: 1),
          ),
        );
        return KeyboardDismissOnTap(
          child: Scaffold(
            backgroundColor: theme.backgroundPrimary,
            body: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                      top: context.topInset + 16,
                      left: 24,
                      right: 24,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(color: theme.primary),
                    child: KeyboardVisibilityBuilder(
                      builder: (_, visible) => visible
                          ? IconButton(
                              padding: const EdgeInsets.all(0),
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              onPressed: () {
                                if (context.canPop()) {
                                  context.pop();
                                } else {
                                  context.goNamed(HomePage.name);
                                }
                              },
                              icon: Icon(Icons.arrow_back_rounded, color: theme.white),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  padding: const EdgeInsets.all(0),
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                  onPressed: () {
                                    if (context.canPop()) {
                                      context.pop();
                                    } else {
                                      context.goNamed(HomePage.name);
                                    }
                                  },
                                  icon: Icon(Icons.arrow_back_rounded, color: theme.white),
                                ),
                                const Spacer(),
                                Text(
                                  'Verify OTP',
                                  style: context.text.headlineSmall?.copyWith(
                                    color: theme.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'A ${widget.otp.length} digit verification code has been sent to your phone / email address',
                                  style: context.text.bodyMedium?.copyWith(
                                    color: theme.semiWhite,
                                    fontWeight: FontWeight.normal,
                                    height: 1.15,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16).copyWith(bottom: 16 + context.bottomInset),
                      children: [
                        const SizedBox(height: 42),
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
                        const SizedBox(height: 20),
                        Center(
                          child: BlocConsumer<OtpBloc, OtpState>(
                            listener: (context, state) {
                              if (state is OtpDone) {
                                endTime = DateTime.now().add(_duration);
                                code = state.code;
                              }
                            },
                            builder: (context, state) {
                              if (state is OtpLoading) {
                                return Text(
                                  'Please wait...',
                                  style: TextStyles.body(context: context, color: theme.textSecondary),
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
                                      endTime: endTime ?? DateTime.now().add(_duration),
                                      enableDescriptions: false,
                                      timeTextStyle: TextStyles.body(context: context, color: theme.textPrimary),
                                      colonsTextStyle: TextStyles.body(context: context, color: theme.textPrimary),
                                    )
                                  : Text.rich(
                                      TextSpan(
                                        text: "",
                                        children: [
                                          TextSpan(
                                            text: "Didn't receive the OTP? ",
                                            style: TextStyles.body(context: context, color: theme.textSecondary),
                                          ),
                                          TextSpan(
                                            text: "Resend OTP",
                                            style: TextStyles.body(context: context, color: theme.primary).copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                context.read<OtpBloc>().add(ResendOtp(username: widget.username));

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
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (formKey.currentState?.validate() ?? false) {
                                final ProfileModel? profile = await context.pushNamed(
                                  RegistrationPage.name,
                                  queryParameters: {
                                    'username': widget.username,
                                    'authorize': widget.authorize.toString(),
                                  },
                                );
                                if (!context.mounted) return;
                                context.pop(profile);
                              }
                            },
                            child: Text(
                              "Verify".toUpperCase(),
                              style: TextStyles.button(context: context),
                            ),
                          ),
                        ),
                        const SizedBox(height: 42),
                      ],
                    ),
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

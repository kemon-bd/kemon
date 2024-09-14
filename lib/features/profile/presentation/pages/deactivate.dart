import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../../home/home.dart';
import '../../profile.dart';

class DeactivateAccountPage extends StatefulWidget {
  static const String path = '/deactivate-account';
  static const String name = 'DeactivateAccountPage';

  final String otp;

  const DeactivateAccountPage({
    super.key,
    required this.otp,
  });

  @override
  State<DeactivateAccountPage> createState() => _DeactivateAccountPageState();
}

class _DeactivateAccountPageState extends State<DeactivateAccountPage> {
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
          textStyle:
              TextStyles.body(context: context, color: theme.textPrimary),
          decoration: BoxDecoration(
              color: theme.backgroundSecondary,
              borderRadius: BorderRadius.circular(8)),
        );

        final focusedPinTheme = defaultPinTheme.copyWith(
          textStyle:
              TextStyles.subTitle(context: context, color: theme.textPrimary),
          decoration: defaultPinTheme.decoration!.copyWith(
            color: theme.backgroundSecondary,
            border: Border.all(color: theme.textPrimary, width: 2),
          ),
        );

        final submittedPinTheme = defaultPinTheme.copyWith(
          textStyle: TextStyles.subTitle(context: context, color: theme.primary)
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
              TextStyles.subTitle(context: context, color: theme.negative)
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
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state.profile == null) {
                context.goNamed(HomePage.name);
              }
            },
            child: Scaffold(
              backgroundColor: theme.backgroundPrimary,
              body: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.maxFinite,
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      decoration: BoxDecoration(
                        color: theme.primary,
                        image: const DecorationImage(
                          image: AssetImage('images/logo/full.png'),
                          opacity: .05,
                          scale: 50,
                          repeat: ImageRepeat.repeat,
                        ),
                      ),
                      child: KeyboardVisibilityBuilder(
                        builder: (_, visible) => visible
                            ? Container()
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Verify OTP',
                                    style: TextStyles.headline(
                                            context: context,
                                            color: theme.white)
                                        .copyWith(
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'A ${widget.otp.length} digit verification code has been sent to your phone / email address',
                                    style: TextStyles.body(
                                            context: context,
                                            color: theme.semiWhite)
                                        .copyWith(
                                      height: 1,
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
                        padding: const EdgeInsets.all(16)
                            .copyWith(bottom: 16 + context.bottomInset),
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
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            validator: (value) =>
                                ((value ?? "") == code) ? null : "",
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: BlocConsumer<DeactivateAccountBloc,
                                DeactivateAccountState>(
                              listener: (context, state) {
                                if (state is DeactivateAccountOtp) {
                                  endTime = DateTime.now().add(_duration);
                                  code = state.otp;
                                }
                              },
                              builder: (context, state) {
                                if (state is DeactivateAccountLoading) {
                                  return Text(
                                    'Please wait...',
                                    style: TextStyles.body(
                                        context: context,
                                        color: theme.textSecondary),
                                  );
                                }
                                return endTime != null
                                    ? TimerCountdown(
                                        format:
                                            CountDownTimerFormat.minutesSeconds,
                                        onEnd: () {
                                          setState(() {
                                            endTime = null;
                                          });
                                        },
                                        spacerWidth: 4,
                                        endTime: endTime ??
                                            DateTime.now().add(_duration),
                                        enableDescriptions: false,
                                        timeTextStyle: TextStyles.body(
                                            context: context,
                                            color: theme.textPrimary),
                                        colonsTextStyle: TextStyles.body(
                                            context: context,
                                            color: theme.textPrimary),
                                      )
                                    : Text.rich(
                                        TextSpan(
                                          text: "",
                                          children: [
                                            TextSpan(
                                              text: "Didn't receive the OTP? ",
                                              style: TextStyles.body(
                                                  context: context,
                                                  color: theme.textSecondary),
                                            ),
                                            TextSpan(
                                              text: "Resend OTP",
                                              style: TextStyles.body(
                                                      context: context,
                                                      color: theme.primary)
                                                  .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // TODO:
                                                  // context.read<DeactivateAccountBloc>().add(ResendDeactivateAccount(username: widget.username));

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
                            child: BlocConsumer<DeactivateAccountBloc,
                                DeactivateAccountState>(
                              listener: (context, state) {
                                if (state is DeactivateAccountDone) {
                                  context.auth
                                      .add(const AuthenticationLogout());
                                }
                              },
                              builder: (context, state) {
                                if (state is DeactivateAccountLoading) {
                                  return ElevatedButton(
                                    onPressed: () {},
                                    child: NetworkingIndicator(
                                        dimension: 28, color: theme.white),
                                  );
                                }
                                return ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      context.read<DeactivateAccountBloc>().add(
                                          DeactivateAccount(
                                              otp: otpController.text));
                                    }
                                  },
                                  child: Text(
                                    "Verify".toUpperCase(),
                                    style: TextStyles.miniHeadline(
                                      context: context,
                                      color: theme.white,
                                    ).copyWith(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                );
                              },
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
          ),
        );
      },
    );
  }
}

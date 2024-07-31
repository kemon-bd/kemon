import '../../../../core/shared/shared.dart';

class VerifyOTPPage extends StatefulWidget {
  static const String path = '/verify-otp';
  static const String name = 'VerifyOTPPage';

  final String otp;
  final String username;

  const VerifyOTPPage({
    super.key,
    required this.otp,
    required this.username,
  });

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return KeyboardDismissOnTap(
          child: Scaffold(
            backgroundColor: theme.backgroundPrimary,
            body: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
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
                                  style: TextStyles.headline(context: context, color: theme.white).copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'A ${widget.otp.length} digit verification code has been sent to your phone / email address',
                                  style: TextStyles.body(context: context, color: theme.semiWhite).copyWith(
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
                      padding: const EdgeInsets.all(16).copyWith(bottom: 16 + context.bottomInset),
                      children: [
                        const SizedBox(height: 42),
                        TextFormField(
                          style: TextStyles.body(context: context, color: theme.textPrimary),
                          controller: otpController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: (val) => (val?.isNotEmpty ?? false) ? null : "",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: theme.backgroundSecondary,
                            hintText: "username / email",
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (formKey.currentState?.validate() ?? false) {
                                // TODO:
                                /* context.pushReplacementNamed(
                                      RegistrationPage.name,
                                    ); */
                              }
                            },
                            child: Text(
                              "Verify".toUpperCase(),
                              style: TextStyles.miniHeadline(
                                context: context,
                                color: theme.backgroundPrimary,
                              ).copyWith(
                                fontWeight: FontWeight.w900,
                              ),
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

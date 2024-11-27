import '../../../../core/shared/shared.dart';
import '../../../login/login.dart';
import '../../profile.dart';

class CheckProfilePage extends StatefulWidget {
  static const String path = '/check-profile';
  static const String name = 'CheckProfilePage';
  final bool authorize;
  const CheckProfilePage({
    super.key,
    this.authorize = false,
  });

  @override
  State<CheckProfilePage> createState() => _CheckProfilePageState();
}

class _CheckProfilePageState extends State<CheckProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (context.auth.remember ?? false) {
      usernameController.text = context.auth.username ?? '';
    }

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
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 24, bottom: 16).copyWith(top: context.topInset + 8),
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
                          ? IconButton(
                              padding: const EdgeInsets.all(0),
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              onPressed: context.pop,
                              icon: Icon(Icons.arrow_back_rounded, color: theme.white),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  padding: const EdgeInsets.all(0),
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                  onPressed: context.pop,
                                  icon: Icon(Icons.arrow_back_rounded, color: theme.white),
                                ),
                                const Spacer(),
                                Text(
                                  'Welcome to\nKEMON',
                                  style: TextStyles.headline(context: context, color: theme.white).copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Sign in to your account to continue',
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
                        Semantics(
                          label: 'Email/Phone',
                          child: TextFormField(
                            style: TextStyles.body(context: context, color: theme.textPrimary),
                            controller: usernameController,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            validator: (val) => (val?.isNotEmpty ?? false) ? null : "",
                            decoration: InputDecoration(
                              hintText: "required",
                              helperText: '',
                              helperStyle: TextStyle(fontSize: 0),
                              errorStyle: TextStyle(fontSize: 0),
                              label: Text(
                                'Email/Phone',
                                style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                              ),
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: BlocConsumer<CheckProfileBloc, CheckProfileState>(
                            listener: (context, state) async {
                              if (state is CheckProfileError) {
                                context.errorNotification(message: state.failure.message);
                              } else if (state is CheckProfileExistingUser) {
                                final ProfileModel? profile = await context.pushNamed(
                                  LoginPage.name,
                                  queryParameters: {
                                    'guid': state.profile.identity.guid,
                                    'username': usernameController.text,
                                    'authorize': widget.authorize.toString(),
                                  },
                                );
                                if (!context.mounted) return;
                                context.pop(profile);
                              } else if (state is CheckProfileNewUser) {
                                final ProfileModel? profile = await context.pushNamed(
                                  VerifyOTPPage.name,
                                  queryParameters: {
                                    'username': usernameController.text,
                                    'otp': state.otp,
                                    'authorize': widget.authorize.toString(),
                                  },
                                );
                                if (!context.mounted) return;
                                context.pop(profile);
                              }
                            },
                            builder: (context, state) {
                              if (state is CheckProfileLoading) {
                                return ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                  },
                                  child: NetworkingIndicator(dimension: 28, color: theme.white),
                                );
                              }
                              return ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  if (formKey.currentState?.validate() ?? false) {
                                    context.read<CheckProfileBloc>().add(CheckProfile(username: usernameController.text));
                                  }
                                },
                                child: Text(
                                  "Continue".toUpperCase(),
                                  style: TextStyles.button(context: context),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 42),
                        KeyboardVisibilityBuilder(
                          builder: (_, visible) => visible
                              ? Container()
                              : Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () async {
                                      await context.pushNamed(ForgotPasswordPage.name);
                                    },
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyles.title(context: context, color: theme.link),
                                    ),
                                  ),
                                ),
                        ),
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

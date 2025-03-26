import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
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
                                  'Welcome to\nKEMON',
                                  style: TextStyles.title(context: context, color: theme.white).copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Sign in to your account to continue',
                                  style: TextStyles.caption(context: context, color: theme.semiWhite).copyWith(
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
                              hintStyle: TextStyles.body(context: context, color: theme.textPrimary),
                              helperText: '',
                              helperStyle: TextStyle(fontSize: 0),
                              errorStyle: TextStyle(fontSize: 0),
                              label: Text(
                                'Email/Phone',
                                style: TextStyles.body(context: context, color: theme.textPrimary),
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
                                  child: NetworkingIndicator(dimension: Dimension.radius.eighteen, color: theme.white),
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
                        SizedBox(height: Dimension.padding.vertical.max),
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
                                      style: TextStyles.subTitle(context: context, color: theme.link),
                                    ),
                                  ),
                                ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                height: Dimension.size.vertical.fortyEight,
                                endIndent: Dimension.padding.horizontal.large,
                              ),
                            ),
                            Text(
                              'or',
                              style: TextStyles.caption(context: context, color: theme.backgroundTertiary),
                            ),
                            Expanded(
                              child: Divider(
                                height: Dimension.size.vertical.fortyEight,
                                indent: Dimension.padding.horizontal.large,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: Dimension.padding.horizontal.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.backgroundPrimary,
                                border: Border.all(
                                  color: theme.backgroundTertiary,
                                  width: .5,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                              child: BlocConsumer<GoogleSignInBloc, GoogleSignInState>(
                                listener: (context, state) async {
                                  if (state is GoogleSignInDone) {
                                    if (widget.authorize) {
                                      context.pop(state.profile);
                                    } else {
                                      context.pushReplacementNamed(ProfilePage.name);
                                    }
                                  } else if (state is GoogleSignInError) {
                                    context.errorNotification(message: state.failure.message);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is GoogleSignInLoading) {
                                    return IconButton(
                                      onPressed: () {},
                                      padding: EdgeInsets.all(0),
                                      icon: NetworkingIndicator(
                                        dimension: Dimension.radius.eighteen,
                                        color: theme.google,
                                      ),
                                    );
                                  }
                                  return IconButton(
                                    onPressed: () async {
                                      if ((context.auth.username ?? "").isEmpty) {
                                        final acknowledged =
                                            await showDialog(context: context, builder: (_) => AcknowledgementAlert());
                                        if (!acknowledged) return;
                                        if (!context.mounted) return;
                                      }
                                      context.read<GoogleSignInBloc>().add(SignInWithGoogle());
                                    },
                                    padding: EdgeInsets.all(0),
                                    icon: SvgPicture.asset(
                                      'images/logo/google.svg',
                                      width: Dimension.radius.eighteen,
                                      height: Dimension.radius.eighteen,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.backgroundPrimary,
                                border: Border.all(
                                  color: theme.backgroundTertiary,
                                  width: .5,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                              child: BlocConsumer<FacebookLoginBloc, FacebookLoginState>(
                                listener: (context, state) async {
                                  if (state is FacebookLoginDone) {
                                    if (widget.authorize) {
                                      context.pop(state.profile);
                                    } else {
                                      context.pushReplacementNamed(ProfilePage.name);
                                    }
                                  } else if (state is FacebookLoginError) {
                                    context.errorNotification(message: state.failure.message);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is FacebookLoginLoading) {
                                    return IconButton(
                                      onPressed: () {},
                                      padding: EdgeInsets.all(0),
                                      icon: NetworkingIndicator(
                                        dimension: Dimension.radius.eighteen,
                                        color: theme.google,
                                      ),
                                    );
                                  }
                                  return IconButton(
                                    onPressed: () async {
                                      if ((context.auth.username ?? "").isEmpty) {
                                        final acknowledged =
                                            await showDialog(context: context, builder: (_) => AcknowledgementAlert());
                                        if (!acknowledged) return;
                                        if (!context.mounted) return;
                                      }
                                      context.read<FacebookLoginBloc>().add(LoginWithFacebook());
                                    },
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(
                                      FontAwesomeIcons.facebook,
                                      size: Dimension.radius.eighteen,
                                      color: theme.facebook,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.backgroundPrimary,
                                border: Border.all(
                                  color: theme.backgroundTertiary,
                                  width: .5,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                              child: BlocConsumer<AppleLoginBloc, AppleLoginState>(
                                listener: (context, state) async {
                                  if (state is AppleLoginDone) {
                                    if (widget.authorize) {
                                      context.pop(state.profile);
                                    } else {
                                      context.pushReplacementNamed(ProfilePage.name);
                                    }
                                  } else if (state is AppleLoginError) {
                                    context.errorNotification(message: state.failure.message);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is AppleLoginLoading) {
                                    return IconButton(
                                      onPressed: () {},
                                      padding: EdgeInsets.all(0),
                                      icon: NetworkingIndicator(
                                        dimension: Dimension.radius.eighteen,
                                        color: Colors.grey.shade800,
                                      ),
                                    );
                                  }
                                  return IconButton(
                                    onPressed: () async {
                                      if ((context.auth.username ?? "").isEmpty) {
                                        final acknowledged =
                                            await showDialog(context: context, builder: (_) => AcknowledgementAlert());
                                        if (!acknowledged) return;
                                        if (!context.mounted) return;
                                      }
                                      context.read<AppleLoginBloc>().add(LoginWithApple());
                                    },
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(
                                      FontAwesomeIcons.apple,
                                      size: Dimension.radius.eighteen,
                                      color: Colors.grey.shade800,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
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

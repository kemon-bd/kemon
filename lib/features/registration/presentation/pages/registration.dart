import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../registration.dart';

class RegistrationPage extends StatefulWidget {
  static const String path = '/registration';
  static const String name = 'RegistrationPage';

  final String username;

  const RegistrationPage({
    super.key,
    required this.username,
  });

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isObscured = true;
  bool isRemembered = false;

  @override
  void initState() {
    super.initState();

    if (context.auth.remember ?? false) {
      usernameController.text = context.auth.username ?? '';
      passwordController.text = context.auth.password ?? '';
      isRemembered = true;
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
        return BlocListener<AuthenticationBloc, AuthenticationState?>(
          listener: (context, state) {
            if (state != null) {
              context.successNotification(
                message: 'Logged-in successfully !!!',
              );
              // TODO
              // context.pushReplacementNamed(ProfilePage.name);
            }
          },
          child: KeyboardDismissOnTap(
            child: Scaffold(
              backgroundColor: theme.backgroundPrimary,
              body: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.maxFinite,
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(left: 24, bottom: 16),
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
                  Form(
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
                          controller: usernameController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: (val) => (val?.isNotEmpty ?? false) ? null : "",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: theme.backgroundSecondary,
                            hintText: "username / email",
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          style: TextStyles.body(context: context, color: theme.textPrimary),
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          validator: (val) => (val?.isNotEmpty ?? false) ? null : "",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: theme.backgroundSecondary,
                            hintText: "password",
                            suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off, color: theme.textPrimary),
                              onPressed: () {
                                setState(() {
                                  isObscured = !isObscured;
                                });
                              },
                            ),
                          ),
                          obscureText: isObscured,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Remember me",
                              style: TextStyles.title(context: context, color: theme.textPrimary),
                            ),
                            Switch(
                              activeColor: theme.backgroundSecondary,
                              activeTrackColor: theme.primary,
                              inactiveThumbColor: theme.primary,
                              inactiveTrackColor: theme.backgroundSecondary,
                              value: isRemembered,
                              onChanged: (flag) {
                                setState(() {
                                  isRemembered = !isRemembered;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: BlocConsumer<RegistrationBloc, RegistrationState>(
                            listener: (context, state) {
                              if (state is RegistrationError) {
                                context.errorNotification(message: state.failure.message);
                              } else if (state is RegistrationDone) {
                                context.pop(true);
                              }
                            },
                            builder: (context, state) {
                              if (state is RegistrationLoading) {
                                return ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                  },
                                  child: NetworkingIndicator(dimension: 28, color: theme.backgroundPrimary),
                                );
                              }
                              return ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  if (formKey.currentState?.validate() ?? false) {
                                    // TODO:
                                    /* context.read<RegistrationBloc>().add(
                                          Registration(
                                            username: usernameController.text,
                                            password: passwordController.text,
                                            remember: isRemembered,
                                          ),
                                        ); */
                                  }
                                },
                                child: Text(
                                  "Registration".toUpperCase(),
                                  style: TextStyles.miniHeadline(
                                    context: context,
                                    color: theme.backgroundPrimary,
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
                  Expanded(
                    flex: 2,
                    child: KeyboardVisibilityBuilder(
                      builder: (_, visible) => visible
                          ? Container()
                          : Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(bottom: context.bottomInset + 16),
                              child: InkWell(
                                onTap: () {
                                  // TODO
                                  // context.pushNamed(ForgotPasswordPage.name);
                                },
                                borderRadius: BorderRadius.circular(100),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyles.subTitle(context: context, color: theme.primary).copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
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

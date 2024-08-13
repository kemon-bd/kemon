import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../../profile/profile.dart';
import '../../login.dart';

class LoginPage extends StatefulWidget {
  static const String path = '/login';
  static const String name = 'LoginPage';

  final String username;

  const LoginPage({
    super.key,
    required this.username,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isObscured = true;
  bool isRemembered = false;

  @override
  void initState() {
    super.initState();

    if (context.auth.remember ?? false) {
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
              context.pushReplacementNamed(ProfilePage.name);
            }
          },
          child: KeyboardDismissOnTap(
            child: Scaffold(
              backgroundColor: theme.backgroundPrimary,
              body: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 24, bottom: 16, top: context.topInset + 16),
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
                          ? Container(height: 4)
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hey, we know you.',
                                  style: TextStyles.headline(context: context, color: theme.white).copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Continue with your secured password.',
                                  style: TextStyles.body(context: context, color: theme.semiWhite).copyWith(
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: const EdgeInsets.all(16).copyWith(bottom: 16 + context.bottomInset),
                        children: [
                          const SizedBox(height: 32),
                          ProfilePictureWidget(
                            size: 144,
                            border: 4,
                            borderColor: theme.positiveBackgroundTertiary,
                          ),
                          const SizedBox(height: 16),
                          ProfileNameWidget(
                            style: TextStyles.miniHeadline(context: context, color: theme.textSecondary),
                            align: TextAlign.center,
                            shimmerAlignment: Alignment.center,
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            style: TextStyles.body(context: context, color: theme.textPrimary),
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            validator: (val) => (val?.isNotEmpty ?? false) ? null : "",
                            decoration: InputDecoration(
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
                          const SizedBox(height: 12),
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
                            child: BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is LoginError) {
                                  context.errorNotification(message: state.failure.message);
                                } else if (state is LoginDone) {
                                  context.successNotification(message: 'Logged-in successfully !!!');
                                }
                              },
                              builder: (context, state) {
                                if (state is LoginLoading) {
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
                                      context.read<LoginBloc>().add(
                                            Login(
                                              username: widget.username,
                                              password: passwordController.text,
                                              remember: isRemembered,
                                            ),
                                          );
                                    }
                                  },
                                  child: Text(
                                    "Login".toUpperCase(),
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

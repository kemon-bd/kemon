import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../../home/home.dart';
import '../../../profile/profile.dart';
import '../../login.dart';

class LoginPage extends StatefulWidget {
  static const String path = '/login';
  static const String name = 'LoginPage';
  final bool? authorize;
  final String username;

  const LoginPage({
    super.key,
    required this.username,
    this.authorize,
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
              if (widget.authorize ?? false) {
                context.pop(state.profile);
              } else {
                context.goNamed(ProfilePage.name);
              }
            }
          },
          child: KeyboardDismissOnTap(
            child: Scaffold(
              backgroundColor: theme.backgroundPrimary,
              body: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 24, bottom: 16, top: context.topInset + 16),
                    decoration: BoxDecoration(
                      color: theme.primary,
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
                          : Row(
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
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hey, we know you.',
                                        style: context.text.headlineSmall?.copyWith(
                                          color: theme.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Continue with your secured password.',
                                        style: context.text.bodySmall?.copyWith(
                                          color: theme.white.withAlpha(200),
                                          fontWeight: FontWeight.normal,
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  Expanded(
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: const EdgeInsets.all(16).copyWith(bottom: 16 + context.bottomInset),
                        children: [
                          const SizedBox(height: 32),
                          BlocBuilder<FindProfileBloc, FindProfileState>(
                            builder: (context, state) {
                              if (state is FindProfileDone) {
                                final url = state.profile.profilePicture?.url ?? '';
                                final fallback = Center(
                                  child: Text(
                                    state.profile.name.symbol,
                                    style: context.text.bodyLarge?.copyWith(color: theme.white),
                                  ),
                                );
                                return Container(
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: theme.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: theme.white,
                                      width: 2,
                                      strokeAlign: BorderSide.strokeAlignOutside,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: url.isEmpty
                                      ? fallback
                                      : CachedNetworkImage(
                                          imageUrl: url,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          placeholder: (_, __) => ShimmerIcon(radius: 100),
                                          errorWidget: (_, __, ___) => fallback,
                                        ),
                                );
                              }
                              return ShimmerIcon(radius: 100);
                            },
                          ),
                          const SizedBox(height: 16),
                          ProfileNameWidget(
                            style: context.text.titleMedium?.copyWith(
                              height: 1.0,
                              color: theme.textSecondary,
                              fontWeight: FontWeight.normal,
                            ),
                            align: TextAlign.center,
                            shimmerAlignment: Alignment.center,
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            style: context.text.bodyMedium?.copyWith(
                              height: 1.0,
                              color: theme.textPrimary,
                              fontWeight: FontWeight.normal,
                            ),
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            validator: (val) => (val?.isNotEmpty ?? false) ? null : "",
                            decoration: InputDecoration(
                              hintText: "required",
                              hintStyle: context.text.bodyMedium?.copyWith(
                                height: 1.0,
                                color: theme.textSecondary,
                                fontWeight: FontWeight.normal,
                              ),
                              helperText: '',
                              helperStyle: TextStyle(fontSize: 0),
                              errorStyle: TextStyle(fontSize: 0),
                              label: Text(
                                'Password',
                                style: context.text.labelMedium?.copyWith(
                                  height: 1.0,
                                  color: theme.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              alignLabelWithHint: true,
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
                                style: context.text.bodyLarge?.copyWith(
                                  color: theme.textPrimary,
                                  fontWeight: FontWeight.normal,
                                ),
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
                                    child: NetworkingIndicator(dimension: Dimension.radius.eighteen, color: theme.white),
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
                                    style: context.text.titleMedium?.copyWith(
                                      color: theme.white,
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

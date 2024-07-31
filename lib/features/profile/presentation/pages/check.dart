import '../../../../core/shared/shared.dart';
import '../../../login/login.dart';
import '../../profile.dart';

class CheckProfilePage extends StatefulWidget {
  static const String path = '/check-profile';
  static const String name = 'CheckProfilePage';
  const CheckProfilePage({super.key});

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
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: BlocConsumer<CheckProfileBloc, CheckProfileState>(
                            listener: (context, state) {
                              if (state is CheckProfileError) {
                                context.errorNotification(message: state.failure.message);
                              } else if (state is CheckProfileExistingUser) {
                                context.pushReplacementNamed(
                                  LoginPage.name,
                                  queryParameters: {
                                    'guid': state.profile.identity.guid,
                                  },
                                );
                              } else if (state is CheckProfileNewUser) {
                                context.pushReplacementNamed(
                                  VerifyOTPPage.name,
                                  queryParameters: {
                                    'username': usernameController.text,
                                    'otp': state.otp,
                                  },
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is CheckProfileLoading) {
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
                                    context.read<CheckProfileBloc>().add(CheckProfile(username: usernameController.text));
                                  }
                                },
                                child: Text(
                                  "Continue".toUpperCase(),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

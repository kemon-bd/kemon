import 'package:kemon/features/authentication/authentication.dart';
import 'package:kemon/features/profile/profile.dart';

import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../registration.dart';

class RegistrationPage extends StatefulWidget {
  static const String path = '/registration';
  static const String name = 'RegistrationPage';

  final bool authorize;
  final String username;

  const RegistrationPage({
    super.key,
    required this.username,
    this.authorize = false,
  });

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool acknowledged = false;
  bool isObscured = true;
  bool isConfirmPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final validPassword = (password: passwordController, confirmPassword: confirmPasswordController).valid;
        return KeyboardDismissOnTap(
          child: Scaffold(
            backgroundColor: theme.backgroundPrimary,
            body: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (_, state) {
                if (state.profile != null) {
                  if (widget.authorize) {
                    context.pop(state.profile);
                  } else {
                    context.goNamed(HomePage.name);
                    context.pushNamed(ProfilePage.name);
                    context.pushNamed(EditProfilePage.name);
                  }
                }
              },
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.maxFinite,
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: 16,
                      ).copyWith(top: context.topInset + 8),
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
                                    'Create Account',
                                    style: context.text.headlineSmall?.copyWith(
                                      color: theme.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Fill up your password to finish setup of your account',
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
                    flex: 3,
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: const EdgeInsets.all(16).copyWith(bottom: 16 + context.bottomInset),
                        children: [
                          const SizedBox(height: 42),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.password, AutofillHints.newPassword],
                            validator: (value) => passwordController.validPassword ? null : "",
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              labelText: 'Password *',
                              labelStyle: TextStyles.body(context: context, color: theme.textPrimary),
                              hintText: 'required',
                              isDense: true,
                              hintStyle: TextStyles.body(
                                context: context,
                                color: theme.textSecondary.withAlpha(150),
                              ),
                              helperText: '',
                              helperStyle: const TextStyle(fontSize: 0, height: 0),
                              errorStyle: const TextStyle(fontSize: 0, height: 0),
                              suffixIcon: IconButton(
                                padding: EdgeInsets.zero,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                icon: Icon(
                                  isObscured ? Icons.visibility : Icons.visibility_off,
                                  color: passwordController.validPassword ? theme.textPrimary : theme.negative,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isObscured = !isObscured;
                                  });
                                },
                              ),
                            ),
                            obscureText: isObscured,
                            style: TextStyles.body(
                              context: context,
                              color: passwordController.validPassword ? theme.textPrimary : theme.negative,
                            ),
                          ),
                          SizedBox(height: 24),
                          TextFormField(
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.done,
                            validator: (value) => confirmPasswordController.validPassword ? null : "",
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              labelText: 'Confirm Password *',
                              labelStyle: TextStyles.body(context: context, color: theme.textPrimary),
                              hintText: 'required',
                              isDense: true,
                              hintStyle: TextStyles.body(
                                context: context,
                                color: theme.textSecondary.withAlpha(150),
                              ),
                              helperText: '',
                              helperStyle: const TextStyle(fontSize: 0, height: 0),
                              errorStyle: const TextStyle(fontSize: 0, height: 0),
                              suffixIcon: IconButton(
                                padding: EdgeInsets.zero,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                icon: Icon(
                                  isConfirmPasswordObscured ? Icons.visibility : Icons.visibility_off,
                                  color: confirmPasswordController.validPassword ? theme.textPrimary : theme.negative,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isConfirmPasswordObscured = !isConfirmPasswordObscured;
                                  });
                                },
                              ),
                            ),
                            obscureText: isConfirmPasswordObscured,
                            style: TextStyles.body(
                              context: context,
                              color: confirmPasswordController.validPassword ? theme.textPrimary : theme.negative,
                            ),
                          ),
                          SizedBox(height: Dimension.padding.vertical.max),
                          Row(
                            children: [
                              Icon(
                                passwordController.validPassword ? Icons.check_circle_rounded : Icons.circle_outlined,
                                color: passwordController.validPassword ? theme.positive : theme.negative,
                                size: Dimension.radius.twelve,
                              ),
                              SizedBox(width: Dimension.padding.horizontal.medium),
                              Expanded(
                                child: Text(
                                  "Password must be at least 6 characters long.",
                                  style: TextStyles.caption(
                                    context: context,
                                    color: passwordController.validPassword ? theme.positive : theme.negative,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (passwordController.validPassword) ...[
                            SizedBox(height: Dimension.padding.vertical.medium),
                            Row(
                              children: [
                                Icon(
                                  confirmPasswordController.validPassword ? Icons.check_circle_rounded : Icons.circle_outlined,
                                  color: confirmPasswordController.validPassword ? theme.positive : theme.negative,
                                  size: Dimension.radius.twelve,
                                ),
                                SizedBox(width: Dimension.padding.horizontal.medium),
                                Expanded(
                                  child: Text(
                                    "Confirm Password must be at least 6 characters long.",
                                    style: TextStyles.caption(
                                      context: context,
                                      color: confirmPasswordController.validPassword ? theme.positive : theme.negative,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (confirmPasswordController.validPassword) ...[
                            SizedBox(height: Dimension.padding.vertical.medium),
                            Row(
                              children: [
                                Icon(
                                  validPassword ? Icons.check_circle_rounded : Icons.circle_outlined,
                                  color: validPassword ? theme.positive : theme.negative,
                                  size: Dimension.radius.twelve,
                                ),
                                SizedBox(width: Dimension.padding.horizontal.medium),
                                Expanded(
                                  child: Text(
                                    "Password and Confirm Password must be the same.",
                                    style: TextStyles.caption(
                                      context: context,
                                      color: validPassword ? theme.positive : theme.negative,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 16),
                          CheckboxListTile(
                            dense: true,
                            value: acknowledged,
                            contentPadding: EdgeInsets.all(0),
                            controlAffinity: ListTileControlAffinity.leading,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            onChanged: (flag) {
                              setState(() {
                                acknowledged = flag ?? false;
                              });
                            },
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "I have read and agree ",
                                    style: TextStyles.body(context: context, color: theme.textSecondary),
                                  ),
                                  TextSpan(
                                    text: "Terms of Service",
                                    style: TextStyles.body(context: context, color: theme.link),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrlString(ExternalLinks.termsAndConditions);
                                      },
                                  ),
                                  TextSpan(
                                    text: " and ",
                                    style: TextStyles.body(context: context, color: theme.textSecondary),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyles.body(context: context, color: theme.link),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrlString(ExternalLinks.privacyPolicy);
                                      },
                                  ),
                                  TextSpan(
                                    text: ".",
                                    style: TextStyles.body(context: context, color: theme.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: BlocConsumer<RegistrationBloc, RegistrationState>(
                              listener: (context, state) {
                                if (state is RegistrationError) {
                                  context.errorNotification(message: state.failure.message);
                                } else if (state is RegistrationDone) {
                                  context.successNotification(
                                    message: 'Congratulations. You have successfully registered. Have a nice one :)',
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is RegistrationLoading) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                    },
                                    child: NetworkingIndicator(dimension: Dimension.radius.twentyFour, color: theme.white),
                                  );
                                }
                                return ElevatedButton(
                                  onPressed: acknowledged
                                      ? () {
                                          FocusScope.of(context).requestFocus(FocusNode());
                                          if (formKey.currentState?.validate() ?? false) {
                                            context.read<RegistrationBloc>().add(
                                                  CreateAccount(
                                                    username: widget.username,
                                                    password: passwordController.text,
                                                    refference: '',
                                                  ),
                                                );
                                          }
                                        }
                                      : null,
                                  child: Text(
                                    "Sign up".toUpperCase(),
                                    style: TextStyles.button(context: context),
                                  ),
                                );
                              },
                            ),
                          ),
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

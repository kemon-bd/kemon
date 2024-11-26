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
                          ? Container(height: 2)
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create an account',
                                  style: TextStyles.headline(context: context, color: theme.white).copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Please fill all the required fields to create an account.',
                                  style: TextStyles.body(context: context, color: theme.semiWhite).copyWith(
                                    height: 1,
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
                          Text(
                            'Password',
                            style: TextStyles.miniHeadline(context: context, color: theme.textPrimary),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: theme.backgroundSecondary,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: theme.backgroundTertiary,
                                width: .25,
                              ),
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero.copyWith(top: 4, bottom: 4),
                              physics: const NeverScrollableScrollPhysics(),
                              cacheExtent: double.maxFinite,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(right: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Password *',
                                        style: TextStyles.body(context: context, color: theme.textSecondary),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: TextFormField(
                                          controller: passwordController,
                                          keyboardType: TextInputType.text,
                                          textAlign: TextAlign.end,
                                          textAlignVertical: TextAlignVertical.center,
                                          textInputAction: TextInputAction.next,
                                          autofillHints: const [AutofillHints.password, AutofillHints.newPassword],
                                          validator: (value) => passwordController.validPassword ? null : "",
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'required',
                                            isDense: true,
                                            hintStyle: TextStyles.subTitle(
                                              context: context,
                                              color: theme.textSecondary.withAlpha(150),
                                            ),
                                            errorStyle: const TextStyle(fontSize: 0, height: 0),
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
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
                                          style: TextStyles.title(
                                            context: context,
                                            color: passwordController.validPassword ? theme.textPrimary : theme.negative,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (passwordController.validPassword) ...[
                                  Divider(thickness: .15, height: .15, color: theme.backgroundTertiary),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(right: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Confirm password *',
                                          style: TextStyles.body(context: context, color: theme.textSecondary),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: TextFormField(
                                            controller: confirmPasswordController,
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.end,
                                            textAlignVertical: TextAlignVertical.center,
                                            textInputAction: TextInputAction.done,
                                            validator: (value) => confirmPasswordController.validPassword ? null : "",
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'required',
                                              isDense: true,
                                              hintStyle: TextStyles.subTitle(
                                                context: context,
                                                color: theme.textSecondary.withAlpha(150),
                                              ),
                                              errorStyle: const TextStyle(fontSize: 0, height: 0),
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              focusedErrorBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              suffixIcon: IconButton(
                                                padding: EdgeInsets.zero,
                                                highlightColor: Colors.transparent,
                                                splashColor: Colors.transparent,
                                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                                icon: Icon(
                                                  isConfirmPasswordObscured ? Icons.visibility : Icons.visibility_off,
                                                  color: confirmPasswordController.validPassword
                                                      ? theme.textPrimary
                                                      : theme.negative,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    isConfirmPasswordObscured = !isConfirmPasswordObscured;
                                                  });
                                                },
                                              ),
                                            ),
                                            obscureText: isConfirmPasswordObscured,
                                            style: TextStyles.title(
                                              context: context,
                                              color:
                                                  confirmPasswordController.validPassword ? theme.textPrimary : theme.negative,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(height: Dimension.padding.vertical.medium),
                          Row(
                            children: [
                              Icon(
                                passwordController.validPassword ? Icons.check_circle_rounded : Icons.circle_outlined,
                                color: passwordController.validPassword ? theme.positive : theme.negative,
                                size: Dimension.radius.twelve,
                              ),
                              SizedBox(width: Dimension.padding.horizontal.large),
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
                                SizedBox(width: Dimension.padding.horizontal.large),
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
                                SizedBox(width: Dimension.padding.horizontal.large),
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
                          if (validPassword) ...[
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
                                      child: NetworkingIndicator(dimension: 28, color: theme.white),
                                    );
                                  }
                                  return ElevatedButton(
                                    onPressed: () {
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
                                    },
                                    child: Text(
                                      "Sign up".toUpperCase(),
                                      style: TextStyles.button(context: context),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
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

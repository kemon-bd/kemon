import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';

class ResetPasswordWidget extends StatefulWidget {
  final String username;
  const ResetPasswordWidget({
    super.key,
    required this.username,
  });

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  final TextEditingController oldController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool oldObscured = true;
  bool newObscured = true;
  bool confirmObscured = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return KeyboardDismissOnTap(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: EdgeInsets.all(Dimension.radius.sixteen),
              children: [
                Text(
                  'Reset Password',
                  style: TextStyles.subTitle(
                          context: context, color: theme.textPrimary)
                      .copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: Dimension.padding.vertical.small),
                Text(
                  'Enter your new password. It must be at least 6 characters long.',
                  style: TextStyles.body(
                          context: context, color: theme.textSecondary)
                      .copyWith(
                    height: 1,
                  ),
                ),
                SizedBox(height: Dimension.size.vertical.seventyTwo),
                TextFormField(
                  controller: newController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: newObscured,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [
                    AutofillHints.password,
                    AutofillHints.newPassword
                  ],
                  validator: (value) => newController.validPassword ? null : "",
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: TextStyles.body(
                        context: context, color: theme.textPrimary),
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      icon: Icon(
                        newObscured ? Icons.visibility : Icons.visibility_off,
                        color: newController.validPassword
                            ? theme.textPrimary
                            : theme.negative,
                      ),
                      onPressed: () {
                        setState(() {
                          newObscured = !newObscured;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: Dimension.padding.vertical.large),
                TextFormField(
                  controller: confirmController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: confirmObscured,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [
                    AutofillHints.password,
                    AutofillHints.newPassword
                  ],
                  validator: (value) => confirmController.validPassword &&
                          newController.text.same(as: confirmController.text)
                      ? null
                      : "",
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyles.body(
                        context: context, color: theme.textPrimary),
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      icon: Icon(
                        confirmObscured
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: confirmController.validPassword
                            ? theme.textPrimary
                            : theme.negative,
                      ),
                      onPressed: () {
                        setState(() {
                          confirmObscured = !confirmObscured;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: Dimension.size.vertical.seventyTwo),
                SizedBox(
                  width: context.width,
                  child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
                    listener: (context, state) async {
                      if (state is ResetPasswordDone) {
                        context.pop(true);
                        context.successNotification(
                            message: 'Password changed successfully!!!');
                      } else if (state is ResetPasswordError) {
                        context.errorNotification(
                            message: state.failure.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is ResetPasswordLoading) {
                        return ElevatedButton(
                          onPressed: () {},
                          child: NetworkingIndicator(
                              dimension: Dimension.radius.sixteen,
                              color: theme.white),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (formKey.currentState?.validate() ?? false) {
                            context.read<ResetPasswordBloc>().add(
                                  ResetPassword(
                                    username: widget.username,
                                    password: newController.text,
                                  ),
                                );
                          }
                        },
                        child: Text(
                          "Reset".toUpperCase(),
                          style: TextStyles.button(context: context),
                        ),
                      );
                    },
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

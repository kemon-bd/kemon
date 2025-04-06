import '../../../../core/shared/shared.dart';

class ForgotPasswordPickUsernameWidget extends StatefulWidget {
  final Widget Function(String) onUsernameSelected;
  const ForgotPasswordPickUsernameWidget({
    super.key,
    required this.onUsernameSelected,
  });

  @override
  State<ForgotPasswordPickUsernameWidget> createState() => _ForgotPasswordPickUsernameWidgetState();
}

class _ForgotPasswordPickUsernameWidgetState extends State<ForgotPasswordPickUsernameWidget> {
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool picked = false;

  @override
  Widget build(BuildContext context) {
    return picked
        ? widget.onUsernameSelected(usernameController.text)
        : BlocBuilder<ThemeBloc, ThemeState>(
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
                        'Forgot Password',
                        style: context.text.headlineMedium?.copyWith(
                          color: theme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: Dimension.padding.vertical.small),
                      Text(
                        'Enter your username to reset your password.',
                        style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
                          height: 1,
                        ),
                      ),
                      SizedBox(height: Dimension.size.vertical.thirtyTwo),
                      TextFormField(
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.username, AutofillHints.newUsername],
                        validator: (value) => (value ?? '').isNotEmpty ? null : "",
                        style: TextStyles.body(context: context, color: theme.textPrimary),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyles.body(context: context, color: theme.textPrimary),
                        ),
                      ),
                      SizedBox(height: Dimension.size.vertical.twenty),
                      SizedBox(
                        width: context.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (formKey.currentState?.validate() ?? false) {
                              setState(() {
                                picked = true;
                              });
                              widget.onUsernameSelected(usernameController.text);
                            }
                          },
                          child: Text(
                            "Continue".toUpperCase(),
                            style: TextStyles.button(context: context),
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

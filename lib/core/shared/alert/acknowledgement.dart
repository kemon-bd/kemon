import '../shared.dart';

class AcknowledgementAlert extends StatefulWidget {
  const AcknowledgementAlert({super.key});

  @override
  State<AcknowledgementAlert> createState() => _AcknowledgementAlertState();
}

class _AcknowledgementAlertState extends State<AcknowledgementAlert> {
  bool acknowledged = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return AlertDialog(
          backgroundColor: theme.backgroundPrimary,
          title: Text(
            "Disclaimer",
            style: TextStyles.subTitle(context: context, color: theme.textPrimary),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12),
          content: CheckboxListTile(
            dense: true,
            value: acknowledged,
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
          actions: [
            TextButton(
              onPressed: acknowledged ? () => context.pop(true) : null,
              style: TextButton.styleFrom(
                backgroundColor: theme.primary,
                disabledBackgroundColor: theme.backgroundTertiary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(
                "Continue",
                style: TextStyles.button(context: context),
              ),
            ),
          ],
        );
      },
    );
  }
}

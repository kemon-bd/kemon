import '../shared.dart';

class ChooseContactMethodWidget extends StatelessWidget {
  const ChooseContactMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return AlertDialog(
          backgroundColor: theme.backgroundPrimary,
          contentPadding: EdgeInsets.zero,
          title: Text(
            "Choose a method",
            style:
                TextStyles.headline(context: context, color: theme.textPrimary),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Divider(color: theme.backgroundTertiary, height: .25),
              ListTile(
                leading: Icon(Icons.phone_rounded, color: theme.textPrimary),
                title: Text(
                  "Call",
                  style: TextStyles.body(
                      context: context, color: theme.textPrimary),
                ),
                onTap: () {
                  context.pop('tel');
                },
              ),
              Divider(color: theme.backgroundTertiary, height: .25),
              ListTile(
                leading: Icon(Icons.sms_outlined, color: theme.textPrimary),
                title: Text(
                  "Text",
                  style: TextStyles.body(
                      context: context, color: theme.textPrimary),
                ),
                onTap: () {
                  context.pop('sms');
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

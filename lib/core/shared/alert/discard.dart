import '../shared.dart';

class DiscardConfirmationWidget extends StatelessWidget {
  const DiscardConfirmationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return AlertDialog(
          backgroundColor: theme.backgroundPrimary,
          title: Text(
            "Discard Changes?",
            style: TextStyles.subTitle(context: context, color: theme.textPrimary),
          ),
          content: Text(
            "Are you sure you want to discard all the changes you've made? This action cannot be undone.",
            style: TextStyles.body(context: context, color: theme.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: context.pop,
              style: TextButton.styleFrom(
                backgroundColor: theme.backgroundSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(
                  color: theme.backgroundPrimary,
                  width: 1,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(
                "Cancel",
                style: TextStyles.button(context: context).copyWith(color: theme.textPrimary),
              ),
            ),
            const SizedBox(width: 4),
            TextButton(
              onPressed: () => context.pop(true),
              style: TextButton.styleFrom(
                backgroundColor: theme.negative,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(
                "Yes, Discard",
                style: TextStyles.button(context: context),
              ),
            ),
          ],
        );
      },
    );
  }
}

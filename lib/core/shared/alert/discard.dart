import '../shared.dart';

class DiscardConfirmationWidget extends StatelessWidget {
  const DiscardConfirmationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final dark = state.mode == ThemeMode.dark;
        return AlertDialog(
          backgroundColor: dark ? theme.backgroundSecondary : theme.backgroundPrimary,
          title: Text(
            "Discard Changes?",
            style: context.text.headlineSmall?.copyWith(
              color: theme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Are you sure you want to discard all the changes you've made? This action cannot be undone.",
            style: context.text.bodyMedium?.copyWith(
              color: theme.textSecondary.withAlpha(200),
              fontWeight: FontWeight.normal,
              height: 1.15,
            ),
          ),
          actions: [
            TextButton(
              onPressed: context.pop,
              style: TextButton.styleFrom(
                backgroundColor: dark ? theme.backgroundPrimary : theme.backgroundSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: theme.textPrimary,
                    width: .25,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(
                "Cancel".toUpperCase(),
                style: context.text.titleMedium?.copyWith(
                  color: theme.textPrimary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 4),
            ElevatedButton(
              onPressed: () => context.pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.negative,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(
                "Yes, Discard".toUpperCase(),
                style: context.text.titleMedium?.copyWith(
                  color: theme.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

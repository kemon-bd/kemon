import '../../../features/home/home.dart';
import '../shared.dart';

class VerificationConfirmationWidget extends StatelessWidget {
  final String? affirm;
  const VerificationConfirmationWidget({
    super.key,
    this.affirm,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final dark = state.mode == ThemeMode.dark;
        return AlertDialog(
          backgroundColor: theme.positive,
          title: Text(
            "Confirmation",
            style: context.text.headlineSmall?.copyWith(
              color: theme.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Are you sure ?",
            style: context.text.bodyMedium?.copyWith(
              color: theme.white,
              fontWeight: FontWeight.normal,
              height: 1.15,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(HomePage.name);
                }
              },
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
                affirm ?? "Yes, Delete".toUpperCase(),
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

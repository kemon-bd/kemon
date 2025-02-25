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
        return AlertDialog(
          backgroundColor: theme.positive,
          title: Text(
            "Confirmation",
            style: TextStyles.title(context: context, color: theme.backgroundPrimary),
          ),
          content: Text(
            "Are you sure ?",
            style: TextStyles.body(context: context, color: theme.backgroundPrimary),
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
                backgroundColor: theme.positive,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(
                  color: theme.backgroundPrimary,
                  width: 1,
                ),
                padding: EdgeInsets.symmetric(horizontal: Dimension.padding.horizontal.medium),
              ),
              child: Text(
                "Cancel",
                style: TextStyles.button(context: context).copyWith(
                  color: theme.backgroundPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 4),
            TextButton(
              onPressed: () => context.pop(true),
              style: TextButton.styleFrom(
                backgroundColor: theme.backgroundPrimary,
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
                affirm ?? "Yes, Delete",
                style: TextStyles.button(context: context).copyWith(
                  color: theme.positive,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

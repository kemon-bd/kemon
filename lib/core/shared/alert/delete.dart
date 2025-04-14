import '../../../features/home/home.dart';
import '../shared.dart';

class DeleteConfirmationWidget extends StatelessWidget {
  final String? affirm;
  const DeleteConfirmationWidget({
    super.key,
    this.affirm,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return AlertDialog(
          backgroundColor: theme.negative,
          title: Text(
            "Confirmation",
            style: context.text.headlineSmall?.copyWith(
              color: theme.white,
              fontWeight: FontWeight.bold,
              inherit: true,
            ),
          ),
          content: Text(
            "Are you sure ?",
            style: context.text.bodyMedium?.copyWith(
              color: theme.white,
              fontWeight: FontWeight.bold,
              inherit: true,
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
                backgroundColor: theme.negative,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(
                  color: theme.white,
                  width: 1,
                ),
                padding: EdgeInsets.symmetric(horizontal: Dimension.padding.horizontal.medium),
              ),
              child: Text(
                "Cancel",
                style: context.text.titleMedium?.copyWith(
                  color: theme.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 4),
            TextButton(
              onPressed: () => context.pop(true),
              style: TextButton.styleFrom(
                backgroundColor: theme.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(
                  color: theme.white,
                  width: 1,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(
                affirm ?? "Yes, Delete",
                style: context.text.titleMedium?.copyWith(
                  color: theme.negative,
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

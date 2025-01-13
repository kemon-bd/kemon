import '../shared.dart';

class DeleteConfirmationWidget extends StatelessWidget {
  const DeleteConfirmationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return AlertDialog(
          backgroundColor: theme.negative,
          title: Text(
            "Confirmation",
            style: TextStyles.subTitle(context: context, color: Colors.white),
          ),
          content: Text(
            "Are you sure ?",
            style: TextStyles.body(context: context, color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: context.pop,
              style: TextButton.styleFrom(
                backgroundColor: theme.negative,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: const BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              child: Text(
                "Cancel",
                style: TextStyles.subTitle(context: context, color: Colors.white).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 4),
            TextButton(
              onPressed: () => context.pop(true),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(
                "Yes, Delete",
                style: TextStyles.subTitle(context: context, color: theme.negative).copyWith(
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

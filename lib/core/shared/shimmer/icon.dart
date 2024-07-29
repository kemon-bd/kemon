import '../shared.dart';

class ShimmerIcon extends StatelessWidget {
  final double radius;

  const ShimmerIcon({
    super.key,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            color: theme.backgroundTertiary,
            shape: BoxShape.circle,
          ),
        )
            .animate(
              onComplete: (controller) => controller.repeat(),
            )
            .shimmer(
              color: theme.backgroundTertiary,
              colors: [
                theme.backgroundTertiary,
                theme.textPrimary.withAlpha(25),
                theme.backgroundSecondary,
                theme.textSecondary.withAlpha(25),
                theme.backgroundPrimary,
              ],
              stops: [
                .1,
                .3,
                .5,
                .7,
                .9,
              ],
              duration: const Duration(seconds: 1),
            );
      },
    );
  }
}

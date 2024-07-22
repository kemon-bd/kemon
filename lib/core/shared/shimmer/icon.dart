import '../shared.dart';

class ShimmerIcon extends StatelessWidget {
  final double radius;
  final bool delete;

  const ShimmerIcon({
    super.key,
    required this.radius,
    this.delete = false,
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
            color: (delete ? theme.negative : theme.shimmer).withAlpha(100),
            shape: BoxShape.circle,
          ),
        )
            .animate(
              onComplete: (controller) => controller.repeat(),
            )
            .shimmer(
              color: Colors.transparent,
              colors: [
                theme.backgroundSecondary.withAlpha(150),
                theme.primary,
                theme.backgroundTertiary.withAlpha(100),
                theme.shimmer.withAlpha(50),
                theme.backgroundSecondary.withAlpha(50),
                theme.primary,
                theme.backgroundTertiary.withAlpha(150),
                theme.shimmer.withAlpha(50),
              ],
              duration: const Duration(seconds: 1),
            );
      },
    );
  }
}

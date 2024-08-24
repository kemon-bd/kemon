import '../shared.dart';

class ShimmerIcon extends StatelessWidget {
  final double radius;

  const ShimmerIcon({
    super.key,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        theme.backgroundTertiary,
        theme.backgroundPrimary,
        theme.backgroundSecondary,
      ],
    );
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(gradient: gradient, shape: BoxShape.circle),
    )
        .animate(
          onComplete: (controller) => controller.repeat(reverse: true),
        )
        .shimmer(
          color: theme.backgroundTertiary,
          colors: [
            theme.backgroundPrimary,
            theme.backgroundSecondary,
            theme.backgroundTertiary,
          ],
          stops: [.33, .66, .99],
          duration: const Duration(seconds: 1),
        );
  }
}

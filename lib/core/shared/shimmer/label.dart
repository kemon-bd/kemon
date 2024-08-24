import '../shared.dart';

class ShimmerLabel extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets? margin;
  final double radius;

  const ShimmerLabel({
    super.key,
    required this.width,
    required this.height,
    this.margin,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        theme.backgroundTertiary,
        theme.backgroundSecondary,
        theme.backgroundPrimary,
      ],
    );
    return Container(
      margin: margin ?? const EdgeInsets.all(0),
      child: Container(
        width: width,
        height: height,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(radius),
        ),
      )
          .animate(
            onComplete: (controller) => controller.repeat(),
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
          ),
    );
  }
}

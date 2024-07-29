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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Container(
          margin: margin ?? const EdgeInsets.all(0),
          child: PhysicalModel(
            color: theme.backgroundTertiary,
            borderRadius: BorderRadius.circular(radius),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: SizedBox(
              width: width,
              height: height,
            ),
          )
              .animate(
                onComplete: (controller) => controller.repeat(),
              )
              .shimmer(
                color: theme.backgroundTertiary,
                colors: [
                  theme.backgroundSecondary,
                  theme.textPrimary.withAlpha(25),
                  theme.backgroundTertiary,
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
              ),
        );
      },
    );
  }
}

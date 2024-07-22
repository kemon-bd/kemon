import '../shared.dart';

class ShimmerLabel extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets? margin;
  final double radius;
  final bool delete;

  const ShimmerLabel({
    super.key,
    required this.width,
    required this.height,
    this.margin,
    this.radius = 8,
    this.delete = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Container(
          margin: margin ?? EdgeInsets.zero,
          child: PhysicalModel(
            color: (delete ? theme.negative : theme.shimmer).withAlpha(100),
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
              ),
        );
      },
    );
  }
}

import '../../../../../core/shared/shared.dart';

class BusinessItemShimmerWidget extends StatelessWidget {
  const BusinessItemShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: Dimension.padding.horizontal.max),
          padding: EdgeInsets.symmetric(
            horizontal: Dimension.padding.horizontal.large,
            vertical: Dimension.padding.vertical.large,
          ),
          decoration: BoxDecoration(
            color: theme.backgroundSecondary,
            borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
          ),
          clipBehavior: Clip.none,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShimmerLabel(
                    width: Dimension.radius.fortyEight,
                    height: Dimension.radius.fortyEight,
                    radius: Dimension.radius.eight,
                  ),
                  SizedBox(width: Dimension.padding.horizontal.large),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerLabel(
                          width: Dimension.size.horizontal.oneTwentyEight,
                          height: Dimension.size.vertical.twelve,
                          radius: Dimension.radius.eight,
                        ),
                        SizedBox(height: Dimension.padding.vertical.small),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ShimmerIcon(radius: Dimension.radius.twelve),
                            SizedBox(width: Dimension.padding.horizontal.verySmall),
                            ShimmerLabel(
                              width: Dimension.size.horizontal.sixteen,
                              height: Dimension.size.vertical.ten,
                              radius: Dimension.radius.eight,
                            ),
                            SizedBox(width: Dimension.padding.horizontal.medium),
                            Icon(
                              Icons.circle,
                              size: Dimension.padding.horizontal.small,
                              color: theme.backgroundTertiary,
                            ),
                            SizedBox(width: Dimension.padding.horizontal.medium),
                            ShimmerLabel(
                              width: Dimension.size.horizontal.fortyEight,
                              height: Dimension.size.vertical.ten,
                              radius: Dimension.radius.eight,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

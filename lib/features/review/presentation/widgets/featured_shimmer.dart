import '../../../../core/shared/shared.dart' ;

class FeaturedReviewsShimmerWidget extends StatelessWidget {
  const FeaturedReviewsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return ListView(
          padding: const EdgeInsets.all(16.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          children: [
            const SizedBox(height: 4),
            const Align(
              alignment: Alignment.centerLeft,
              child: ShimmerLabel(width: 128, height: 16),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: Dimension.size.vertical.carousel,
              child: CarouselView(
                itemExtent: context.width * .75,
                shrinkExtent: context.width * .75,
                itemSnapping: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimension.radius.twelve),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: Dimension.padding.horizontal.small),
                children: [0, 1, 2]
                    .map(
                      (review) => Container(
                        decoration: BoxDecoration(
                          color: theme.backgroundPrimary,
                          border: Border.all(
                            color: theme.backgroundTertiary,
                            width: Dimension.divider.large,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                          borderRadius:
                              BorderRadius.circular(Dimension.radius.twelve),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimension.padding.horizontal.large,
                            vertical: Dimension.padding.vertical.large,
                          ),
                          clipBehavior: Clip.antiAlias,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ShimmerIcon(radius: Dimension.radius.thirtyTwo),
                                SizedBox(
                                    width: Dimension.padding.horizontal.medium),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ShimmerLabel(
                                        width:
                                            Dimension.size.horizontal.sixtyFour,
                                        height: Dimension.size.vertical.twelve,
                                        radius: Dimension.radius.eight,
                                      ),
                                      SizedBox(
                                          height: Dimension
                                              .padding.vertical.verySmall),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ShimmerLabel(
                                            width: Dimension
                                                .size.horizontal.fortyEight,
                                            height:
                                                Dimension.size.vertical.twelve,
                                            radius: Dimension.radius.eight,
                                          ),
                                          SizedBox(
                                              width: Dimension
                                                  .padding.horizontal.medium),
                                          Icon(Icons.circle,
                                              size: Dimension.radius.three,
                                              color: theme.backgroundTertiary),
                                          SizedBox(
                                              width: Dimension
                                                  .padding.horizontal.medium),
                                          Expanded(
                                            child: ShimmerLabel(
                                              width: Dimension
                                                  .size.horizontal.thirtyTwo,
                                              height: Dimension
                                                  .size.vertical.twelve,
                                              radius: Dimension.radius.eight,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(height: Dimension.size.vertical.twenty),
                            ShimmerLabel(
                              width: Dimension.size.horizontal.oneTwentyEight,
                              height: Dimension.size.vertical.twelve,
                              radius: Dimension.radius.eight,
                            ),
                            SizedBox(height: Dimension.padding.vertical.small),
                            ShimmerLabel(
                              width: Dimension.size.horizontal.seventyTwo,
                              height: Dimension.size.vertical.twelve,
                              radius: Dimension.radius.eight,
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

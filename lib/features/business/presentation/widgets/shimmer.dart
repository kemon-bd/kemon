import '../../../../core/shared/shared.dart';

class BusinessShimmerWidget extends StatelessWidget {
  const BusinessShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        SliverAppBar(
          pinned: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: theme.backgroundSecondary,
          surfaceTintColor: theme.backgroundSecondary,
          leading: IconButton(
            icon: ShimmerIcon(radius: Dimension.radius.thirtyTwo),
            onPressed: () {},
          ),
          centerTitle: false,
          actions: [
            ShimmerIcon(radius: Dimension.radius.twentyFour),
            SizedBox(width: Dimension.padding.horizontal.ultraMax),
            ShimmerIcon(radius: Dimension.radius.twentyFour),
            SizedBox(width: Dimension.padding.horizontal.large),
          ],
        ),
        SliverPadding(
          padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(top: 6),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ShimmerLabel(
                    width: context.width * .5,
                    height: Dimension.size.vertical.twentyFour,
                    radius: Dimension.radius.sixteen,
                  ),
                ),
                SizedBox(height: Dimension.padding.vertical.large),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLabel(width: 64, height: 64, radius: 16),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLabel(
                            width: 84,
                            height: Dimension.size.vertical.sixteen,
                            radius: Dimension.radius.sixteen,
                          ),
                          const SizedBox(height: 10),
                          ShimmerLabel(
                            width: 144,
                            height: Dimension.size.vertical.eight,
                            radius: Dimension.radius.sixteen,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            spacing: 8,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ShimmerLabel(
                                width: Dimension.size.horizontal.thirtyTwo,
                                height: Dimension.size.vertical.twentyFour,
                                radius: Dimension.radius.sixteen,
                              ),
                              ShimmerLabel(
                                width: Dimension.size.horizontal.thirtyTwo,
                                height: Dimension.size.vertical.twentyFour,
                                radius: Dimension.radius.sixteen,
                              ),
                              ShimmerLabel(
                                width: Dimension.size.horizontal.thirtyTwo,
                                height: Dimension.size.vertical.twentyFour,
                                radius: Dimension.radius.sixteen,
                              ),
                              ShimmerLabel(
                                width: Dimension.size.horizontal.thirtyTwo,
                                height: Dimension.size.vertical.twentyFour,
                                radius: Dimension.radius.sixteen,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.center,
                  child: ShimmerLabel(
                    width: context.width * .66,
                    height: Dimension.size.vertical.fortyEight,
                    radius: Dimension.radius.sixteen,
                  ),
                ),
                const SizedBox(height: 36),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShimmerLabel(
                      width: 78,
                      height: Dimension.size.vertical.twenty,
                      radius: Dimension.radius.sixteen,
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.star, color: theme.backgroundSecondary, size: 24),
                    const SizedBox(width: 12),
                    ShimmerLabel(
                      width: 32,
                      height: Dimension.size.vertical.twenty,
                      radius: Dimension.radius.sixteen,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ShimmerLabel(
                    width: 128,
                    height: Dimension.size.vertical.twelve,
                    radius: Dimension.radius.sixteen,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShimmerIcon(radius: Dimension.radius.eighteen),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      SizedBox(
                        width: 84,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ShimmerLabel(
                            width: 78,
                            height: Dimension.size.vertical.sixteen,
                            radius: Dimension.radius.sixteen,
                          ),
                        ),
                      ),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: .8,
                          minHeight: 4,
                          borderRadius: BorderRadius.circular(100),
                          valueColor: AlwaysStoppedAnimation<Color>(theme.backgroundTertiary),
                          backgroundColor: theme.backgroundSecondary,
                        ),
                      ),
                      SizedBox(
                        width: Dimension.size.horizontal.thirtySix,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ShimmerLabel(
                            width: 24,
                            height: Dimension.size.vertical.twelve,
                            radius: Dimension.radius.sixteen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0).copyWith(top: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShimmerIcon(radius: Dimension.radius.eighteen),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      SizedBox(
                        width: 84,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ShimmerLabel(
                            width: 64,
                            height: Dimension.size.vertical.sixteen,
                            radius: Dimension.radius.sixteen,
                          ),
                        ),
                      ),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: .1,
                          minHeight: 4,
                          borderRadius: BorderRadius.circular(100),
                          valueColor: AlwaysStoppedAnimation<Color>(theme.backgroundTertiary),
                          backgroundColor: theme.backgroundSecondary,
                        ),
                      ),
                      SizedBox(
                        width: Dimension.size.horizontal.thirtySix,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ShimmerLabel(
                            width: 16,
                            height: Dimension.size.vertical.twelve,
                            radius: Dimension.radius.sixteen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0).copyWith(top: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShimmerIcon(radius: Dimension.radius.eighteen),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      SizedBox(
                        width: 84,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ShimmerLabel(
                            width: 48,
                            height: Dimension.size.vertical.sixteen,
                            radius: Dimension.radius.sixteen,
                          ),
                        ),
                      ),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0,
                          minHeight: 4,
                          borderRadius: BorderRadius.circular(100),
                          valueColor: AlwaysStoppedAnimation<Color>(theme.backgroundTertiary),
                          backgroundColor: theme.backgroundSecondary,
                        ),
                      ),
                      SizedBox(
                        width: Dimension.size.horizontal.thirtySix,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ShimmerLabel(
                            width: 16,
                            height: Dimension.size.vertical.twelve,
                            radius: Dimension.radius.sixteen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0).copyWith(top: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShimmerIcon(radius: Dimension.radius.eighteen),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      SizedBox(
                        width: 84,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ShimmerLabel(
                            width: 32,
                            height: Dimension.size.vertical.sixteen,
                            radius: Dimension.radius.sixteen,
                          ),
                        ),
                      ),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0,
                          minHeight: 4,
                          borderRadius: BorderRadius.circular(100),
                          valueColor: AlwaysStoppedAnimation<Color>(theme.backgroundTertiary),
                          backgroundColor: theme.backgroundSecondary,
                        ),
                      ),
                      SizedBox(
                        width: Dimension.size.horizontal.thirtySix,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ShimmerLabel(
                            width: 16,
                            height: Dimension.size.vertical.twelve,
                            radius: Dimension.radius.sixteen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0).copyWith(top: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShimmerIcon(radius: Dimension.radius.eighteen),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      SizedBox(
                        width: 84,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ShimmerLabel(
                            width: 16,
                            height: Dimension.size.vertical.sixteen,
                            radius: Dimension.radius.sixteen,
                          ),
                        ),
                      ),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: .1,
                          minHeight: 4,
                          borderRadius: BorderRadius.circular(100),
                          valueColor: AlwaysStoppedAnimation<Color>(theme.backgroundTertiary),
                          backgroundColor: theme.backgroundSecondary,
                        ),
                      ),
                      SizedBox(
                        width: Dimension.size.horizontal.thirtySix,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ShimmerLabel(
                            width: 24,
                            height: Dimension.size.vertical.twelve,
                            radius: Dimension.radius.sixteen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // BusinessReviewsWidget(reviews: state.reviews),
      ],
    );
  }
}

import '../../../../core/shared/shared.dart';

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
            CarouselSlider.builder(
              itemCount: 3,
              itemBuilder: (_, index, __) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: PhysicalModel(
                    color: theme.backgroundSecondary,
                    elevation: 4,
                    shadowColor: theme.textSecondary,
                    borderRadius: BorderRadius.circular(12.0),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        Row(
                          children: [
                            const ShimmerIcon(radius: 32),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const ShimmerLabel(width: 128, height: 12.0),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const ShimmerLabel(width: 78, height: 10.0),
                                    const SizedBox(width: 8),
                                    Icon(Icons.circle, size: 4, color: theme.backgroundTertiary),
                                    const SizedBox(width: 8),
                                    const ShimmerLabel(width: 64, height: 8.0),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 24, thickness: .15),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: ShimmerLabel(width: 240, height: 12.0),
                        ),
                        const SizedBox(height: 12),
                        const ShimmerLabel(width: 112, height: 8.0),
                        const SizedBox(height: 6),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: ShimmerLabel(width: 240, height: 8.0),
                        ),
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                aspectRatio: 2.75,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                enlargeFactor: .33,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayInterval: const Duration(seconds: 5),
                viewportFraction: .9,
                clipBehavior: Clip.none,
                padEnds: true,
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

import '../../../../core/shared/shared.dart';
import '../../review.dart';

class FeaturedReviewsWidget extends StatelessWidget {
  const FeaturedReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<RecentReviewsBloc, RecentReviewsState>(
          builder: (_, state) {
            if (state is RecentReviewsLoading) {
              return const FeaturedReviewsShimmerWidget();
            } else if (state is RecentReviewsDone) {
              final reviews = state.reviews;
              return ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimension.padding.horizontal.max,
                  vertical: Dimension.padding.vertical.max,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                children: [
                  Text(
                    "Recent reviews",
                    style: TextStyles.title(context: context, color: theme.textPrimary),
                  ),
                  SizedBox(height: Dimension.padding.vertical.small),
                  if (reviews.isNotEmpty)
                    CarouselSlider.builder(
                      itemCount: reviews.length,
                      itemBuilder: (_, index, __) {
                        final review = reviews[index];
                        return FeaturedReviewItemWidget(review: review);
                      },
                      options: CarouselOptions(
                        aspectRatio: 2.6,
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
                  if (reviews.isEmpty) const Text('No reviews yet'),
                ],
              );
            } else if (state is RecentReviewsError) {
              return Center(
                child: Text(state.failure.message),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }
}

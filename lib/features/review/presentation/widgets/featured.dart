import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
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
                    style: TextStyles.title(
                        context: context, color: theme.textPrimary),
                  ),
                  SizedBox(height: Dimension.padding.vertical.small),
                  if (reviews.isNotEmpty)
                    SizedBox(
                      height: Dimension.size.vertical.carousel,
                      child: CarouselView(
                        itemExtent: context.width * .75,
                        shrinkExtent: context.width * .5,
                        itemSnapping: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimension.radius.twelve),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimension.padding.horizontal.small),
                        onTap: (index) {
                          final review = reviews.elementAt(index);
                          context.pushNamed(
                            PublicProfilePage.name,
                            pathParameters: {'user': review.user.guid},
                          );
                        },
                        children: reviews
                            .map(
                              (review) =>
                                  FeaturedReviewItemWidget(review: review),
                            )
                            .toList(),
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

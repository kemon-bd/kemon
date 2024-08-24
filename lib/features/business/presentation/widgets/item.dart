import '../../../../../core/config/config.dart';
import '../../../../../core/shared/shared.dart';
import '../../../review/review.dart';
import '../../business.dart';

class BusinessItemWidget extends StatelessWidget {
  final String urlSlug;
  const BusinessItemWidget({
    super.key,
    required this.urlSlug,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocProvider(
          create: (_) => sl<FindBusinessBloc>()..add(FindBusiness(urlSlug: urlSlug)),
          child: BlocBuilder<FindBusinessBloc, FindBusinessState>(
            builder: (_, state) {
              if (state is FindBusinessDone) {
                final business = state.business;
                expandWidget(expanded) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (business.contact.website?.isNotEmpty ?? false) ...[
                              Icon(Icons.public_rounded, color: theme.primary, size: 16),
                              const SizedBox(width: 8),
                            ],
                            if (business.contact.email?.isNotEmpty ?? false) ...[
                              Icon(Icons.email_outlined, color: theme.primary, size: 16),
                              const SizedBox(width: 8),
                            ],
                            if (business.contact.phone?.isNotEmpty ?? false)
                              Icon(Icons.phone_rounded, color: theme.primary, size: 16),
                          ],
                        ),
                        ExpandableButton(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Latest reviews",
                                style: TextStyles.subTitle(context: context, color: theme.primary),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                                color: theme.primary,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    context.pushNamed(
                      BusinessPage.name,
                      pathParameters: {
                        "urlSlug": business.urlSlug,
                      },
                    );
                  },
                  child: Container(
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
                            BusinessLogoWidget(
                              size: Dimension.radius.fortyTwo,
                              backgroundColor: theme.backgroundPrimary,
                              radius: Dimension.radius.eight,
                            ),
                            SizedBox(width: Dimension.padding.horizontal.large),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    business.name.full,
                                    style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                                  ),
                                  SizedBox(height: Dimension.padding.vertical.small),
                                  BlocProvider(
                                    create: (context) => sl<FindRatingBloc>()..add(FindRating(urlSlug: urlSlug)),
                                    child: BlocBuilder<FindRatingBloc, FindRatingState>(
                                      builder: (context, state) {
                                        if (state is FindRatingDone) {
                                          final rating = state.rating;
                                          return Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              if (rating.average > 0) ...[
                                                Icon(
                                                  Icons.star_rounded,
                                                  color: theme.primary,
                                                  size: Dimension.size.vertical.twelve,
                                                ),
                                                SizedBox(width: Dimension.padding.horizontal.verySmall),
                                                Text(
                                                  rating.average.toStringAsFixed(1),
                                                  style: TextStyles.caption(context: context, color: theme.primary),
                                                ),
                                                SizedBox(width: Dimension.padding.horizontal.medium),
                                                Icon(
                                                  Icons.circle,
                                                  size: Dimension.padding.horizontal.small,
                                                  color: theme.backgroundTertiary,
                                                ),
                                                SizedBox(width: Dimension.padding.horizontal.medium),
                                              ],
                                              Text(
                                                rating.total > 0
                                                    ? "${rating.total} review${rating.total > 1 ? 's' : ''}"
                                                    : 'No review yet',
                                                style: TextStyles.caption(
                                                  context: context,
                                                  color: rating.total > 0 ? theme.primary : theme.textSecondary.withAlpha(100),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        return Container();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        BlocProvider(
                          create: (context) => sl<FindListingReviewsBloc>()..add(FindListingReviews(urlSlug: urlSlug)),
                          child: BlocBuilder<FindListingReviewsBloc, FindListingReviewsState>(
                            builder: (context, state) {
                              if (state is FindListingReviewsDone) {
                                final reviews = state.reviews;
                                if (reviews.isNotEmpty) {
                                  return ExpandableNotifier(
                                    child: Expandable(
                                      collapsed: expandWidget(false),
                                      expanded: ListView(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        clipBehavior: Clip.none,
                                        children: [
                                          expandWidget(true),
                                          SizedBox(height: Dimension.padding.vertical.medium),
                                          SizedBox(
                                            height: Dimension.size.vertical.carousel,
                                            child: CarouselView(
                                              itemExtent: context.width * .75,
                                              itemSnapping: true,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(Dimension.radius.twelve),
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: Dimension.padding.horizontal.small),
                                              children: reviews
                                                  .map(
                                                    (review) => FeaturedReviewItemWidget(review: review),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is FindBusinessLoading) {
                return const BusinessItemShimmerWidget();
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}

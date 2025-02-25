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
          create: (context) => sl<FindBusinessBloc>()..add(FindBusiness(urlSlug: urlSlug)),
          child: BlocBuilder<FindBusinessBloc, FindBusinessState>(
            builder: (_, state) {
              if (state is FindBusinessDone) {
                final business = state.business;
                expandWidget(expanded, total) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        if (total > 0)
                          ExpandableButton(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Latest reviews",
                                  style: TextStyles.body(context: context, color: theme.primary),
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
                  onTap: () async {
                    await sl<FirebaseAnalytics>().logEvent(
                      name: 'location_listing_item',
                      parameters: {
                        'id': context.auth.profile?.identity.id ?? 'anonymous',
                        'name': context.auth.profile?.name.full ?? 'Guest',
                        'urlSlug': business.urlSlug,
                      },
                    );
                    if (!context.mounted) return;
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
                              size: Dimension.radius.fortyEight,
                              backgroundColor: theme.backgroundPrimary,
                              radius: Dimension.radius.eight,
                              placeholderColor: theme.textSecondary,
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
                                  if (business.address.formatted.isNotEmpty) ...[
                                    SizedBox(height: Dimension.padding.vertical.verySmall),
                                    Text(
                                      business.address.formatted,
                                      style: TextStyles.caption(context: context, color: theme.textSecondary),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                  SizedBox(height: Dimension.padding.vertical.verySmall),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (business.contact.phone?.isNotEmpty ?? false) ...[
                                        Icon(
                                          Icons.phone_outlined,
                                          color: theme.textSecondary.withAlpha(200),
                                          size: Dimension.radius.eight,
                                        ),
                                        SizedBox(width: Dimension.padding.horizontal.small),
                                      ],
                                      if (business.contact.email?.isNotEmpty ?? false) ...[
                                        Icon(
                                          Icons.email_outlined,
                                          color: theme.textSecondary.withAlpha(200),
                                          size: Dimension.radius.eight,
                                        ),
                                        SizedBox(width: Dimension.padding.horizontal.small),
                                      ],
                                      if (business.address.formatted.isNotEmpty) ...[
                                        Icon(
                                          Icons.place_outlined,
                                          color: theme.textSecondary.withAlpha(200),
                                          size: Dimension.radius.eight,
                                        ),
                                        SizedBox(width: Dimension.padding.horizontal.small),
                                      ],
                                      if (business.contact.website?.isNotEmpty ?? false) ...[
                                        Icon(
                                          Icons.language_outlined,
                                          color: theme.textSecondary.withAlpha(200),
                                          size: Dimension.radius.eight,
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(height: Dimension.padding.vertical.verySmall),
                                  BlocProvider(
                                    create: (context) => sl<FindRatingBloc>()..add(FindRating(urlSlug: business.urlSlug)),
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
                                                  style: TextStyles.body(context: context, color: theme.primary),
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
                                                style: TextStyles.body(
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
                          create: (context) =>
                              sl<FindListingReviewsBloc>()..add(FindListingReviews(urlSlug: business.urlSlug, filter: [])),
                          child: BlocBuilder<FindListingReviewsBloc, FindListingReviewsState>(
                            builder: (context, state) {
                              if (state is FindListingReviewsDone) {
                                final reviews = state.reviews;
                                return ExpandableNotifier(
                                  child: Expandable(
                                    collapsed: Padding(
                                      padding: const EdgeInsets.all(0).copyWith(
                                        top: reviews.isEmpty ? 0 : Dimension.padding.vertical.medium,
                                      ),
                                      child: expandWidget(false, reviews.length),
                                    ),
                                    expanded: ListView(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero.copyWith(
                                        top: ((business.contact.phone ?? '').isEmpty &&
                                                (business.contact.email ?? '').isEmpty &&
                                                business.address.formatted.isEmpty &&
                                                (business.contact.website ?? '').isEmpty &&
                                                reviews.isEmpty)
                                            ? 0
                                            : Dimension.padding.vertical.medium,
                                      ),
                                      clipBehavior: Clip.none,
                                      children: [
                                        expandWidget(true, reviews.length),
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
              return const BusinessItemShimmerWidget();
            },
          ),
        );
      },
    );
  }
}

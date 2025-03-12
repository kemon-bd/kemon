import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class FeaturedReviewItemWidget extends StatelessWidget {
  final String urlSlug;
  final RecentReviewEntity review;
  const FeaturedReviewItemWidget({
    super.key,
    required this.urlSlug,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final fallback = Center(
          child: Text(
            review.reviewer.name.symbol,
            style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
              fontSize: Dimension.radius.twelve,
            ),
          ),
        );
        return InkWell(
          onTap: () async {
            await sl<FirebaseAnalytics>().logEvent(
              name: 'home_recent_review_listing_profile',
              parameters: {
                'id': context.auth.profile?.identity.id ?? 'anonymous',
                'name': context.auth.profile?.name.full ?? 'Guest',
                'user': review.reviewer.identity.guid,
              },
            );
            if (!context.mounted) return;
            context.pushNamed(
              BusinessPage.name,
              pathParameters: {'urlSlug': urlSlug},
              queryParameters: {'review': review.identity.guid},
            );
          },
          child: Container(
            width: context.width * 0.66,
            height: Dimension.size.vertical.carousel,
            decoration: BoxDecoration(
              color: theme.backgroundPrimary,
              border: Border.all(
                color: theme.backgroundTertiary,
                width: Dimension.divider.large,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              borderRadius: BorderRadius.circular(Dimension.radius.twelve),
            ),
            clipBehavior: Clip.antiAlias,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: Dimension.padding.horizontal.large,
                vertical: Dimension.padding.vertical.large,
              ).copyWith(top: Dimension.padding.vertical.medium),
              clipBehavior: Clip.antiAlias,
              children: [
                InkWell(
                  onTap: () async {
                    await sl<FirebaseAnalytics>().logEvent(
                      name: 'home_recent_review_user_profile',
                      parameters: {
                        'id': context.auth.profile?.identity.id ?? 'anonymous',
                        'name': context.auth.profile?.name.full ?? 'Guest',
                        'user': review.reviewer.identity.guid,
                      },
                    );
                    if (!context.mounted) return;
                    context.pushNamed(
                      PublicProfilePage.name,
                      pathParameters: {'user': review.reviewer.identity.guid},
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: theme.backgroundSecondary,
                          borderRadius: BorderRadius.circular(Dimension.radius.twentyFour),
                          border: Border.all(
                            color: theme.textSecondary,
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: review.reviewer.profilePicture.isEmpty
                            ? fallback
                            : CachedNetworkImage(
                                imageUrl: review.reviewer.profilePicture.url,
                                width: Dimension.radius.twentyFour,
                                height: Dimension.radius.twentyFour,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => ShimmerIcon(radius: Dimension.radius.twentyFour),
                                errorWidget: (_, __, ___) => fallback,
                              ),
                      ),
                      SizedBox(width: Dimension.padding.horizontal.medium),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.reviewer.name.full,
                              style: TextStyles.body(context: context, color: theme.primary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RatingBarIndicator(
                                  rating: review.star.toDouble(),
                                  itemBuilder: (context, index) => Icon(Icons.stars_rounded, color: theme.primary),
                                  unratedColor: theme.textSecondary.withAlpha(50),
                                  itemCount: 5,
                                  itemSize: Dimension.radius.twelve,
                                  direction: Axis.horizontal,
                                ),
                                SizedBox(width: Dimension.padding.horizontal.medium),
                                Icon(Icons.circle, size: Dimension.radius.three, color: theme.backgroundTertiary),
                                SizedBox(width: Dimension.padding.horizontal.medium),
                                Expanded(
                                  child: StreamBuilder(
                                    stream: Stream.periodic(const Duration(seconds: 1)),
                                    builder: (context, snapshot) {
                                      return Text(
                                        review.reviewedAt.duration,
                                        style: TextStyles.caption(context: context, color: theme.textSecondary.withAlpha(150)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (review.summary.isNotEmpty) ...[
                  SizedBox(height: Dimension.padding.vertical.small),
                  Text(
                    review.summary,
                    style: TextStyles.body(context: context, color: theme.textPrimary),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
                if (review.content.isNotEmpty) ...[
                  SizedBox(height: Dimension.padding.vertical.small),
                  Text(
                    review.content,
                    style:
                        TextStyles.caption(context: context, color: theme.textSecondary.withAlpha(150)).copyWith(height: 1.1),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

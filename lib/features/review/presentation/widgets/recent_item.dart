import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class RecentReviewItemWidget extends StatelessWidget {
  final RecentReviewEntity review;
  const RecentReviewItemWidget({
    super.key,
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
              pathParameters: {'urlSlug': review.listing.urlSlug},
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
            padding: EdgeInsets.symmetric(
              horizontal: Dimension.padding.horizontal.large,
              vertical: Dimension.padding.vertical.medium,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: Dimension.padding.vertical.small,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            width: .15,
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: review.reviewer.name.full,
                                    style: TextStyles.body(context: context, color: theme.primary),
                                  ),
                                  if (review.localGuide) ...[
                                    WidgetSpan(child: SizedBox(width: 4)),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.aboveBaseline,
                                      baseline: TextBaseline.alphabetic,
                                      child: SvgPicture.asset(
                                        'images/logo/google.svg',
                                        width: Dimension.radius.eight,
                                        height: Dimension.radius.eight,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: Dimension.padding.horizontal.medium,
                              children: [
                                RatingBarIndicator(
                                  rating: review.star.toDouble(),
                                  itemBuilder: (context, index) => Icon(Icons.stars_rounded, color: theme.primary),
                                  unratedColor: theme.textSecondary.withAlpha(50),
                                  itemCount: 5,
                                  itemSize: Dimension.radius.twelve,
                                  direction: Axis.horizontal,
                                ),
                                Icon(Icons.circle, size: Dimension.radius.three, color: theme.backgroundTertiary),
                                StreamBuilder(
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
                                if (review.photos > 0) ...[
                                  Icon(Icons.circle, size: Dimension.radius.three, color: theme.backgroundTertiary),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        WidgetSpan(
                                          alignment: PlaceholderAlignment.middle,
                                          baseline: TextBaseline.alphabetic,
                                          child: Icon(
                                            review.photos > 1 ? Icons.photo_library_rounded : Icons.photo_rounded,
                                            size: Dimension.radius.twelve,
                                            color: theme.textSecondary.withAlpha(150),
                                          ),
                                        ),
                                        TextSpan(
                                          text: " ",
                                          style:
                                              TextStyles.caption(context: context, color: theme.textSecondary.withAlpha(150)),
                                        ),
                                        TextSpan(
                                          text: review.photos.toString(),
                                          style:
                                              TextStyles.caption(context: context, color: theme.textSecondary.withAlpha(150)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: Dimension.size.vertical.four),
                InkWell(
                  onTap: () async {
                    await sl<FirebaseAnalytics>().logEvent(
                      name: 'home_recent_review_listing',
                      parameters: {
                        'id': context.auth.profile?.identity.id ?? 'anonymous',
                        'name': context.auth.profile?.name.full ?? 'Guest',
                        'user': review.reviewer.identity.guid,
                        'listing': review.listing.urlSlug,
                      },
                    );
                    if (!context.mounted) return;
                    context.pushNamed(
                      BusinessPage.name,
                      pathParameters: {'urlSlug': review.listing.urlSlug},
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: review.listing.name.full,
                          style: TextStyles.body(context: context, color: theme.primary),
                        ),
                        if (review.listing.verified) ...[
                          WidgetSpan(child: SizedBox(width: 4)),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.aboveBaseline,
                            baseline: TextBaseline.alphabetic,
                            child: Icon(
                              Icons.verified_rounded,
                              color: theme.primary,
                              size: Dimension.radius.twelve,
                            ),
                          ),
                        ],
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (review.summary.isNotEmpty) ...[
                  Text(
                    review.summary,
                    style: TextStyles.body(context: context, color: theme.textPrimary),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
                if (review.content.isNotEmpty) ...[
                  Expanded(
                    child: Text(
                      review.content,
                      style:
                          TextStyles.caption(context: context, color: theme.textSecondary.withAlpha(150)).copyWith(height: 1.1),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
                if (review.likes > -1 || review.dislikes > -1) ...[
                  Divider(height: Dimension.padding.vertical.small),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: Dimension.padding.horizontal.small,
                    children: [
                      Icon(
                        Icons.thumb_up_alt_outlined,
                        size: Dimension.radius.twelve,
                        color: review.liked ? theme.primary : theme.textSecondary.withAlpha(150),
                      ),
                      Text(
                        review.likes.toString(),
                        style: TextStyles.caption(
                          context: context,
                          color: review.liked ? theme.primary : theme.textSecondary.withAlpha(150),
                        ).copyWith(height: 1.1),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      Icon(Icons.circle, size: Dimension.radius.three, color: theme.backgroundTertiary),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      Icon(
                        Icons.thumb_down_alt_outlined,
                        size: Dimension.radius.twelve,
                        color: review.disliked ? theme.negative : theme.textSecondary.withAlpha(150),
                      ),
                      Text(
                        review.dislikes.toString(),
                        style: TextStyles.caption(
                          context: context,
                          color: review.disliked ? theme.negative : theme.textSecondary.withAlpha(150),
                        ).copyWith(height: 1.1),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
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

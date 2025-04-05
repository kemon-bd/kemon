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
        final mode = state.mode;
        final fallback = Center(
          child: Text(
            review.reviewer.name.symbol,
            style: context.text.bodyMedium?.copyWith(color: theme.textSecondary),
          ),
        );
        return InkWell(
          borderRadius: BorderRadius.circular(Dimension.radius.twelve),
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
            width: context.width * 0.75,
            height: Dimension.size.vertical.carousel,
            decoration: BoxDecoration(
              color: mode == ThemeMode.dark ? theme.backgroundSecondary : theme.backgroundPrimary,
              border: Border.all(
                color: mode == ThemeMode.dark ? theme.backgroundPrimary : theme.textPrimary,
                width: mode == ThemeMode.dark ? 0 : .25,
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
                                    style: context.text.bodyMedium?.copyWith(
                                      color: theme.primary,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                    ),
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
                            SizedBox(height: Dimension.padding.vertical.verySmall),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: Dimension.padding.horizontal.medium,
                              children: [
                                RatingBarIndicator(
                                  rating: review.star.toDouble(),
                                  itemBuilder: (context, index) => Icon(Icons.star_sharp, color: review.star.color(scheme: theme)),
                                  unratedColor: theme.textSecondary.withAlpha(25),
                                  itemCount: review.star,
                                  itemSize: Dimension.radius.twelve,
                                  direction: Axis.horizontal,
                                ),
                                Icon(Icons.circle, size: Dimension.radius.three, color: theme.backgroundTertiary),
                                StreamBuilder(
                                  stream: Stream.periodic(const Duration(seconds: 1)),
                                  builder: (context, snapshot) {
                                    return Text(
                                      review.reviewedAt.duration,
                                      style: context.text.labelSmall?.copyWith(
                                        color: theme.textSecondary.withAlpha(150),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
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
                                          style: context.text.labelSmall?.copyWith(
                                            color: theme.textSecondary.withAlpha(150),
                                            fontWeight: FontWeight.normal,
                                            height: 1,
                                          ),
                                        ),
                                        TextSpan(
                                          text: review.photos.toString(),
                                          style: context.text.labelSmall?.copyWith(
                                            color: theme.textSecondary.withAlpha(150),
                                            fontWeight: FontWeight.normal,
                                            height: 1,
                                          ),
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
                          style: context.text.bodyMedium?.copyWith(
                            color: theme.primary,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
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
                  SizedBox(height: Dimension.padding.vertical.verySmall),
                  Text(
                    review.summary,
                    style: context.text.bodyMedium?.copyWith(
                      color: theme.textPrimary,
                      height: 1,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
                if (review.content.isNotEmpty) ...[
                  SizedBox(height: Dimension.padding.vertical.verySmall),
                  Expanded(
                    child: Text(
                      review.content,
                      style: context.text.bodySmall?.copyWith(
                        color: theme.textSecondary,
                        height: 1,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: review.summary.isNotEmpty ? 1 : 2,
                    ),
                  ),
                ],
                if (review.likes > -1 || review.dislikes > -1) ...[
                  Divider(height: Dimension.padding.vertical.small),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: Dimension.padding.horizontal.small,
                    children: [
                      Icon(
                        review.liked ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                        size: context.text.labelSmall?.fontSize,
                        color: review.liked ? theme.positive : theme.textSecondary.withAlpha(150),
                      ),
                      Text(
                        review.likes.toString(),
                        style: context.text.labelMedium?.copyWith(
                          color: review.liked ? theme.positive : theme.textSecondary.withAlpha(150),
                          fontWeight: review.liked ? FontWeight.bold : FontWeight.normal,
                          height: 1,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      Icon(Icons.circle, size: Dimension.radius.three, color: theme.backgroundTertiary),
                      SizedBox(width: Dimension.padding.horizontal.small),
                      Transform.flip(
                        flipX: true,
                        child: Icon(
                          review.disliked ? FontAwesomeIcons.solidThumbsDown : FontAwesomeIcons.thumbsDown,
                          size: context.text.labelSmall?.fontSize,
                          color: review.disliked ? theme.negative : theme.textSecondary.withAlpha(150),
                        ),
                      ),
                      Text(
                        review.dislikes.toString(),
                        style: context.text.labelMedium?.copyWith(
                          color: review.disliked ? theme.positive : theme.textSecondary.withAlpha(150),
                          fontWeight: review.disliked ? FontWeight.bold : FontWeight.normal,
                          height: 1,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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

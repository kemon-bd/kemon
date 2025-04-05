import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class BusinessReviewItemWidget extends StatelessWidget {
  final ListingReviewEntity review;
  const BusinessReviewItemWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final mode = state.mode;
        final fallback = Center(
          child: Text(
            review.reviewer.name.symbol,
            style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
              fontSize: Dimension.radius.sixteen,
            ),
          ),
        );

        return Container(
          decoration: BoxDecoration(
            color: mode == ThemeMode.dark ? theme.backgroundSecondary : theme.backgroundPrimary,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: mode == ThemeMode.dark ? theme.backgroundSecondary : theme.textPrimary,
              width: mode == ThemeMode.dark ? 0 : .25,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          padding: EdgeInsets.all(Dimension.radius.twelve).copyWith(bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 8,
                children: [
                  Container(
                    width: Dimension.radius.thirtyTwo,
                    height: Dimension.radius.thirtyTwo,
                    decoration: BoxDecoration(
                      color: theme.backgroundSecondary,
                      borderRadius: BorderRadius.circular(Dimension.radius.thirtyTwo),
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
                            width: Dimension.radius.thirtyTwo,
                            height: Dimension.radius.thirtyTwo,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => ShimmerIcon(radius: Dimension.radius.thirtyTwo),
                            errorWidget: (_, __, ___) => fallback,
                          ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 2,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(
                              PublicProfilePage.name,
                              pathParameters: {'user': review.reviewer.identity.guid},
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: review.reviewer.name.full,
                                  style: context.text.bodyLarge?.copyWith(
                                    color: theme.primary,
                                    fontWeight: FontWeight.bold,
                                    height: 1.0,
                                  ),
                                ),
                                if (review.localGuide) ...[
                                  WidgetSpan(child: SizedBox(width: 8)),
                                  WidgetSpan(
                                    baseline: TextBaseline.ideographic,
                                    alignment: PlaceholderAlignment.middle,
                                    child: SvgPicture.asset(
                                      'images/logo/google.svg',
                                      width: Dimension.radius.twelve,
                                      height: Dimension.radius.twelve,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: Dimension.padding.vertical.verySmall),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RatingBarIndicator(
                              rating: review.star.toDouble(),
                              itemBuilder: (context, index) => Icon(Icons.star_sharp, color: review.star.color(scheme: theme)),
                              unratedColor: theme.backgroundTertiary,
                              itemCount: review.star.ceil(),
                              itemSize: 12,
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.circle, size: 4, color: theme.backgroundTertiary),
                            const SizedBox(width: 8),
                            StreamBuilder(
                              stream: Stream.periodic(const Duration(seconds: 1)),
                              builder: (context, snapshot) {
                                return Text(
                                  review.reviewedAt.duration,
                                  style: context.text.bodySmall?.copyWith(
                                    color: theme.textSecondary.withAlpha(200),
                                    fontWeight: FontWeight.normal,
                                    height: 1.0,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    onPressed: () async {
                      final actionTaken = await showDialog<bool>(
                        context: context,
                        barrierDismissible: false,
                        barrierColor: context.barrierColor,
                        builder: (_) => ReviewMenuAlert(review: review),
                      );
                      if (!context.mounted) return;
                      if (actionTaken ?? false) {
                        context.read<FindBusinessBloc>().add(RefreshBusiness(urlSlug: context.business.urlSlug));
                      }
                    },
                    icon: Icon(Icons.more_vert_rounded, color: theme.textSecondary.withAlpha(150)),
                  ),
                ],
              ),
              if (review.summary.isNotEmpty) ...[
                SizedBox(height: Dimension.padding.vertical.large),
                Text(
                  review.summary,
                  style: context.text.bodyLarge?.copyWith(
                    color: theme.textPrimary,
                    fontWeight: FontWeight.bold,
                    inherit: true,
                  ),
                ),
              ],
              if (review.content.isNotEmpty) ...[
                const SizedBox(height: 6),
                ReadMoreText(
                  review.content,
                  style: context.text.bodyMedium?.copyWith(
                    color: theme.textPrimary,
                    fontWeight: FontWeight.normal,
                    inherit: true,
                  ),
                  trimMode: TrimMode.Line,
                  trimLines: 2,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: '\t\tShow less',
                  lessStyle: context.text.bodyMedium?.copyWith(
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  moreStyle: context.text.bodyMedium?.copyWith(
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              if (review.photos.isNotEmpty) ...[
                const SizedBox(height: 8),
                SizedBox(
                  height: 64,
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: review.photos.length,
                    itemBuilder: (context, index) {
                      final photo = review.photos[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: theme.backgroundPrimary,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: theme.backgroundTertiary, width: .5),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(
                              PhotoPreviewPage.name,
                              pathParameters: {'url': review.photos.map((e) => e.url).join(',')},
                              queryParameters: {'index': index.toString()},
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: photo.url,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const ShimmerLabel(width: 64, height: 64, radius: 12),
                            errorWidget: (context, url, error) => Icon(
                              Icons.broken_image_rounded,
                              size: 32,
                              color: theme.backgroundTertiary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              if (review.reviewedAt.dMMMMyyyy != review.experiencedAt.dMMMMyyyy) ...[
                const SizedBox(height: 8),
                Text(
                  "Experienced at ${review.experiencedAt.dMMMMyyyy}",
                  style: context.text.labelSmall?.copyWith(color: theme.textSecondary),
                ),
              ],
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: theme.backgroundTertiary, width: .25),
                  ),
                ),
                margin: EdgeInsets.only(top: Dimension.radius.twelve),
                padding: EdgeInsets.all(0).copyWith(bottom: Dimension.radius.four, top: Dimension.radius.four),
                child: Row(
                  children: [
                    ReviewLikeButton(review: review),
                    SizedBox(width: Dimension.padding.horizontal.medium),
                    ReviewDislikeButton(review: review),
                    Spacer(),
                    ReviewShareButton(review: review),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

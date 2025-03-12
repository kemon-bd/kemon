import '../../../../core/shared/shared.dart';
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
            color: theme.backgroundPrimary,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: theme.backgroundTertiary, width: .5),
          ),
          padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(
                              PublicProfilePage.name,
                              pathParameters: {'user': review.reviewer.identity.guid},
                            );
                          },
                          child: Text(
                            review.reviewer.name.full,
                            style: TextStyles.subTitle(context: context, color: theme.primary).copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RatingBarIndicator(
                              rating: review.star.toDouble(),
                              itemBuilder: (context, index) => Icon(Icons.stars_rounded, color: theme.primary),
                              unratedColor: theme.backgroundTertiary,
                              itemCount: 5,
                              itemSize: 16,
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
                                  style: TextStyles.body(context: context, color: theme.textSecondary),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (review.summary.isNotEmpty) ...[
                SizedBox(height: Dimension.padding.vertical.large),
                Text(
                  review.summary,
                  style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                ),
              ],
              if (review.content.isNotEmpty) ...[
                const SizedBox(height: 6),
                ReadMoreText(
                  review.content,
                  style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(inherit: true),
                  trimMode: TrimMode.Line,
                  trimLines: 2,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: '\t\tShow less',
                  lessStyle: TextStyles.body(context: context, color: theme.primary).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  moreStyle: TextStyles.body(context: context, color: theme.primary).copyWith(
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
                    top: BorderSide(color: theme.backgroundTertiary, width: .5),
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

import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class BusinessReviewItemWidget extends StatelessWidget {
  final ReviewEntity review;
  const BusinessReviewItemWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Container(
          decoration: BoxDecoration(
            color: theme.backgroundPrimary,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: theme.backgroundTertiary, width: .5),
          ),
          child: BlocProvider(
            create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: review.user)),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(bottom: 0),
              children: [
                Row(
                  children: [
                    ProfilePictureWidget(
                      size: 48,
                      onTap: () {
                        context.pushNamed(
                          PublicProfilePage.name,
                          pathParameters: {'user': review.user.guid},
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileNameWidget(
                            style: TextStyles.overline(context: context, color: theme.primary).copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            onTap: () {
                              context.pushNamed(
                                PublicProfilePage.name,
                                pathParameters: {'user': review.user.guid},
                              );
                            },
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RatingBarIndicator(
                                rating: review.rating.toDouble(),
                                itemBuilder: (context, index) => Icon(Icons.star_rounded, color: theme.primary),
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
                                    review.date.duration,
                                    style: TextStyles.caption(context: context, color: theme.textSecondary).copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
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
                SizedBox(height: Dimension.padding.vertical.large),
                Text(
                  review.title,
                  style: TextStyles.subTitle(context: context, color: theme.textPrimary).copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.25,
                  ),
                ),
                if (review.description != null) ...[
                  const SizedBox(height: 6),
                  ReadMoreText(
                    review.description ?? "",
                    style: TextStyles.body(context: context, color: theme.textSecondary),
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    trimCollapsedText: '...more',
                    trimExpandedText: '\t\tShow less',
                    lessStyle: TextStyles.subTitle(context: context, color: theme.primary).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    moreStyle: TextStyles.subTitle(context: context, color: theme.primary).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                if (review.photos.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 64,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: review.photos.length,
                      itemBuilder: (context, index) {
                        final photo = review.photos[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
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
                                errorWidget: (context, url, error) => const Icon(Icons.broken_image_rounded),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                      BlocProvider(
                        create: (context) => sl<ReactionBloc>()..add(FindReaction(review: review.identity)),
                        child: BlocBuilder<ReactionBloc, ReactionState>(
                          builder: (context, state) {
                            if (state is ReactionDone) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ReviewLikeButton(review: review.identity),
                                  ReviewDislikeButton(review: review.identity),
                                ],
                              );
                            } else if (state is ReactionLoading) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: Dimension.padding.horizontal.verySmall),
                                  ShimmerIcon(radius: Dimension.radius.twelve),
                                  SizedBox(width: Dimension.padding.horizontal.verySmall),
                                  ShimmerLabel(
                                    width: Dimension.size.horizontal.thirtyTwo,
                                    height: Dimension.size.vertical.twelve,
                                    radius: Dimension.radius.twelve,
                                  ),
                                  SizedBox(width: Dimension.padding.horizontal.medium),
                                  ShimmerIcon(radius: Dimension.radius.twelve),
                                  SizedBox(width: Dimension.padding.horizontal.verySmall),
                                  SizedBox(width: Dimension.padding.horizontal.verySmall),
                                  ShimmerLabel(
                                    width: Dimension.size.horizontal.thirtyTwo,
                                    height: Dimension.size.vertical.twelve,
                                    radius: Dimension.radius.twelve,
                                  ),
                                ],
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ),
                      Spacer(),
                      BlocBuilder<FindBusinessBloc, FindBusinessState>(
                        builder: (context, state) {
                          if (state is FindBusinessDone) {
                            final business = context.business;
                            return BlocBuilder<FindProfileBloc, FindProfileState>(
                              builder: (context, state) {
                                if (state is FindProfileDone) {
                                  final profile = state.profile;
                                  return TextButton.icon(
                                    onPressed: () async {
                                      final result = await Share.share(
                                        """🌟 Discover the Best, Rated by the Rest! 🌟
🚀 Explore authentic reviews and ratings on Kemon!
💬 Real People. Real Reviews. Make smarter decisions today.
👀 Check out ${profile.name.full}'s review about "${business.name.full}" at (https://kemon.com.bd/review-detail/${review.identity.id}) now and share your experience with the community!

📲 Join the conversation on Kemon – Bangladesh's Premier Review Platform!

#KemonApp #TrustedReviews #CommunityFirst #RealOpinions""",
                                      );

                                      if (result.status == ShareResultStatus.success && context.mounted) {
                                        result.raw;
                                        context.successNotification(
                                          message: 'Thank you for sharing ${profile.name.full}\'s review',
                                        );
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimension.radius.eight,
                                        vertical: Dimension.radius.four,
                                      ),
                                      visualDensity: VisualDensity.compact,
                                      shape:
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimension.radius.sixteen)),
                                      overlayColor: theme.textPrimary,
                                    ),
                                    icon: Icon(
                                      Icons.share_rounded,
                                      color: theme.textSecondary,
                                      size: Dimension.radius.sixteen,
                                    ),
                                    label: Text(
                                      "Share",
                                      style: TextStyles.body(context: context, color: theme.textSecondary),
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

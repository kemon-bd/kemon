import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../review.dart';

class UserReviewItemWidget extends StatelessWidget {
  final Identity user;
  final UserReviewEntity review;
  const UserReviewItemWidget({
    super.key,
    required this.review,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final mode = state.mode;
        final mine = user.guid.same(as: context.auth.guid);
        final fallback = Center(
          child: Text(
            review.listing.name.symbol,
            style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
              fontSize: Dimension.radius.sixteen,
            ),
          ),
        );
        return InkWell(
          onTap: () {
            context.pushNamed(
              BusinessPage.name,
              pathParameters: {'urlSlug': review.listing.urlSlug},
            );
          },
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: mode == ThemeMode.dark ? theme.backgroundSecondary : theme.backgroundPrimary,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: theme.backgroundTertiary, width: .75),
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0).copyWith(bottom: Dimension.radius.eight),
              children: [
                InkWell(
                  onTap: () {
                    context.pushNamed(
                      BusinessPage.name,
                      pathParameters: {'urlSlug': review.listing.urlSlug},
                    );
                  },
                  child: Row(
                    spacing: 12,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox.square(
                        dimension: Dimension.radius.thirtyTwo,
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.backgroundSecondary,
                            borderRadius: BorderRadius.circular(Dimension.radius.eight),
                            border: Border.all(
                              width: 1,
                              color: theme.backgroundTertiary,
                              strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimension.radius.eight),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: review.listing.logo.isEmpty
                                ? fallback
                                : CachedNetworkImage(
                                    imageUrl: review.listing.logo.url,
                                    width: Dimension.radius.thirtyTwo,
                                    height: Dimension.radius.thirtyTwo,
                                    fit: BoxFit.contain,
                                    placeholder: (_, __) => ShimmerLabel(
                                      radius: Dimension.radius.eight,
                                      width: Dimension.radius.thirtyTwo,
                                      height: Dimension.radius.thirtyTwo,
                                    ),
                                    errorWidget: (_, __, ___) => fallback,
                                  ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          spacing: 2,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: review.listing.name.full,
                                    style: context.text.bodyLarge?.copyWith(
                                      color: theme.primary,
                                      fontWeight: FontWeight.bold,
                                      height: 1.0,
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
                    ],
                  ),
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
                if (mine) ...[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: theme.backgroundTertiary, width: .25),
                      ),
                    ),
                    margin: EdgeInsets.only(top: Dimension.radius.twelve),
                    padding: EdgeInsets.all(0).copyWith(top: Dimension.radius.eight),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: theme.link.withAlpha(50),
                            side: BorderSide(color: theme.link, width: .25),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                          ),
                          icon: Icon(Icons.edit_outlined, color: theme.link),
                          label: Text(
                            "Edit".toUpperCase(),
                            style: context.text.titleMedium?.copyWith(
                              color: theme.link,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            final updated = await context.pushNamed<bool>(
                              EditReviewPage.name,
                              pathParameters: {'urlSlug': review.listing.urlSlug},
                              extra: review,
                            );
                            if (!(updated ?? false)) return;
                            if (!context.mounted) return;
                            context.successNotification(message: "Review updated successfully.");
                            context.read<FindUserReviewsBloc>().add(RefreshUserReviews(user: user));
                          },
                        ),
                        const SizedBox(width: 16),
                        BlocProvider(
                          create: (_) => sl<DeleteReviewBloc>(),
                          child: BlocConsumer<DeleteReviewBloc, DeleteReviewState>(
                            listener: (_, state) {
                              if (state is DeleteReviewDone) {
                                context.successNotification(message: "Review deleted successfully.");
                                context.read<FindUserReviewsBloc>().add(RefreshUserReviews(user: user));
                              }
                            },
                            builder: (deleteContext, state) {
                              if (state is DeleteReviewLoading) {
                                return TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: theme.negative.withAlpha(25),
                                    side: BorderSide(color: theme.negative, width: .25),
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                  ),
                                  onPressed: null,
                                  child: NetworkingIndicator(dimension: 28, color: theme.negative),
                                );
                              }
                              return TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: theme.negative.withAlpha(25),
                                  side: BorderSide(color: theme.negative, width: .25),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                ),
                                icon: Icon(Icons.delete_rounded, color: theme.negative),
                                label: Text(
                                  "Delete".toUpperCase(),
                                  style: context.text.titleMedium?.copyWith(
                                    color: theme.negative,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  final confirmed =
                                      await showDialog(context: context, builder: (_) => DeleteConfirmationWidget());
                                  if (!confirmed) return;
                                  if (!context.mounted) return;
                                  deleteContext.read<DeleteReviewBloc>().add(DeleteReview(review: review.identity));
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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

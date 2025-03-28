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
              color: theme.backgroundPrimary,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: theme.backgroundTertiary, width: .75),
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              children: [
                InkWell(
                  onTap: () {
                    context.pushNamed(
                      BusinessPage.name,
                      pathParameters: {'urlSlug': review.listing.urlSlug},
                    );
                  },
                  child: Row(
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
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.listing.name.full,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.subTitle(context: context, color: theme.primary),
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
                                      style: TextStyles.caption(context: context, color: theme.textSecondary),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      /* if (review.deleted || review.flagged) ...[
                        const SizedBox(width: 8),
                        RawChip(
                          elevation: 0,
                          side: BorderSide.none,
                          padding: EdgeInsets.all(0),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                          backgroundColor: review.deleted ? theme.negative : Colors.deepPurple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          label: Text(
                            review.deleted ? "Deleted" : "Flagged",
                            style: TextStyles.caption(context: context, color: theme.backgroundPrimary),
                          ),
                        ),
                      ], */
                    ],
                  ),
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: review.photos.length,
                      itemBuilder: (context, index) {
                        final photo = review.photos[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
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
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Icon(Icons.error_outline_rounded),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                if (mine) ...[
                  const Divider(height: 24, thickness: .075),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: theme.link.withAlpha(15),
                          side: BorderSide(color: theme.link, width: .75),
                        ),
                        icon: Icon(Icons.edit_outlined, color: theme.link),
                        label: Text(
                          "Edit".toUpperCase(),
                          style: TextStyles.subTitle(context: context, color: theme.link),
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
                                  disabledBackgroundColor: theme.negative.withAlpha(15),
                                  side: BorderSide(color: theme.negative, width: .75),
                                ),
                                onPressed: null,
                                child: NetworkingIndicator(dimension: 28, color: theme.negative),
                              );
                            }
                            return TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: theme.negative.withAlpha(15),
                                side: BorderSide(color: theme.negative, width: .75),
                              ),
                              icon: Icon(Icons.delete_rounded, color: theme.negative),
                              label: Text(
                                "Delete".toUpperCase(),
                                style: TextStyles.subTitle(context: context, color: theme.negative),
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
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

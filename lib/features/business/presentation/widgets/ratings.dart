import '../../../../core/shared/shared.dart';
import '../../../review/review.dart';

class BusinessRatingsWidget extends StatelessWidget {
  const BusinessRatingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return BlocBuilder<FindRatingBloc, FindRatingState>(
          builder: (builderContext, state) {
            if (state is FindRatingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FindRatingError) {
              return Center(child: Text(state.failure.message));
            } else if (state is FindRatingDone) {
              final RatingEntity rating = state.rating;
              // final bloc = builderContext.read<FindRatingBloc>();
              return BlocBuilder<FindListingReviewsBloc,
                  FindListingReviewsState>(
                builder: (context, state) {
                  if (state is FindListingReviewsDone) {
                    final userGuid = context.auth.guid ?? '';
                    final List<ReviewEntity> reviews = state.reviews;
                    final bool hasMyReview =
                        reviews.hasMyReview(userGuid: userGuid);
                    final ratingWidget =
                        Icon(Icons.star, color: theme.backgroundSecondary);
                    return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0).copyWith(top: 0),
                      children: [
                        if (!hasMyReview) ...[
                          Align(
                            alignment: Alignment.center,
                            child: RatingBar(
                              minRating: 0,
                              maxRating: 5,
                              initialRating: 0,
                              ratingWidget: RatingWidget(
                                full: ratingWidget,
                                half: ratingWidget,
                                empty: ratingWidget,
                              ),
                              onRatingUpdate: (value) async {
                                // TODO
                                /* final bool? added = await context.pushNamed(
                                        AddReviewPage.tag,
                                        queryParameters: {
                                          'id': business.guid,
                                          'rating': value.toString(),
                                        },
                                      );
                                      if (added ?? false) {
                                        bloc.add(FetchFindRating(id: business.guid));
                                      } */
                              },
                              itemCount: 5,
                              glow: false,
                              unratedColor: theme.backgroundTertiary,
                              itemSize: MediaQuery.of(context).size.width / 6,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Reviews",
                              style: TextStyles.title(
                                      context: context,
                                      color: theme.textPrimary)
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(Icons.star, color: theme.primary),
                            const SizedBox(width: 16),
                            Text(
                              rating.average.toStringAsFixed(1),
                              style: TextStyles.subTitle(
                                      context: context,
                                      color: theme.textPrimary)
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (rating.total > 0) ...[
                          const SizedBox(height: 4),
                          Text(
                            "Based on ${rating.total} review${rating.total > 1 ? "s" : ""}",
                            style: TextStyles.body(
                                context: context, color: theme.textSecondary),
                          ),
                        ],
                        const SizedBox(height: 16),
                        _RatingItem(
                          total: rating.total,
                          count: rating.five,
                          label: "5-star",
                        ),
                        const SizedBox(height: 4),
                        _RatingItem(
                          total: rating.total,
                          count: rating.four,
                          label: "4-star",
                        ),
                        const SizedBox(height: 4),
                        _RatingItem(
                          total: rating.total,
                          count: rating.three,
                          label: "3-star",
                        ),
                        const SizedBox(height: 4),
                        _RatingItem(
                          total: rating.total,
                          count: rating.two,
                          label: "2-star",
                        ),
                        const SizedBox(height: 4),
                        _RatingItem(
                          total: rating.total,
                          count: rating.one,
                          label: "1-star",
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}

class _RatingItem extends StatelessWidget {
  final int total;
  final int count;
  final String label;

  const _RatingItem({
    required this.total,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final double rating = total > 0 ? count / total : 0;
    final theme = context.read<ThemeBloc>().state.scheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text.rich(
            TextSpan(
              text: label,
              style:
                  TextStyles.body(context: context, color: theme.textPrimary),
              children: [
                TextSpan(
                  text: " ($count)",
                  style: TextStyles.caption(
                      context: context, color: theme.textSecondary),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: LinearProgressIndicator(
            value: rating,
            minHeight: 8,
            borderRadius: BorderRadius.circular(100),
            valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
            backgroundColor: theme.backgroundSecondary,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "${(rating * 100).ceil()}%",
            style:
                TextStyles.caption(context: context, color: theme.textPrimary),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

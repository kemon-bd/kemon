import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';
import '../../../profile/profile.dart';
import '../../../review/review.dart';
import '../../business.dart';

class BusinessRatingsWidget extends StatelessWidget {
  const BusinessRatingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return BlocBuilder<FindBusinessBloc, FindBusinessState>(
          builder: (context, state) {
            if (state is FindBusinessDone) {
              final business = state.business;
              return BlocBuilder<FindRatingBloc, FindRatingState>(
                builder: (builderContext, state) {
                  if (state is FindRatingLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FindRatingError) {
                    return Center(child: Text(state.failure.message));
                  } else if (state is FindRatingDone) {
                    final RatingEntity rating = state.rating;
                    return BlocBuilder<FindListingReviewsBloc, FindListingReviewsState>(
                      builder: (context, state) {
                        if (state is FindListingReviewsDone) {
                          final userGuid = context.auth.guid ?? '';
                          final List<ReviewEntity> reviews = state.reviews;
                          final bool hasMyReview = reviews.hasMyReview(userGuid: userGuid);
                          final icon = Icon(
                            Icons.star_sharp,
                            color: theme.backgroundTertiary,
                            fill: 0,
                            grade: -25,
                            weight: 100,
                          );
                          return ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16.0).copyWith(
                              top: !hasMyReview ? 4 : 16,
                            ),
                            children: [
                              if (!hasMyReview) ...[
                                Align(
                                  alignment: Alignment.center,
                                  child: BlocProvider(
                                    create: (context) => sl<FindLookupBloc>()..add(FindLookup(lookup: Lookups.profilePoints)),
                                    child: BlocBuilder<FindLookupBloc, FindLookupState>(
                                      builder: (lookupContext, state) {
                                        if (state is FindLookupDone) {
                                          final checks = state.lookups;
                                          return RatingBar(
                                            minRating: 0,
                                            maxRating: 5,
                                            initialRating: 0,
                                            ratingWidget: RatingWidget(
                                              full: icon,
                                              half: icon,
                                              empty: icon,
                                            ),
                                            updateOnDrag: false,
                                            onRatingUpdate: (value) async {
                                              final ratingBloc = lookupContext.read<FindRatingBloc>();
                                              final reviewBloc = lookupContext.read<FindListingReviewsBloc>();

                                              if (lookupContext.auth.profile == null) {
                                                final ProfileModel? authorization = await lookupContext.pushNamed<ProfileModel>(
                                                  CheckProfilePage.name,
                                                  queryParameters: {'authorize': 'true'},
                                                );
                                                if (!lookupContext.mounted) return;

                                                if (authorization == null) {
                                                  return;
                                                } else if (reviews.hasMyReview(userGuid: authorization.identity.guid)) {
                                                  reviewBloc.add(
                                                    FindListingReviews(
                                                      urlSlug: business.urlSlug,
                                                      filter: reviewBloc.state.filter,
                                                    ),
                                                  );
                                                  return;
                                                } else if (authorization.progress(checks: checks) < 50) {
                                                  final bool? progressed = await showModalBottomSheet<bool>(
                                                    context: lookupContext,
                                                    isScrollControlled: true,
                                                    barrierColor: lookupContext.barrierColor,
                                                    builder: (_) => BlocProvider.value(
                                                      value: lookupContext.read<FindLookupBloc>(),
                                                      child: ProfileCheckAlert(
                                                        checks: authorization.missing(checks: checks),
                                                      ),
                                                    ),
                                                  );
                                                  if (!lookupContext.mounted) return;
                                                  if (!progressed!) return;
                                                }
                                              } else if (lookupContext.auth.profile!.progress(checks: checks) < 50) {
                                                final bool? progressed = await showModalBottomSheet<bool>(
                                                  context: lookupContext,
                                                  isScrollControlled: true,
                                                  barrierColor: lookupContext.barrierColor,
                                                  builder: (_) => BlocProvider.value(
                                                    value: lookupContext.read<FindLookupBloc>(),
                                                    child: ProfileCheckAlert(
                                                      checks: lookupContext.auth.profile!.missing(checks: checks),
                                                    ),
                                                  ),
                                                );
                                                if (!lookupContext.mounted) return;
                                                if (!progressed!) return;
                                              }

                                              final bool? added = await lookupContext.pushNamed(
                                                NewReviewPage.name,
                                                pathParameters: {
                                                  'urlSlug': business.urlSlug,
                                                },
                                                queryParameters: {
                                                  'rating': value.toString(),
                                                },
                                              );
                                              if (added ?? false) {
                                                ratingBloc.add(RefreshRating(urlSlug: business.urlSlug));
                                                reviewBloc.add(RefreshListingReviews(
                                                  urlSlug: business.urlSlug,
                                                  filter: reviewBloc.state.filter,
                                                ));
                                              }
                                            },
                                            itemCount: 5,
                                            glow: false,
                                            unratedColor: theme.primary,
                                            itemSize: lookupContext.width / 6,
                                          );
                                        } else {
                                          return SizedBox.shrink();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Reviews",
                                    style: TextStyles.subTitle(context: context, color: theme.textPrimary).copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Icon(Icons.star, color: theme.primary, size: 24),
                                  const SizedBox(width: 12),
                                  Text(
                                    rating.average.toStringAsFixed(1),
                                    style: TextStyles.subTitle(context: context, color: theme.textPrimary).copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (rating.total > 0) ...[
                                const SizedBox(height: 4),
                                Text(
                                  "Based on ${rating.total} review${rating.total > 1 ? "s" : ""}",
                                  style: TextStyles.body(context: context, color: theme.textSecondary),
                                ),
                              ],
                              const SizedBox(height: 16),
                              _RatingItem(
                                urlSlug: business.urlSlug,
                                total: rating.total,
                                count: rating.five,
                                stars: 5,
                              ),
                              SizedBox(height: Dimension.padding.vertical.verySmall),
                              _RatingItem(
                                urlSlug: business.urlSlug,
                                total: rating.total,
                                count: rating.four,
                                stars: 4,
                              ),
                              SizedBox(height: Dimension.padding.vertical.verySmall),
                              _RatingItem(
                                urlSlug: business.urlSlug,
                                total: rating.total,
                                count: rating.three,
                                stars: 3,
                              ),
                              SizedBox(height: Dimension.padding.vertical.verySmall),
                              _RatingItem(
                                urlSlug: business.urlSlug,
                                total: rating.total,
                                count: rating.two,
                                stars: 2,
                              ),
                              SizedBox(height: Dimension.padding.vertical.verySmall),
                              _RatingItem(
                                urlSlug: business.urlSlug,
                                total: rating.total,
                                count: rating.one,
                                stars: 1,
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
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}

class _RatingItem extends StatelessWidget {
  final String urlSlug;
  final int total;
  final int count;
  final int stars;

  const _RatingItem({
    required this.urlSlug,
    required this.total,
    required this.count,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    final double rating = total > 0 ? count / total : 0;
    final theme = context.read<ThemeBloc>().state.scheme;
    return BlocBuilder<FindListingReviewsBloc, FindListingReviewsState>(
      builder: (context, state) {
        final bool checked = state.filter.contains(stars);
        return InkWell(
          onTap: () {
            final filter = [...state.filter].toList();
            if (!checked) {
              filter.add(stars);
            } else {
              filter.remove(stars);
            }

            final reviewBloc = context.read<FindListingReviewsBloc>();
            reviewBloc.add(FindListingReviews(urlSlug: urlSlug, filter: filter));
          },
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                checked ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                color: theme.primary,
                size: Dimension.radius.eighteen,
              ),
              SizedBox(width: Dimension.padding.horizontal.small),
              RatingBarIndicator(
                itemCount: 5,
                rating: stars.toDouble(),
                itemBuilder: (_, __) => Icon(Icons.star_rounded, color: theme.primary),
                unratedColor: Colors.transparent,
                itemSize: Dimension.radius.twelve,
                direction: Axis.horizontal,
              ),
              SizedBox(width: Dimension.padding.horizontal.small),
              Expanded(
                child: LinearProgressIndicator(
                  value: rating,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(100),
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                  backgroundColor: theme.backgroundSecondary,
                ),
              ),
              SizedBox(
                width: Dimension.size.horizontal.thirtySix,
                child: Text(
                  "${(rating * 100).ceil()}%",
                  style: TextStyles.caption(context: context, color: theme.textPrimary),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';
import '../../../profile/profile.dart';
import '../../../review/review.dart';
import '../../business.dart';

class BusinessRatingsWidget extends StatelessWidget {
  final BusinessEntity business;
  final BusinessRatingInsightsEntity insights;
  final List<ListingReviewEntity> reviews;

  const BusinessRatingsWidget({
    super.key,
    required this.business,
    required this.insights,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    final userGuid = context.auth.guid ?? '';
    final bool hasMyReview = reviews.hasMyReview(userGuid: userGuid);
    final icon = Icon(
      Icons.star_sharp,
      color: theme.backgroundTertiary,
      fill: 0,
      grade: -25,
      weight: 100,
    );
    return SliverPadding(
      padding: const EdgeInsets.all(16.0).copyWith(top: !hasMyReview ? 4 : 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
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
                            if (lookupContext.auth.profile == null) {
                              final ProfileModel? authorization = await lookupContext.pushNamed<ProfileModel>(
                                CheckProfilePage.name,
                                queryParameters: {'authorize': 'true'},
                              );
                              if (!lookupContext.mounted) return;

                              if (authorization == null) {
                                return;
                              }
                              if (reviews.hasMyReview(userGuid: authorization.identity.guid)) {
                                lookupContext.read<FindBusinessBloc>().add(FindBusiness(urlSlug: business.urlSlug));
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
                            if (!lookupContext.mounted) return;
                            if (added ?? false) {
                              lookupContext.read<FindBusinessBloc>().add(RefreshBusiness(urlSlug: business.urlSlug));
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
                  business.rating.toStringAsFixed(1),
                  style: TextStyles.subTitle(context: context, color: theme.textPrimary).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (business.reviews > 0) ...[
              const SizedBox(height: 4),
              Text(
                "Based on ${business.reviews} review${business.reviews > 1 ? "s" : ""}",
                style: TextStyles.body(context: context, color: theme.textSecondary),
              ),
            ],
            const SizedBox(height: 16),
            _RatingItem(count: insights.five, stars: 5),
            _RatingItem(count: insights.four, stars: 4),
            _RatingItem(count: insights.three, stars: 3),
            _RatingItem(count: insights.two, stars: 2),
            _RatingItem(count: insights.one, stars: 1),
          ],
        ),
      ),
    );
  }
}

class _RatingItem extends StatelessWidget {
  final int count;
  final int stars;

  const _RatingItem({
    required this.count,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeBloc>().state.scheme;
    return BlocBuilder<FindBusinessBloc, FindBusinessState>(
      builder: (businessContext, state) {
        if (state is FindBusinessDone) {
          final int total = state.business.reviews;
          final double rating = total > 0 ? count / total : 0;
          final filter = [...state.filter];
          final checked = filter.contains(stars);
          return InkWell(
            onTap: () {
              if (checked) {
                filter.remove(stars);
              } else {
                filter.add(stars);
              }

              businessContext.read<FindBusinessBloc>().add(
                    FindBusiness(
                      urlSlug: state.business.urlSlug,
                      filter: filter,
                    ),
                  );
            },
            splashColor: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
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
                    itemBuilder: (_, __) => Icon(Icons.stars_rounded, color: theme.primary),
                    unratedColor: Colors.transparent,
                    itemSize: Dimension.radius.sixteen,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(width: Dimension.padding.horizontal.small),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: rating,
                      minHeight: 4,
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
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

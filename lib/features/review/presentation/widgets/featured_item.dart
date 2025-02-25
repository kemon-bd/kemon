import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../lookup/lookup.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class FeaturedReviewItemWidget extends StatelessWidget {
  final ReviewEntity review;
  const FeaturedReviewItemWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return InkWell(
          onTap: () async {
            await sl<FirebaseAnalytics>().logEvent(
              name: 'home_recent_review_listing_profile',
              parameters: {
                'id': context.auth.profile?.identity.id ?? 'anonymous',
                'name': context.auth.profile?.name.full ?? 'Guest',
                'user': review.user.guid,
              },
            );
            if (!context.mounted) return;
            context.pushNamed(
              BusinessPage.name,
              pathParameters: {'urlSlug': review.listing},
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
            clipBehavior: Clip.antiAlias,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: Dimension.padding.horizontal.large,
                vertical: Dimension.padding.vertical.large,
              ).copyWith(top: Dimension.padding.vertical.medium),
              clipBehavior: Clip.antiAlias,
              children: [
                BlocProvider(
                  create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: review.user)),
                  child: InkWell(
                    onTap: () async {
                      await sl<FirebaseAnalytics>().logEvent(
                        name: 'home_recent_review_user_profile',
                        parameters: {
                          'id': context.auth.profile?.identity.id ?? 'anonymous',
                          'name': context.auth.profile?.name.full ?? 'Guest',
                          'user': review.user.guid,
                        },
                      );
                      if (!context.mounted) return;
                      context.pushNamed(
                        PublicProfilePage.name,
                        pathParameters: {'user': review.user.guid},
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocBuilder<FindProfileBloc, FindProfileState>(
                          builder: (context, state) {
                            if (state is FindProfileDone) {
                              return ProfilePointsBuilder(builder: (checks) {
                                return ProfilePictureWidget(
                                  size: Dimension.radius.twentyFour,
                                  showBadge: state.profile.progress(checks: checks)==100,
                                );
                              });
                            } else {
                              return ProfilePictureWidget(size: Dimension.radius.twentyFour);
                            }
                          },
                        ),
                        SizedBox(width: Dimension.padding.horizontal.medium),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileNameWidget(style: TextStyles.body(context: context, color: theme.primary)),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RatingBarIndicator(
                                    rating: review.rating.toDouble(),
                                    itemBuilder: (context, index) => Icon(Icons.star_rounded, color: theme.primary),
                                    unratedColor: theme.textSecondary.withAlpha(50),
                                    itemCount: 5,
                                    itemSize: Dimension.radius.twelve,
                                    direction: Axis.horizontal,
                                  ),
                                  SizedBox(width: Dimension.padding.horizontal.medium),
                                  Icon(Icons.circle, size: Dimension.radius.three, color: theme.backgroundTertiary),
                                  SizedBox(width: Dimension.padding.horizontal.medium),
                                  Expanded(
                                    child: StreamBuilder(
                                      stream: Stream.periodic(const Duration(seconds: 1)),
                                      builder: (context, snapshot) {
                                        return Text(
                                          review.reviewedAt.duration,
                                          style:
                                              TextStyles.caption(context: context, color: theme.textSecondary.withAlpha(150)),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: Dimension.size.vertical.sixteen),
                BlocProvider(
                  create: (context) => sl<FindBusinessBloc>()..add(FindBusiness(urlSlug: review.listing)),
                  child: BusinessNameWidget(
                    style: TextStyles.body(context: context, color: theme.primary).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    onTap: () async {
                      await sl<FirebaseAnalytics>().logEvent(
                        name: 'home_recent_review_listing',
                        parameters: {
                          'id': context.auth.profile?.identity.id ?? 'anonymous',
                          'name': context.auth.profile?.name.full ?? 'Guest',
                          'user': review.user.guid,
                          'listing': review.listing,
                        },
                      );
                      if (!context.mounted) return;
                      context.pushNamed(
                        BusinessPage.name,
                        pathParameters: {'urlSlug': review.listing},
                      );
                    },
                  ),
                ),
                if (review.title.isNotEmpty) ...[
                  SizedBox(height: Dimension.padding.vertical.small),
                  Text(
                    review.title,
                    style: TextStyles.body(context: context, color: theme.textPrimary),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
                if ((review.description ?? "").isNotEmpty) ...[
                  SizedBox(height: Dimension.padding.vertical.small),
                  Text(
                    review.description ?? "",
                    style:
                        TextStyles.caption(context: context, color: theme.textSecondary.withAlpha(150)).copyWith(height: 1.1),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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

import '../../../../../core/config/config.dart';
import '../../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../../review/review.dart';
import '../../business.dart';

class BusinessItemWidget extends StatelessWidget {
  final String urlSlug;
  const BusinessItemWidget({
    super.key,
    required this.urlSlug,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocProvider(
          create: (_) => sl<FindBusinessBloc>()..add(FindBusiness(urlSlug: urlSlug)),
          child: BlocBuilder<FindBusinessBloc, FindBusinessState>(
            builder: (_, state) {
              if (state is FindBusinessDone) {
                final business = state.business;
                expandWidget(expanded) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (business.contact.website?.isNotEmpty ?? false) ...[
                              Icon(Icons.public_rounded, color: theme.primary, size: 16),
                              const SizedBox(width: 8),
                            ],
                            if (business.contact.email?.isNotEmpty ?? false) ...[
                              Icon(Icons.email_outlined, color: theme.primary, size: 16),
                              const SizedBox(width: 8),
                            ],
                            if (business.contact.phone?.isNotEmpty ?? false)
                              Icon(Icons.phone_rounded, color: theme.primary, size: 16),
                          ],
                        ),
                        ExpandableButton(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Latest reviews",
                                style: TextStyles.subTitle(context: context, color: theme.primary),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                                color: theme.primary,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    context.pushNamed(
                      BusinessPage.name,
                      pathParameters: {
                        "urlSlug": business.urlSlug,
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: theme.backgroundPrimary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.backgroundTertiary, width: .5),
                      boxShadow: [
                        BoxShadow(
                          color: theme.backgroundTertiary,
                          blurRadius: .25,
                          spreadRadius: .25,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.none,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0).copyWith(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  color: theme.backgroundPrimary,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: theme.backgroundTertiary, width: .75),
                                ),
                                child: business.logo.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: business.logo.url,
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) => const ShimmerLabel(width: 48, height: 48, radius: 8),
                                        errorWidget: (context, error, stackTrace) =>
                                            const Center(child: Icon(Icons.category_rounded)),
                                      )
                                    : const Center(child: Icon(Icons.category_rounded)),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      business.name.full,
                                      style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                                    ),
                                    const SizedBox(height: 4),
                                    BlocProvider(
                                      create: (context) => sl<FindRatingBloc>()..add(FindRating(urlSlug: urlSlug)),
                                      child: BlocBuilder<FindRatingBloc, FindRatingState>(
                                        builder: (context, state) {
                                          if (state is FindRatingDone) {
                                            final rating = state.rating;
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                RatingBarIndicator(
                                                  itemBuilder: (_, __) => Icon(Icons.stars_rounded, color: theme.primary),
                                                  unratedColor: theme.backgroundSecondary,
                                                  rating: rating.average,
                                                  itemCount: 5,
                                                  itemSize: 16,
                                                  direction: Axis.horizontal,
                                                ),
                                                if (rating.average > 0) ...[
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    rating.average.toStringAsFixed(1),
                                                    style: TextStyles.body(context: context, color: theme.textSecondary),
                                                  ),
                                                ],
                                                const SizedBox(width: 8),
                                                Icon(Icons.circle, size: 4, color: theme.backgroundSecondary),
                                                const SizedBox(width: 8),
                                                Text(
                                                  rating.total > 0
                                                      ? "${rating.total} review${rating.total > 1 ? 's' : ''}"
                                                      : 'No review yet',
                                                  style: TextStyles.body(
                                                    context: context,
                                                    color: rating.total > 0 ? theme.textSecondary : theme.backgroundTertiary,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                          return Container();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ExpandableNotifier(
                          child: Expandable(
                            collapsed: Padding(
                              padding: const EdgeInsets.all(12.0).copyWith(top: 4),
                              child: expandWidget(false),
                            ),
                            expanded: ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              clipBehavior: Clip.none,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0).copyWith(top: 4),
                                  child: expandWidget(true),
                                ),
                                BlocProvider(
                                  create: (context) => sl<FindListingReviewsBloc>()..add(FindListingReviews(urlSlug: urlSlug)),
                                  child: BlocBuilder<FindListingReviewsBloc, FindListingReviewsState>(
                                    builder: (context, state) {
                                      if (state is FindListingReviewsDone) {
                                        final reviews = state.reviews;
                                        if (reviews.isNotEmpty) {
                                          return SizedBox(
                                            width: context.width,
                                            height: 154,
                                            child: ListView.separated(
                                              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 12),
                                              shrinkWrap: true,
                                              clipBehavior: Clip.none,
                                              scrollDirection: Axis.horizontal,
                                              separatorBuilder: (_, __) => const SizedBox(width: 8),
                                              itemBuilder: (_, index) {
                                                final review = reviews[index];

                                                return Container(
                                                  width: context.width * .8,
                                                  decoration: BoxDecoration(
                                                    color: theme.backgroundPrimary,
                                                    borderRadius: BorderRadius.circular(12.0),
                                                    border: Border.all(
                                                      width: .1,
                                                      strokeAlign: BorderSide.strokeAlignOutside,
                                                    ),
                                                  ),
                                                  clipBehavior: Clip.none,
                                                  child: ListView(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    padding: const EdgeInsets.all(16.0),
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      BlocProvider(
                                                        create: (context) =>
                                                            sl<FindProfileBloc>()..add(FindProfile(identity: review.user)),
                                                        child: BlocBuilder<FindProfileBloc, FindProfileState>(
                                                          builder: (context, state) {
                                                            if (state is FindProfileDone) {
                                                              final profile = state.profile;
                                                              return Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: 16,
                                                                    backgroundColor: theme.primary,
                                                                    backgroundImage: (profile.profilePicture ?? "").isNotEmpty
                                                                        ? NetworkImage(profile.profilePicture!.url)
                                                                        : null,
                                                                    child: (profile.profilePicture ?? "").isEmpty
                                                                        ? Text(
                                                                            profile.name.symbol,
                                                                            style: TextStyles.headline(
                                                                              context: context,
                                                                              color: theme.backgroundPrimary,
                                                                            ),
                                                                          )
                                                                        : null,
                                                                  ),
                                                                  const SizedBox(width: 8),
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      RatingBarIndicator(
                                                                        rating: review.rating.toDouble(),
                                                                        itemBuilder: (context, index) => Icon(
                                                                          Icons.star_rounded,
                                                                          color: theme.primary,
                                                                        ),
                                                                        unratedColor: theme.backgroundTertiary,
                                                                        itemCount: 5,
                                                                        itemSize: 16,
                                                                        direction: Axis.horizontal,
                                                                      ),
                                                                      StreamBuilder(
                                                                        stream: Stream.periodic(const Duration(seconds: 1)),
                                                                        builder: (context, snapshot) {
                                                                          return Text(
                                                                            review.date.duration,
                                                                            style: TextStyles.body(
                                                                              context: context,
                                                                              color: theme.textSecondary,
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              );
                                                            }

                                                            return Container();
                                                          },
                                                        ),
                                                      ),
                                                      const Divider(height: 24, thickness: .25),
                                                      Text(
                                                        review.title,
                                                        style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                                                      ),
                                                      if (review.description != null) ...[
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          review.description ?? "",
                                                          style:
                                                              TextStyles.caption(context: context, color: theme.textSecondary),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                );
                                              },
                                              itemCount: reviews.length,
                                            ),
                                          );
                                        } else {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8),
                                            child: Center(
                                              child: Text(
                                                "No reviews found",
                                                style: TextStyles.caption(context: context, color: theme.backgroundTertiary),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is FindBusinessLoading) {
                return const BusinessItemShimmerWidget();
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}

import '../../../../../core/config/config.dart';
import '../../../../../core/shared/shared.dart';
import '../../../../profile/profile.dart';
import '../../../review.dart';

class DashboardRecentReviewsSectionWidget extends StatelessWidget {
  const DashboardRecentReviewsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<RecentReviewsBloc, RecentReviewsState>(
          builder: (_, state) {
            if (state is RecentReviewsLoading) {
              return const DashboardRecentReviewsSectionShimmerWidget();
            } else if (state is RecentReviewsDone) {
              final reviews = state.reviews;
              return ListView(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                children: [
                  Text(
                    "Recent reviews",
                    style: TextStyles.title(context: context, color: theme.textPrimary),
                  ),
                  const SizedBox(height: 16),
                  if (reviews.isNotEmpty)
                    CarouselSlider.builder(
                      itemCount: reviews.length,
                      itemBuilder: (_, index, __) {
                        final review = reviews[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: PhysicalModel(
                            color: theme.backgroundSecondary,
                            elevation: 4,
                            shadowColor: theme.textSecondary,
                            borderRadius: BorderRadius.circular(12.0),
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(16.0),
                              children: [
                                BlocProvider(
                                  create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: review.user)),
                                  child: BlocBuilder<FindProfileBloc, FindProfileState>(
                                    builder: (context, state) {
                                      if (state is FindProfileDone) {
                                        final profile = state.profile;
                                        return Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 16,
                                              backgroundImage: (profile.profilePicture ?? "").isNotEmpty
                                                  ? NetworkImage(profile.profilePicture!.url)
                                                  : null,
                                              child: (profile.profilePicture ?? "").isEmpty ? Text(profile.name.symbol) : null,
                                            ),
                                            const SizedBox(width: 8),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  profile.name.full,
                                                  style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                                                ),
                                                const SizedBox(height: 2),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    RatingBarIndicator(
                                                      rating: review.rating.toDouble(),
                                                      itemBuilder: (context, index) =>
                                                          Icon(Icons.star_rounded, color: theme.primary),
                                                      unratedColor: theme.textSecondary.withAlpha(50),
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
                                                          style:
                                                              TextStyles.caption(context: context, color: theme.textSecondary),
                                                        );
                                                      },
                                                    ),
                                                  ],
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
                                const Divider(height: 24, thickness: .15),
                                Text(
                                  review.title,
                                  style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                if (review.description != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    review.description ?? "",
                                    style: TextStyles.body(context: context, color: theme.textSecondary),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        aspectRatio: 2.75,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        enlargeFactor: .33,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayInterval: const Duration(seconds: 5),
                        viewportFraction: .9,
                        clipBehavior: Clip.none,
                        padEnds: true,
                      ),
                    ),
                  if (reviews.isEmpty) const Text('No reviews yet'),
                  const SizedBox(height: 16),
                ],
              );
            } else if (state is RecentReviewsError) {
              return Center(
                child: Text(state.failure.message),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }
}

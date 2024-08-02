import '../../../../core/shared/shared.dart';
import '../../../review/review.dart';
import '../../business.dart';

class BusinessInformationWidget extends StatelessWidget {
  const BusinessInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final gradient = LinearGradient(
          colors: [
            theme.primary,
            theme.backgroundPrimary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
        return Container(
          padding: const EdgeInsets.all(16.0).copyWith(top: 4),
          decoration: BoxDecoration(gradient: gradient),
          child: BlocBuilder<FindBusinessBloc, FindBusinessState>(
            builder: (context, state) {
              if (state is FindBusinessLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FindBusinessError) {
                return Center(child: Text(state.failure.message));
              } else if (state is FindBusinessDone) {
                final business = state.business;
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            gradient: gradient,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: theme.semiWhite, width: .75),
                          ),
                          child: business.logo.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: business.logo.url,
                                  width: 64,
                                  height: 64,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => const ShimmerLabel(width: 64, height: 64, radius: 16),
                                  errorWidget: (context, error, stackTrace) => const Center(
                                    child: Icon(Icons.category_rounded),
                                  ),
                                )
                              : const Center(child: Icon(Icons.category_rounded)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: BlocBuilder<FindRatingBloc, FindRatingState>(
                            builder: (context, state) {
                              if (state is FindRatingDone) {
                                final rating = state.rating;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      rating.total > 0
                                          ? "${rating.total} review${rating.total > 1 ? "s" : ""} • ${rating.remarks}"
                                          : 'No review yet',
                                      style: TextStyles.body(context: context, color: theme.white),
                                    ),
                                    const SizedBox(height: 4),
                                    RatingBarIndicator(
                                      itemBuilder: (context, index) => Icon(Icons.star, color: theme.white),
                                      itemSize: 16,
                                      rating: rating.average,
                                      unratedColor: theme.semiWhite.withAlpha(25),
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
                    if (business.about.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        business.about,
                        style: TextStyles.caption(context: context, color: theme.textPrimary),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                    ],
                    const SizedBox(height: 16),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}

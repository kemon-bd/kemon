import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
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
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: theme.backgroundPrimary,
            border: Border.all(color: theme.backgroundTertiary, width: 1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: [
              BlocProvider(
                create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: review.user)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfilePictureWidget(
                      size: 32,
                      onTap: () {
                        context.pushNamed(
                          PublicProfilePage.name,
                          pathParameters: {'user': review.user.guid},
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileNameWidget(
                          style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                          onTap: () {
                            context.pushNamed(
                              PublicProfilePage.name,
                              pathParameters: {'user': review.user.guid},
                            );
                          },
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RatingBarIndicator(
                              rating: review.rating.toDouble(),
                              itemBuilder: (context, index) => Icon(Icons.star_rounded, color: theme.primary),
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
                                  style: TextStyles.caption(context: context, color: theme.textSecondary),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 24, thickness: .075),
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
        );
      },
    );
  }
}

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
          margin: EdgeInsets.symmetric(horizontal: Dimension.padding.horizontal.medium),
          decoration: BoxDecoration(
            color: theme.backgroundPrimary,
            border: Border.all(
              color: theme.backgroundTertiary,
              width: Dimension.divider.large,
              strokeAlign: BorderSide.strokeAlignOutside,
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
            ),
            clipBehavior: Clip.antiAlias,
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
                    SizedBox(width: Dimension.padding.horizontal.medium),
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
                        SizedBox(height: Dimension.padding.vertical.verySmall),
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
                            StreamBuilder(
                              stream: Stream.periodic(const Duration(seconds: 1)),
                              builder: (context, snapshot) {
                                return Text(
                                  review.date.duration,
                                  style: TextStyles.caption(context: context, color: theme.textSecondary.withAlpha(150)),
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
              Divider(height: Dimension.size.vertical.tweenty),
              Text(
                review.title,
                style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              if (review.description != null) ...[
                SizedBox(height: Dimension.padding.vertical.small),
                Text(
                  review.description ?? "",
                  style: TextStyles.body(context: context, color: theme.textSecondary.withAlpha(150)).copyWith(height: 1.1),
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

import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class ReviewDislikeButton extends StatelessWidget {
  final ReviewCoreEntity review;
  final bool details;
  const ReviewDislikeButton({
    super.key,
    required this.review,
    this.details = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    final mode = context.theme.mode;
    final disliked = review.disliked;
    return BlocProvider(
      create: (_) => sl<ReactOnReviewBloc>(),
      child: BlocConsumer<ReactOnReviewBloc, ReactOnReviewState>(
        listener: (context, state) {
          if (state is ReactOnReviewDone) {
            context.read<FindBusinessBloc>().add(RefreshBusiness(urlSlug: context.business.urlSlug));
            if (details) {
              context.read<FindReviewDetailsBloc>().add(
                    RefreshReviewDetails(review: review.identity),
                  );
            }
          } else if (state is ReactOnReviewError) {
            context.errorNotification(message: state.failure.message);
          }
        },
        builder: (builderContext, state) {
          if (state is ReactOnReviewLoading) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: Dimension.padding.horizontal.large),
                ShimmerIcon(radius: Dimension.radius.twelve),
                SizedBox(width: Dimension.padding.horizontal.verySmall),
                ShimmerLabel(
                  width: Dimension.size.horizontal.thirtyTwo,
                  height: Dimension.size.vertical.twelve,
                  radius: Dimension.radius.twelve,
                ),
              ],
            ).animate().fade();
          }
          return TextButton.icon(
            style: TextButton.styleFrom(
              overlayColor: theme.negative,
              backgroundColor: disliked
                  ? theme.negative
                  : mode == ThemeMode.dark
                      ? theme.backgroundSecondary
                      : theme.backgroundPrimary,
              padding: EdgeInsets.symmetric(
                horizontal: Dimension.radius.eight,
                vertical: Dimension.radius.four,
              ),
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
              ),
            ),
            icon: Icon(
              disliked ? FontAwesomeIcons.solidThumbsDown : FontAwesomeIcons.thumbsDown,
              size: context.text.labelLarge?.fontSize,
              color: disliked ? theme.white : theme.textSecondary.withAlpha(150),
            ),
            label: Text(
              'Dislike',
              style: context.text.labelLarge?.copyWith(
                color: disliked ? theme.white : theme.textSecondary.withAlpha(150),
                fontWeight: disliked ? FontWeight.bold : FontWeight.normal,
                height: 1,
              ),
            ),
            onPressed: () async {
              final business = context.business;
              final profile = context.auth.profile;
              final ProfileModel? authorization = profile ??
                  await context.pushNamed<ProfileModel>(
                    CheckProfilePage.name,
                    queryParameters: {'authorize': "true"},
                  );
              if (authorization == null) {
                return;
              }

              if (!context.mounted) return;
              builderContext.read<ReactOnReviewBloc>().add(
                    ReactOnReview(
                      review: review.identity,
                      reaction: Reaction.dislike,
                      listing: business.identity,
                    ),
                  );
            },
          ).animate().fade();
        },
      ),
    );
  }
}

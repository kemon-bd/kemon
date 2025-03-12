import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class ReviewDislikeButton extends StatelessWidget {
  final ReviewCoreEntity review;
  const ReviewDislikeButton({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    final disliked = review.disliked;
    final dislikes = review.dislikes;
    return BlocProvider(
      create: (_) => sl<ReactOnReviewBloc>(),
      child: BlocConsumer<ReactOnReviewBloc, ReactOnReviewState>(
        listener: (context, state) {
          if (state is ReactOnReviewDone) {
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
              padding: EdgeInsets.symmetric(
                horizontal: Dimension.radius.eight,
                vertical: Dimension.radius.four,
              ),
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
              ),
            ),
            icon: Icon(
              disliked ? Icons.thumb_down_rounded : Icons.thumb_down_off_alt_outlined,
              color: disliked ? theme.negative : theme.textSecondary,
              size: Dimension.radius.twelve,
            ),
            label: Text(
              '${dislikes > 0 ? "$dislikes " : ''}Dislike',
              style: TextStyles.body(
                context: context,
                color: disliked ? theme.negative : theme.textSecondary,
              ).copyWith(
                fontWeight: disliked ? FontWeight.bold : FontWeight.normal,
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

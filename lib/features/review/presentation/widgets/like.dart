import 'package:kemon/features/business/business.dart';

import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class ReviewLikeButton extends StatelessWidget {
  final ReviewCoreEntity review;
  final bool details;
  const ReviewLikeButton({
    super.key,
    required this.review,
    this.details = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    final mode = context.theme.mode;
    final liked = review.liked;
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
              backgroundColor: liked
                  ? theme.positive
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
              liked ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
              size: context.text.labelLarge?.fontSize,
              color: review.liked ? theme.white : theme.textSecondary.withAlpha(150),
            ),
            label: Text(
              'Like',
              style: context.text.labelLarge?.copyWith(
                color: review.liked ? theme.white : theme.textSecondary.withAlpha(150),
                fontWeight: review.liked ? FontWeight.bold : FontWeight.normal,
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
                      reaction: Reaction.like,
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

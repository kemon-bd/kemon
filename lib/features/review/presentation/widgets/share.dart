import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../profile/profile.dart';

class ReviewShareButton extends StatelessWidget {
  final Identity identity;
  const ReviewShareButton({
    super.key,
    required this.identity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindBusinessBloc, FindBusinessState>(
      builder: (context, state) {
        if (state is FindBusinessDone) {
          final business = state.business;
          return BlocBuilder<FindProfileBloc, FindProfileState>(
            builder: (_, state) {
              if (state is FindProfileDone) {
                final profile = state.profile;
                return TextButton.icon(
                  onPressed: () async {
                    final result = await Share.share(
                      """🌟 Review of ${business.name.full} by ${profile.name.full} 🌟
🚀 Explore authentic reviews and ratings on Kemon!
💬 Real People. Real Reviews. Make smarter decisions today.
👀 Check out the full review about ${business.name.full} at (https://kemon.com.bd/review-detail/${identity.id}) now and share your experience with the community!

📲 Join the conversation on Kemon – Bangladesh's Premier Review Platform!

#KemonApp #TrustedReviews #CommunityFirst #RealOpinions""",
                    );

                    if (result.status == ShareResultStatus.success && context.mounted) {
                      result.raw;
                      context.successNotification(
                        message: 'Thank you for sharing ${profile.name.full}\'s review',
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimension.radius.eight,
                      vertical: Dimension.radius.four,
                    ),
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimension.radius.sixteen)),
                    overlayColor: theme.textPrimary,
                  ),
                  icon: Icon(
                    Icons.share_rounded,
                    color: theme.textSecondary,
                    size: Dimension.radius.sixteen,
                  ),
                  label: Text(
                    "Share",
                    style: TextStyles.body(context: context, color: theme.textSecondary),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

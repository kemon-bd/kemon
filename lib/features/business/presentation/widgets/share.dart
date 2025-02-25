import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessShareButton extends StatelessWidget {
  const BusinessShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<FindBusinessBloc, FindBusinessState>(
      builder: (context, state) {
        if (state is FindBusinessDone) {
          final business = state.business;
          return IconButton(
            icon: Icon(Icons.share, color: theme.primary),
            onPressed: () async {
              final result = await Share.share(
                """🌟 Discover the Best, Rated by the Rest! 🌟
🚀 Explore authentic reviews and ratings on Kemon!
💬 Real People. Real Reviews. Make smarter decisions today.
👀 Check out ${business.name.full}(https://kemon.com.bd/review/${business.urlSlug}) now and share your experience with the community!

📲 Join the conversation on Kemon – Bangladesh's Premier Review Platform!

#KemonApp #TrustedReviews #CommunityFirst #RealOpinions""",
              );

              if (result.status == ShareResultStatus.success && context.mounted) {
                result.raw;
                context.successNotification(message: 'Thank you for sharing ${business.name.full}');
              }
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

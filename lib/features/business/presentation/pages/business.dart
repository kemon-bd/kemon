import '../../../../core/shared/shared.dart';
import '../../business.dart';
import '../../../review/review.dart';

class BusinessPage extends StatelessWidget {
  static const String path = '/business/:urlSlug';
  static const String name = 'BusinessPage';

  final String urlSlug;

  const BusinessPage({
    super.key,
    required this.urlSlug,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: theme.backgroundSecondary,
            surfaceTintColor: theme.backgroundSecondary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: theme.textPrimary),
              onPressed: context.pop,
            ),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    barrierColor: context.barrierColor,
                    barrierDismissible: true,
                    builder: (_) => BlocProvider.value(
                      value: context.read<FindBusinessBloc>(),
                      child: const BusinessAboutWidget(),
                    ),
                  );
                },
                icon: Icon(Icons.info_outline_rounded, color: theme.primary, size: 24),
                iconSize: 24,
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<FindBusinessBloc>().add(RefreshBusiness(urlSlug: urlSlug));
              context.read<FindRatingBloc>().add(RefreshRating(urlSlug: urlSlug));
              final reviewBloc = context.read<FindListingReviewsBloc>();
              reviewBloc.add(RefreshListingReviews(urlSlug: urlSlug, filter: reviewBloc.state.filter));
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                BusinessInformationWidget(),
                BusinessRatingsWidget(),
                BusinessReviewsWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

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

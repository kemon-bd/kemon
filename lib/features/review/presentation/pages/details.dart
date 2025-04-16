import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../home/home.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class ReviewDetailsPage extends StatelessWidget {
  static const String path = '/review-detail/:id';
  static const String name = 'ReviewDetailsPage';
  final Identity identity;
  const ReviewDetailsPage({
    super.key,
    required this.identity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(HomePage.name);
                }
              },
              icon: Icon(Icons.arrow_back_rounded, color: theme.textPrimary),
            ),
            backgroundColor: theme.backgroundPrimary,
          ),
          body: BlocConsumer<FindReviewDetailsBloc, FindReviewDetailsState>(
            listener: (context, state) {
              if (state is FindReviewDetailsError) {
                context.errorNotification(
                  message: state.failure.message,
                );
              } else if (state is FindReviewDetailsDone) {
                context.read<FindBusinessBloc>().add(FindBusiness(urlSlug: state.review.listing.urlSlug));
              }
            },
            builder: (context, state) {
              if (state is FindReviewDetailsDone) {
                final details = state.review;
                final fallback = Center(
                  child: Text(
                    details.reviewer.name.symbol,
                    style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
                      fontSize: Dimension.radius.sixteen,
                    ),
                  ),
                );
                onTap() {
                  showModalBottomSheet(
                    context: context,
                    constraints: BoxConstraints(
                      maxHeight: context.height * 0.6,
                      minHeight: 0,
                    ),
                    builder: (_) => BlocProvider(
                      create: (_) => sl<FindReviewReactionsBloc>()..add(FindReviewReactions(review: details.identity)),
                      child: const ReactionsSheet(),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<FindReviewDetailsBloc>().add(RefreshReviewDetails(review: identity));
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(16).copyWith(bottom: 16 + context.bottomInset, top: 0),
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Container(
                            width: Dimension.radius.thirtyTwo,
                            height: Dimension.radius.thirtyTwo,
                            decoration: BoxDecoration(
                              color: theme.backgroundSecondary,
                              borderRadius: BorderRadius.circular(Dimension.radius.thirtyTwo),
                              border: Border.all(
                                color: theme.textSecondary,
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: details.reviewer.profilePicture.isEmpty
                                ? fallback
                                : CachedNetworkImage(
                                    imageUrl: details.reviewer.profilePicture.url,
                                    width: Dimension.radius.thirtyTwo,
                                    height: Dimension.radius.thirtyTwo,
                                    fit: BoxFit.cover,
                                    placeholder: (_, __) => ShimmerIcon(radius: Dimension.radius.thirtyTwo),
                                    errorWidget: (_, __, ___) => fallback,
                                  ),
                          ),
                          Expanded(
                            child: Column(
                              spacing: 2,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                      PublicProfilePage.name,
                                      pathParameters: {'user': details.reviewer.identity.guid},
                                    );
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: details.reviewer.name.full,
                                          style: context.text.bodyLarge?.copyWith(
                                            color: theme.primary,
                                            fontWeight: FontWeight.bold,
                                            height: 1.0,
                                          ),
                                        ),
                                        if (details.localGuide) ...[
                                          WidgetSpan(child: SizedBox(width: 8)),
                                          WidgetSpan(
                                            baseline: TextBaseline.ideographic,
                                            alignment: PlaceholderAlignment.middle,
                                            child: SvgPicture.asset(
                                              'images/logo/google.svg',
                                              width: Dimension.radius.twelve,
                                              height: Dimension.radius.twelve,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: Dimension.padding.vertical.verySmall),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RatingBarIndicator(
                                      rating: details.star.toDouble(),
                                      itemBuilder: (context, index) =>
                                          Icon(Icons.star_sharp, color: details.star.color(scheme: theme)),
                                      unratedColor: theme.backgroundTertiary,
                                      itemCount: details.star.ceil(),
                                      itemSize: 12,
                                      direction: Axis.horizontal,
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(Icons.circle, size: 4, color: theme.backgroundTertiary),
                                    const SizedBox(width: 8),
                                    StreamBuilder(
                                      stream: Stream.periodic(const Duration(seconds: 1)),
                                      builder: (context, snapshot) {
                                        return Text(
                                          details.reviewedAt.duration,
                                          style: context.text.bodySmall?.copyWith(
                                            color: theme.textSecondary.withAlpha(200),
                                            fontWeight: FontWeight.normal,
                                            height: 1.0,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 32),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: details.listing.name.full,
                              style: context.text.bodyMedium?.copyWith(
                                color: theme.primary,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            if (details.listing.verified) ...[
                              WidgetSpan(child: SizedBox(width: 4)),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.aboveBaseline,
                                baseline: TextBaseline.alphabetic,
                                child: Icon(
                                  Icons.verified_rounded,
                                  color: theme.primary,
                                  size: Dimension.radius.twelve,
                                ),
                              ),
                            ],
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (details.summary.isNotEmpty) ...[
                        SizedBox(height: Dimension.padding.vertical.large),
                        Text(
                          details.summary,
                          style: context.text.bodyMedium?.copyWith(
                            color: theme.textPrimary,
                            height: 1,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                      if (details.content.isNotEmpty) ...[
                        SizedBox(height: Dimension.padding.vertical.large),
                        Text(
                          details.content,
                          style: context.text.bodySmall?.copyWith(
                            color: theme.textSecondary,
                            height: 1.15,
                          ),
                        ),
                      ],
                      if (details.photos.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 64,
                          child: ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            scrollDirection: Axis.horizontal,
                            itemCount: details.photos.length,
                            itemBuilder: (context, index) {
                              final photo = details.photos[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: theme.backgroundPrimary,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(color: theme.backgroundTertiary, width: .5),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                      PhotoPreviewPage.name,
                                      pathParameters: {'url': details.photos.map((e) => e.url).join(',')},
                                      queryParameters: {'index': index.toString()},
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: photo.url,
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const ShimmerLabel(width: 64, height: 64, radius: 12),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.broken_image_rounded,
                                      size: 32,
                                      color: theme.backgroundTertiary,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      if (details.reviewedAt.dMMMMyyyy != details.experiencedAt.dMMMMyyyy) ...[
                        const SizedBox(height: 8),
                        Text(
                          "Experienced at ${details.experiencedAt.dMMMMyyyy}",
                          style:
                              context.text.labelSmall?.copyWith(color: theme.textPrimary).copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                      const Divider(height: 24),
                      if (details.reactions == 0)
                        Text(
                          "No reactions yet",
                          style: context.text.labelSmall?.copyWith(
                            color: theme.textSecondary,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      if (details.reactions > 0) ...[
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                baseline: TextBaseline.ideographic,
                                child: InkWell(
                                  onTap: onTap,
                                  splashColor: Colors.transparent,
                                  child: Text(
                                    "${details.reactions} reaction${details.reactions > 1 ? 's' : ''}",
                                    style: context.text.labelSmall?.copyWith(
                                      color: theme.link,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: InkWell(
                                  onTap: onTap,
                                  splashColor: Colors.transparent,
                                  child: SizedBox(width: Dimension.padding.horizontal.verySmall),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                baseline: TextBaseline.ideographic,
                                child: InkWell(
                                  onTap: onTap,
                                  splashColor: Colors.transparent,
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: Dimension.radius.ten,
                                    color: theme.link,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: onTap,
                          splashColor: Colors.transparent,
                          child: const SizedBox(height: 8),
                        ),
                        InkWell(
                          onTap: onTap,
                          splashColor: Colors.transparent,
                          child: Row(
                            spacing: 4,
                            children: [
                              if (details.likes > 0)
                                Expanded(
                                  flex: details.likes,
                                  child: LinearProgressIndicator(
                                    value: 1.0,
                                    backgroundColor: theme.primary,
                                    color: theme.primary,
                                    minHeight: 4,
                                    borderRadius: BorderRadius.circular(Dimension.radius.thirtyTwo),
                                  ),
                                ),
                              if (details.dislikes > 0)
                                Expanded(
                                  flex: details.dislikes,
                                  child: LinearProgressIndicator(
                                    value: 1.0,
                                    backgroundColor: theme.negative,
                                    color: theme.negative,
                                    minHeight: 4,
                                    borderRadius: BorderRadius.circular(Dimension.radius.thirtyTwo),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                      Container(
                        padding: EdgeInsets.all(0).copyWith(bottom: Dimension.radius.four, top: Dimension.radius.four),
                        child: Row(
                          children: [
                            ReviewLikeButton(review: details, details: true),
                            SizedBox(width: Dimension.padding.horizontal.medium),
                            ReviewDislikeButton(review: details, details: true),
                            Spacer(),
                            ReviewShareButton(review: details.convertToListingBasedReview),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is FindReviewDetailsError) {
                return Center(
                  child: Text(
                    state.failure.message,
                    style: context.text.bodyLarge?.copyWith(
                      color: theme.negative,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}

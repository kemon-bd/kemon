import '../../../../core/shared/shared.dart';
import '../../../analytics/analytics.dart';
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
            theme.backgroundSecondary,
            theme.backgroundPrimary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
        return Container(
          padding: const EdgeInsets.all(16.0).copyWith(top: 0),
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
                    BusinessNameWidget(
                      style: TextStyles.bigHeadline(
                        context: context,
                        color: theme.textPrimary,
                      ).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: Dimension.padding.vertical.medium),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            if (business.logo.isNotEmpty) {
                              context.pushNamed(
                                PhotoPreviewPage.name,
                                pathParameters: {'url': business.logo.url},
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: 64,
                            height: 64,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: theme.shimmer,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: theme.backgroundTertiary, width: .75),
                            ),
                            child: business.logo.url.isNotEmpty
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
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: BlocBuilder<FindRatingBloc, FindRatingState>(
                            builder: (context, state) {
                              if (state is FindRatingDone) {
                                final rating = state.rating;
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    rating.average == 0
                                        ? RatingBarIndicator(
                                            itemBuilder: (context, index) =>
                                                Icon(Icons.star_border_rounded, color: theme.primary),
                                            itemSize: 16,
                                            rating: rating.average,
                                            unratedColor: theme.primary,
                                          )
                                        : RatingBarIndicator(
                                            itemBuilder: (context, index) => Icon(Icons.star, color: theme.primary),
                                            itemSize: 16,
                                            rating: rating.average,
                                            unratedColor: theme.textSecondary.withAlpha(50),
                                          ),
                                    const SizedBox(height: 4),
                                    Text(
                                      rating.total > 0
                                          ? "${rating.total} review${rating.total > 1 ? 's' : ''}  •  ${rating.remarks}"
                                          : 'No review yet',
                                      style: TextStyles.caption(context: context, color: theme.textPrimary),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if ((business.contact.phone ?? '').isNotEmpty) ...[
                                          AnalyticsButton(
                                            child: (bloc) => ActionChip(
                                              onPressed: () {
                                                bloc.add(SyncAnalytics(
                                                  source: AnalyticSource.phone,
                                                  referrer: business.urlSlug.url,
                                                  listing: business.identity,
                                                ));
                                                final uri = Uri(scheme: 'tel', path: business.contact.phone);
                                                launchUrl(uri);
                                              },
                                              padding: EdgeInsets.zero,
                                              backgroundColor: theme.backgroundPrimary,
                                              side: BorderSide(color: theme.primary, width: .5),
                                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                              label: Icon(
                                                Icons.phone_rounded,
                                                color: theme.primary,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                        if ((business.contact.email ?? '').isNotEmpty) ...[
                                          AnalyticsButton(
                                            child: (bloc) => ActionChip(
                                              onPressed: () {
                                                bloc.add(SyncAnalytics(
                                                  source: AnalyticSource.email,
                                                  referrer: business.urlSlug.url,
                                                  listing: business.identity,
                                                ));
                                                final uri = Uri(scheme: 'mailto', path: business.contact.phone);
                                                launchUrl(uri);
                                              },
                                              padding: EdgeInsets.zero,
                                              backgroundColor: theme.backgroundPrimary,
                                              side: BorderSide(color: theme.primary, width: .5),
                                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                              label: Icon(
                                                Icons.email_rounded,
                                                color: theme.primary,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                        if (business.address.formatted.isNotEmpty) ...[
                                          AnalyticsButton(
                                            child: (bloc) => ActionChip(
                                              onPressed: () {
                                                bloc.add(SyncAnalytics(
                                                  source: AnalyticSource.address,
                                                  referrer: business.urlSlug.url,
                                                  listing: business.identity,
                                                ));
                                                final uri = Uri(scheme: 'geo', path: business.address.formatted);
                                                launchUrl(uri);
                                              },
                                              padding: EdgeInsets.zero,
                                              backgroundColor: theme.backgroundPrimary,
                                              side: BorderSide(color: theme.primary, width: .5),
                                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                              label: Icon(
                                                Icons.place_rounded,
                                                color: theme.primary,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                        if ((business.contact.website ?? '').isNotEmpty) ...[
                                          AnalyticsButton(
                                            child: (bloc) => ActionChip(
                                              onPressed: () {
                                                final uri = Uri.parse(business.contact.website!);
                                                bloc.add(SyncAnalytics(
                                                  source: AnalyticSource.website,
                                                  referrer: uri.toString(),
                                                  listing: business.identity,
                                                ));
                                                launchUrl(uri);
                                              },
                                              padding: EdgeInsets.zero,
                                              backgroundColor: theme.backgroundPrimary,
                                              side: BorderSide(color: theme.primary, width: .5),
                                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                              label: Icon(
                                                Icons.language_rounded,
                                                color: theme.primary,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                        ActionChip(
                                          padding: EdgeInsets.zero,
                                          backgroundColor: theme.backgroundPrimary,
                                          side: BorderSide(color: theme.primary, width: .5),
                                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                          onPressed: () {
                                            showCupertinoModalPopup(
                                              context: context,
                                              barrierColor: context.barrierColor,
                                              barrierDismissible: true,
                                              builder: (_) => BlocProvider.value(
                                                value: context.read<FindBusinessBloc>(),
                                                child: const BusinessClaimWidget(),
                                              ),
                                            );
                                          },
                                          label: Icon(
                                            business.claimed ? Icons.admin_panel_settings_rounded : Icons.privacy_tip_outlined,
                                            color: theme.primary,
                                            size: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        ActionChip(
                                          padding: EdgeInsets.zero,
                                          backgroundColor: theme.backgroundPrimary,
                                          side: BorderSide(color: theme.primary, width: .5),
                                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                          onPressed: () {
                                            showCupertinoModalPopup(
                                              context: context,
                                              barrierColor: context.barrierColor,
                                              barrierDismissible: true,
                                              builder: (_) => BlocProvider.value(
                                                value: context.read<FindBusinessBloc>(),
                                                child: const BusinessVerifiedWidget(),
                                              ),
                                            );
                                          },
                                          label: Icon(
                                            business.verified ? Icons.verified_rounded : Icons.verified_outlined,
                                            color: theme.primary,
                                            size: 16,
                                          ),
                                        ),
                                      ],
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

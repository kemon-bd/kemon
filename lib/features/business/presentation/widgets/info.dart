import '../../../../core/shared/shared.dart';
import '../../../analytics/analytics.dart';
import '../../business.dart';

class BusinessInformationWidget extends StatelessWidget {
  final BusinessEntity business;
  const BusinessInformationWidget({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        return SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16).copyWith(top: 0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.backgroundSecondary, theme.backgroundPrimary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: business.name.full,
                        style:
                            TextStyles.title(context: context, color: theme.textPrimary).copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (business.verified) ...[
                        WidgetSpan(child: SizedBox(width: 8)),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.aboveBaseline,
                          baseline: TextBaseline.alphabetic,
                          child: Icon(
                            Icons.verified_rounded,
                            color: theme.primary,
                            size: Dimension.radius.twenty,
                          ),
                        ),
                      ],
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingBarIndicator(
                            itemBuilder: (context, index) => Icon(Icons.stars_rounded, color: theme.primary),
                            itemSize: 16,
                            rating: business.rating,
                            unratedColor: theme.textSecondary.withAlpha(50),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            business.reviews > 0
                                ? "${business.reviews} review${business.reviews > 1 ? 's' : ''}  •  ${business.remarks}"
                                : 'No review yet',
                            style: TextStyles.body(context: context, color: theme.textPrimary),
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import '../../../../../core/config/config.dart';
import '../../../../../core/shared/shared.dart';
import '../../business.dart';

class FeaturedBusinessItemWidget extends StatelessWidget {
  final BusinessLiteEntity business;
  const FeaturedBusinessItemWidget({
    super.key,
    required this.business,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final mode = state.mode;
        final url = business.logo.url;
        final fallback = Center(
          child: Text(
            business.name.symbol,
            style: context.text.bodyMedium?.copyWith(color: theme.textSecondary),
          ),
        );
        return InkWell(
          borderRadius: BorderRadius.circular(Dimension.radius.twelve),
          onTap: () async {
            await sl<FirebaseAnalytics>().logEvent(
              name: 'featured_listing_item',
              parameters: {
                'id': context.auth.profile?.identity.id ?? 'anonymous',
                'name': context.auth.profile?.name.full ?? 'Guest',
                'urlSlug': business.urlSlug,
              },
            );
            if (!context.mounted) return;
            context.pushNamed(
              BusinessPage.name,
              pathParameters: {
                "urlSlug": business.urlSlug,
              },
            );
          },
          child: Container(
            width: context.width * 0.66,
            decoration: BoxDecoration(
              color: mode == ThemeMode.dark ? theme.backgroundSecondary : theme.backgroundPrimary,
              border: Border.all(
                color: mode == ThemeMode.dark ? theme.backgroundPrimary : theme.textPrimary,
                width: mode == ThemeMode.dark ? 0 : .25,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              borderRadius: BorderRadius.circular(Dimension.radius.twelve),
            ),
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.symmetric(
              horizontal: Dimension.padding.horizontal.large,
              vertical: Dimension.padding.vertical.medium - 1,
            ).copyWith(top: Dimension.padding.vertical.medium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: Dimension.radius.fortyEight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.backgroundSecondary,
                      borderRadius: BorderRadius.circular(Dimension.radius.eight),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimension.radius.eight),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: url.isEmpty
                          ? fallback
                          : CachedNetworkImage(
                              imageUrl: url,
                              width: Dimension.radius.fortyEight,
                              height: Dimension.radius.fortyEight,
                              fit: BoxFit.contain,
                              placeholder: (_, __) => ShimmerLabel(
                                radius: Dimension.radius.eight,
                                width: Dimension.radius.fortyEight,
                                height: Dimension.radius.fortyEight,
                              ),
                              errorWidget: (_, __, ___) => fallback,
                            ),
                    ),
                  ),
                ),
                SizedBox(width: Dimension.padding.horizontal.large),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: Dimension.padding.vertical.small,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: business.name.full,
                              style: context.text.bodyMedium?.copyWith(color: theme.textPrimary, height: 1.0),
                            ),
                            if (business.verified) ...[
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (business.rating > 0) ...[
                            Icon(
                              Icons.star_sharp,
                              color: theme.primary,
                              size: context.text.labelMedium?.fontSize,
                            ),
                            SizedBox(width: Dimension.padding.horizontal.small),
                            Text(
                              business.rating.toStringAsFixed(1),
                              style: context.text.labelMedium?.copyWith(
                                color: theme.textSecondary.withAlpha(200),
                                fontWeight: FontWeight.normal,
                                height: 1.0,
                              ),
                            ),
                            SizedBox(width: Dimension.padding.horizontal.large),
                            Icon(
                              Icons.circle,
                              size: Dimension.padding.horizontal.small,
                              color: theme.backgroundTertiary,
                            ),
                            SizedBox(width: Dimension.padding.horizontal.large),
                          ],
                          Text(
                            business.reviews > 0
                                ? "${business.reviews} review${business.reviews > 1 ? 's' : ''}"
                                : 'No review yet',
                            style: context.text.labelMedium?.copyWith(
                              color: theme.textSecondary.withAlpha(200),
                              fontWeight: FontWeight.normal,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                      if (business.thana != null || business.district != null)
                        Text(
                          "${business.thana ?? ''}${business.thana != null && business.district != null ? ', ' : ''}${business.district ?? ''}",
                          style: context.text.labelSmall?.copyWith(
                            color: theme.textSecondary.withAlpha(150),
                            fontWeight: FontWeight.normal,
                            height: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

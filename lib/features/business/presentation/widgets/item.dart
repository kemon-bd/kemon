import '../../../../../core/config/config.dart';
import '../../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessItemWidget extends StatelessWidget {
  final BusinessLiteEntity business;
  const BusinessItemWidget({
    super.key,
    required this.business,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final url = business.logo.url;
        final fallback = Center(
          child: Text(
            business.name.symbol,
            style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
              fontSize: Dimension.radius.twentyFour,
            ),
          ),
        );
        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
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
            width: context.width,
            decoration: BoxDecoration(
              color: theme.backgroundPrimary,
              border: Border.all(
                color: theme.backgroundTertiary,
                width: Dimension.divider.large,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              borderRadius: BorderRadius.circular(Dimension.radius.twelve),
            ),
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.symmetric(
              horizontal: Dimension.padding.horizontal.large,
              vertical: Dimension.padding.vertical.large,
            ),
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
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: business.name.full,
                              style: TextStyles.body(context: context, color: theme.textPrimary),
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
                      SizedBox(height: Dimension.padding.vertical.verySmall),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: Dimension.padding.vertical.verySmall,
                        children: [
                          if (business.rating > 0) ...[
                            Icon(
                              Icons.stars_rounded,
                              color: theme.primary,
                              size: Dimension.size.vertical.twelve,
                            ),
                            Text(
                              business.rating.toStringAsFixed(1),
                              style: TextStyles.caption(context: context, color: theme.primary),
                            ),
                            SizedBox(width: Dimension.padding.horizontal.medium),
                            Icon(
                              Icons.circle,
                              size: Dimension.padding.horizontal.small,
                              color: theme.backgroundTertiary,
                            ),
                            SizedBox(width: Dimension.padding.horizontal.medium),
                          ],
                          Text(
                            business.reviews > 0
                                ? "${business.reviews} review${business.reviews > 1 ? 's' : ''}"
                                : 'No review yet',
                            style: TextStyles.caption(
                              context: context,
                              color: business.reviews > 0 ? theme.primary : theme.textSecondary.withAlpha(100),
                            ),
                          ),
                        ],
                      ),
                      if (business.thana != null || business.district != null)
                        Text(
                          "${business.thana ?? ''}${business.thana != null && business.district != null ? ', ' : ''}${business.district ?? ''}",
                          style: TextStyles.overline(context: context, color: theme.textSecondary.withAlpha(100)),
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

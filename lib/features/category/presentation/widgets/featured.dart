import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../category.dart';

class FeaturedCategoriesWidget extends StatelessWidget {
  const FeaturedCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<OverviewBloc, OverviewState>(
          builder: (_, state) {
            if (state is OverviewLoading) {
              return const DashboardFeaturedCategoriesSectionShimmerWidget();
            } else if (state is OverviewDone) {
              final categories = state.categories;
              return ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimension.padding.horizontal.max,
                  vertical: Dimension.padding.horizontal.max,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyles.body(context: context, color: theme.textSecondary),
                      ),
                      ActionChip(
                        label: Text(
                          "See all",
                          style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: theme.backgroundSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(width: 0, color: Colors.transparent),
                        ),
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        onPressed: () async {
                          await sl<FirebaseAnalytics>().logEvent(
                            name: 'home_featured_categories_all',
                            parameters: {
                              'id': context.auth.profile?.identity.id ?? 'anonymous',
                              'name': context.auth.profile?.name.full ?? 'Guest',
                            },
                          );
                          if (!context.mounted) return;
                          context.pushNamed(CategoriesPage.name);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: Dimension.padding.vertical.small),
                  SizedBox(
                    height: 120,
                    child: MasonryGridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: Dimension.padding.horizontal.max,
                      crossAxisSpacing: Dimension.padding.vertical.small,
                      padding: EdgeInsets.zero,
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final category = categories.elementAt(index);
                        return InkWell(
                          borderRadius: BorderRadius.circular(Dimension.radius.max),
                          onTap: () async {
                            await sl<FirebaseAnalytics>().logEvent(
                              name: 'home_featured_categories_item',
                              parameters: {
                                'id': context.auth.profile?.identity.id ?? 'anonymous',
                                'name': context.auth.profile?.name.full ?? 'Guest',
                                'category': category.name.full,
                                'urlSlug': category.urlSlug,
                              },
                            );
                            if (!context.mounted) return;
                            context.pushNamed(
                              CategoryPage.name,
                              pathParameters: {
                                'urlSlug': category.urlSlug,
                              },
                              queryParameters: {
                                'industry': category.industry.guid,
                                'category': category.identity.guid,
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimension.radius.four),
                            child: Row(
                              children: [
                                category.icon.url.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: category.icon.url,
                                        width: Dimension.radius.sixteen,
                                        height: Dimension.radius.sixteen,
                                        placeholder: (context, url) => ShimmerIcon(radius: Dimension.radius.sixteen),
                                        errorWidget: (context, url, error) => Icon(
                                          Icons.layers_outlined,
                                          color: theme.textSecondary,
                                          size: Dimension.radius.sixteen,
                                        ),
                                      )
                                    : Icon(
                                        Icons.layers_outlined,
                                        color: theme.textSecondary,
                                        size: Dimension.radius.sixteen,
                                      ),
                                SizedBox(width: Dimension.padding.horizontal.small),
                                Text(
                                  category.name.full,
                                  style: TextStyles.body(context: context, color: theme.textPrimary),
                                ),
                                SizedBox(width: Dimension.padding.horizontal.small),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is OverviewError) {
              return Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: theme.negative.withAlpha(15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: .5, color: theme.negative)),
                alignment: Alignment.center,
                child: Column(
                  spacing: 16,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cloud_off_rounded, size: 42, color: theme.negative),
                    Text(
                      state.failure.message,
                      style: context.text.bodyMedium?.copyWith(color: theme.negative),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }
}

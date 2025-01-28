import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../category.dart';

class FeaturedCategoriesWidget extends StatelessWidget {
  const FeaturedCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<FeaturedCategoriesBloc, FeaturedCategoriesState>(
          builder: (_, state) {
            if (state is FeaturedCategoriesLoading) {
              return const DashboardFeaturedCategoriesSectionShimmerWidget();
            } else if (state is FeaturedCategoriesDone) {
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
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimension.radius.four),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: theme.backgroundTertiary,
                                  radius: Dimension.radius.twelve,
                                  child: category.icon.url.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: category.icon.url,
                                          width: Dimension.radius.twelve,
                                          height: Dimension.radius.twelve,
                                          placeholder: (context, url) => ShimmerIcon(radius: Dimension.radius.twelve),
                                          errorWidget: (context, url, error) => Icon(
                                            Icons.layers_outlined,
                                            color: theme.textSecondary,
                                            size: Dimension.radius.twelve,
                                          ),
                                        )
                                      : Icon(
                                          Icons.layers_outlined,
                                          color: theme.textSecondary,
                                          size: Dimension.radius.twelve,
                                        ),
                                ),
                                SizedBox(width: Dimension.padding.horizontal.medium),
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
            } else if (state is FeaturedCategoriesError) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    state.failure is NoInternetFailure ? Icons.cloud_off_rounded : Icons.error_outline_rounded,
                    size: Dimension.size.horizontal.seventyTwo,
                    color: theme.textSecondary,
                  ),
                  Text(
                    state.failure.message,
                    style: TextStyles.body(context: context, color: theme.textSecondary),
                  ),
                ],
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

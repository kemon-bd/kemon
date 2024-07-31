import '../../../../../core/shared/shared.dart';
import '../../../category.dart';

class DashboardFeaturedCategoriesSectionWidget extends StatelessWidget {
  const DashboardFeaturedCategoriesSectionWidget({super.key});

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
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Featured categories",
                        style: TextStyles.title(context: context, color: theme.textPrimary),
                      ),
                      FilterChip(
                        label: Text(
                          "See all",
                          style: TextStyles.body(context: context, color: theme.primary).copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        deleteIcon: Icon(Icons.open_in_new_rounded, color: theme.primary, size: 14),
                        onDeleted: () {},
                        backgroundColor: theme.backgroundPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(width: 0, color: Colors.transparent),
                        ),
                        padding: EdgeInsets.zero,
                        labelPadding: const EdgeInsets.only(left: 12),
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        selected: false,
                        onSelected: (_) {
                          // TODO:
                          // context.pushNamed(CategoriesPage.tag);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 140,
                    child: MasonryGridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 0,
                      padding: EdgeInsets.zero,
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final category = categories.elementAt(index);
                        return ActionChip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(width: 1, color: theme.positive),
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: theme.positiveBackground,
                          onPressed: () {
                            context.pushNamed(
                              CategoryPage.name,
                              pathParameters: {
                                'urlSlug': category.urlSlug,
                              },
                            );
                          },
                          avatar: CachedNetworkImage(
                            imageUrl: category.icon.url,
                            width: 20,
                            height: 20,
                            errorWidget: (context, url, error) => Icon(Icons.layers_outlined, color: theme.positive),
                          ),
                          label: Text(category.name.full),
                          labelStyle: TextStyles.subTitle(context: context, color: theme.positive),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
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

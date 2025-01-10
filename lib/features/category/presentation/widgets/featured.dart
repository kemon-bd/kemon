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
                        style: TextStyles.title(context: context, color: theme.textPrimary),
                      ),
                      ActionChip(
                        label: Text(
                          "See all",
                          style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        backgroundColor: theme.backgroundSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(width: 0, color: Colors.transparent),
                        ),
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        onPressed: () {
                          context.pushNamed(CategoriesPage.name);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: Dimension.padding.vertical.small),
                  SizedBox(
                    height: 400.h,
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
                          onTap: () {
                            context.pushNamed(
                              CategoryPage.name,
                              pathParameters: {
                                'urlSlug': category.urlSlug,
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(Dimension.radius.four),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: theme.textPrimary,
                                  radius: Dimension.radius.twelve,
                                  child: category.icon.url.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: category.icon.url,
                                          width: Dimension.radius.twelve,
                                          height: Dimension.radius.twelve,
                                          placeholder: (context, url) => ShimmerIcon(radius: Dimension.radius.twenty),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.layers_outlined, color: theme.white, size: Dimension.radius.twelve),
                                        )
                                      : Icon(Icons.layers_outlined, color: theme.white, size: Dimension.radius.twelve),
                                ),
                                SizedBox(width: Dimension.padding.horizontal.small),
                                Text(
                                  category.name.full,
                                  style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                                ),
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
                    style: TextStyles.subHeadline(context: context, color: theme.textSecondary),
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

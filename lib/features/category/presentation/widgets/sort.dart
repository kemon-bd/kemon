import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../category.dart';

class SortBusinessesByCategoryWidget extends StatelessWidget {
  const SortBusinessesByCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;

        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16).copyWith(
            top: 16 + context.topInset,
            bottom: 16 + context.bottomInset,
          ),
          physics: const ScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sort By",
                  style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                ),
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    color: theme.textPrimary,
                    size: 24,
                    weight: 400,
                    grade: 200,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: theme.backgroundSecondary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.backgroundTertiary, width: .25),
              ),
              child: BlocBuilder<FindCategoryBloc, FindCategoryState>(
                builder: (context, state) {
                  if (state is FindCategoryDone) {
                    final category = state.category.urlSlug;

                    return BlocBuilder<FindBusinessesByCategoryBloc, FindBusinessesByCategoryState>(
                      builder: (context, state) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (_, index) {
                            final item = SortBy.values[index];
                            final selected = state.sortBy == item;

                            return InkWell(
                              onTap: () async {
                                final filter = context.read<CategoryListingsFilterBloc>().state;
                                await sl<FirebaseAnalytics>().logEvent(name: 'listings_by_category_sort');
                                if (!context.mounted) return;
                                context.read<FindBusinessesByCategoryBloc>().add(
                                      RefreshBusinessesByCategory(
                                        urlSlug: category,
                                        sort: SortBy.values[index],
                                        division: filter.division,
                                        district: filter.district,
                                        thana: filter.thana,
                                        ratings: filter.rating.stars,
                                        subCategory: filter.subCategory,
                                      ),
                                    );
                                context.pop();
                              },
                              child: Padding(
                                padding: EdgeInsets.all(Dimension.radius.sixteen),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                                      size: Dimension.radius.twenty,
                                      color: selected ? theme.primary : theme.textPrimary,
                                    ),
                                    SizedBox(width: Dimension.padding.horizontal.max),
                                    Expanded(
                                      child: Text(
                                        item.text,
                                        style: TextStyles.subTitle(
                                          context: context,
                                          color: selected ? theme.primary : theme.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: SortBy.values.length,
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

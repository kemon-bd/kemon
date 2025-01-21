import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../sub_category/sub_category.dart';
import '../../location.dart';

class LocationListingsFilter extends StatefulWidget {
  final String? division;
  final String? district;
  final String? thana;
  const LocationListingsFilter({
    super.key,
    required this.division,
    required this.district,
    required this.thana,
  });

  @override
  State<LocationListingsFilter> createState() => _LocationListingsFilterState();
}

class _LocationListingsFilterState extends State<LocationListingsFilter> {
  CategoryEntity? category;
  SubCategoryEntity? subCategory;
  RatingRange rating = RatingRange.all;

  @override
  void initState() {
    super.initState();
    final filter = context.read<LocationListingsFilterBloc>().state;
    rating = filter.rating;
    category = filter.category;
    subCategory = filter.subCategory;
  }

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
                  "Filter",
                  style: TextStyles.title(context: context, color: theme.textPrimary),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownWidget<CategoryEntity>(
                    label: 'Category',
                    labelStyle: TextStyles.body(context: context, color: theme.textSecondary),
                    text: category?.name.full ?? 'Select one',
                    textStyle: TextStyles.body(context: context, color: theme.link).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    iconColor: theme.link,
                    popup: CategoryFilter(industry: null, selection: category),
                    onSelect: (selection) {
                      setState(() {
                        category = selection;
                      });
                    },
                  ),
                  if (category != null)
                    DropdownWidget<SubCategoryEntity>(
                      label: 'Sub-category',
                      labelStyle: TextStyles.body(context: context, color: theme.textSecondary),
                      text: subCategory?.name.full ?? 'Select one',
                      textStyle: TextStyles.body(context: context, color: theme.link).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      iconColor: theme.link,
                      popup: SubCategoryFilter(
                        subCategory: subCategory,
                        category: category?.identity.guid ?? '',
                      ),
                      onSelect: (selection) {
                        setState(() {
                          category = selection;
                        });
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Rating',
              style: TextStyles.body(context: context, color: theme.textSecondary),
            ),
            const SizedBox(height: 8),
            CupertinoSlidingSegmentedControl<RatingRange>(
              groupValue: rating,
              children: {
                RatingRange.all: Text(
                  'All',
                  style: TextStyles.body(
                    context: context,
                    color: rating == RatingRange.all ? theme.white : theme.textSecondary,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                RatingRange.worst: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: rating == RatingRange.worst ? theme.white : theme.textSecondary,
                      size: Dimension.radius.sixteen,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '1 ~ 2',
                      style: TextStyles.body(
                        context: context,
                        color: rating == RatingRange.worst ? theme.white : theme.textSecondary,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                RatingRange.average: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: rating == RatingRange.average ? theme.white : theme.textSecondary,
                      size: Dimension.radius.sixteen,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '3 ~ 4',
                      style: TextStyles.body(
                        context: context,
                        color: rating == RatingRange.average ? theme.white : theme.textSecondary,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                RatingRange.best: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: rating == RatingRange.best ? theme.white : theme.textSecondary,
                      size: Dimension.radius.sixteen,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '5.0',
                      style: TextStyles.body(
                        context: context,
                        color: rating == RatingRange.best ? theme.white : theme.textSecondary,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              },
              onValueChanged: (value) {
                setState(() {
                  rating = value!;
                });
              },
              thumbColor: theme.primary,
              backgroundColor: theme.backgroundSecondary,
              padding: EdgeInsets.all(Dimension.radius.four),
            ),
            BlocBuilder<FindBusinessesByLocationBloc, FindBusinessesByLocationState>(
              builder: (context, state) {
                if (state is FindBusinessesByLocationDone) {
                  return Visibility(
                    visible: state.related.isNotEmpty,
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const Divider(height: 24),
                        Text(
                          'Related',
                          style: TextStyles.body(context: context, color: theme.textSecondary),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          constraints: BoxConstraints(
                            minHeight: Dimension.size.vertical.min,
                            maxHeight: Dimension.size.vertical.hundred,
                          ),
                          decoration: BoxDecoration(
                            color: theme.backgroundSecondary,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: theme.backgroundTertiary, width: .25),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: MasonryGridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: Dimension.padding.horizontal.large,
                            crossAxisSpacing: Dimension.padding.vertical.small,
                            padding: EdgeInsets.zero,
                            itemCount: state.related.length,
                            scrollDirection: Axis.horizontal,
                            clipBehavior: Clip.antiAlias,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              final location = state.related[index];
                              return ActionChip(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: theme.backgroundPrimary,
                                padding: const EdgeInsets.all(12),
                                side: BorderSide(color: theme.backgroundTertiary, width: 1),
                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                label: Text(
                                  location.name.full,
                                  style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {
                                  context.pop();
                                  context.pushNamed(
                                    LocationPage.name,
                                    pathParameters: {
                                      'urlSlug': location.urlSlug,
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            const Divider(height: 42),
            BlocBuilder<FindLocationBloc, FindLocationState>(
              builder: (context, state) {
                if (state is FindLocationDone) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<LocationListingsFilterBloc>().add(
                            ApplyLocationListingsFilter(
                              rating: rating,
                              division: widget.division,
                              district: widget.district,
                              thana: widget.thana,
                              category: category,
                              subCategory: subCategory,
                            ),
                          );
                      context.pop();
                    },
                    child: Text(
                      'Apply'.toUpperCase(),
                      style: TextStyles.button(context: context),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        );
      },
    );
  }
}

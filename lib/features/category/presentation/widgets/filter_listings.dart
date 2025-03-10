import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../location/location.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../category.dart';

class CategoryListingsFilter extends StatefulWidget {
  final String? category;
  const CategoryListingsFilter({
    super.key,
    required this.category,
  });

  @override
  State<CategoryListingsFilter> createState() => _CategoryListingsFilterState();
}

class _CategoryListingsFilterState extends State<CategoryListingsFilter> {
  LookupEntity? division;
  LookupEntity? district;
  LookupEntity? thana;
  SubCategoryEntity? subCategory;

  RatingRange rating = RatingRange.all;

  @override
  void initState() {
    super.initState();
    final filter = context.read<CategoryListingsFilterBloc>().state;
    rating = filter.rating;
    division = filter.division;
    district = filter.district;
    thana = filter.thana;
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
              child: DropdownWidget<SubCategoryEntity>(
                label: 'Sub-category',
                labelStyle: TextStyles.body(context: context, color: theme.textSecondary),
                text: subCategory?.name.full ?? 'Select one',
                textStyle: TextStyles.body(context: context, color: theme.link).copyWith(
                  fontWeight: FontWeight.bold,
                ),
                iconColor: theme.link,
                popup: SubCategoryFilter(subCategory: subCategory, category: widget.category ?? ''),
                onSelect: (selection) {
                  if (selection.urlSlug == subCategory?.urlSlug) {
                    setState(() {
                      subCategory = null;
                    });
                  } else {
                    setState(() {
                      subCategory = selection;
                    });
                  }
                },
              ),
            ),
            const Divider(height: 24),
            Text(
              'Location',
              style: TextStyles.body(context: context, color: theme.textSecondary),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: theme.backgroundSecondary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.backgroundTertiary, width: .25),
              ),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DropdownWidget<LookupEntity>(
                    label: 'Division',
                    labelStyle: TextStyles.body(context: context, color: theme.textSecondary),
                    text: division?.text ?? 'Select one',
                    textStyle: TextStyles.body(context: context, color: theme.link).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    iconColor: theme.link,
                    popup: BlocProvider(
                      create: (_) => sl<FindLookupBloc>()..add(const FindLookup(lookup: Lookups.division)),
                      child: DivisionFilterWidget(division: division),
                    ),
                    onSelect: (selection) {
                      if (selection.value == division?.value) {
                        setState(() {
                          division = null;
                          district = null;
                          thana = null;
                        });
                      } else {
                        setState(() {
                          division = selection;
                          district = null;
                          thana = null;
                        });
                      }
                    },
                  ),
                  if (division != null) ...[
                    const Divider(),
                    DropdownWidget<LookupEntity>(
                      label: 'District',
                      labelStyle: TextStyles.body(context: context, color: theme.textSecondary),
                      text: district?.text ?? 'Select one',
                      textStyle: TextStyles.body(context: context, color: theme.link).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      iconColor: theme.link,
                      popup: BlocProvider(
                        create: (_) => sl<FindLookupBloc>()
                          ..add(
                            FindLookupWithParent(lookup: Lookups.district, parent: division?.value ?? ''),
                          ),
                        child: DistrictFilterWidget(
                          district: district,
                          division: division?.value ?? '',
                        ),
                      ),
                      onSelect: (selection) {
                        if (selection.value == district?.value) {
                          setState(() {
                            district = null;
                            thana = null;
                          });
                        } else {
                          setState(() {
                            district = selection;
                            thana = null;
                          });
                        }
                      },
                    ),
                  ],
                  if (district != null) ...[
                    const Divider(),
                    DropdownWidget<LookupEntity>(
                      label: 'Thana',
                      labelStyle: TextStyles.body(context: context, color: theme.textSecondary),
                      text: thana?.text ?? 'Select one',
                      textStyle: TextStyles.body(context: context, color: theme.link).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      iconColor: theme.link,
                      popup: BlocProvider(
                        create: (_) => sl<FindLookupBloc>()
                          ..add(
                            FindLookupWithParent(lookup: Lookups.thana, parent: district?.value ?? ''),
                          ),
                        child: ThanaFilterWidget(
                          thana: thana,
                          district: district?.value ?? '',
                        ),
                      ),
                      onSelect: (selection) {
                        if (selection.value == thana?.value) {
                          setState(() {
                            thana = null;
                          });
                        } else {
                          setState(() {
                            thana = selection;
                          });
                        }
                      },
                    ),
                  ],
                ],
              ),
            ),
            const Divider(height: 24),
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
            BlocBuilder<FindBusinessesByCategoryBloc, FindBusinessesByCategoryState>(
              builder: (context, state) {
                if (state is FindBusinessesByCategoryDone) {
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
                              final category = state.related[index];
                              return ActionChip(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: theme.backgroundPrimary,
                                padding: const EdgeInsets.all(12),
                                side: BorderSide(color: theme.backgroundTertiary, width: 1),
                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                label: Text(
                                  category.name.full,
                                  style: TextStyles.body(context: context, color: theme.textPrimary).copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {
                                  context.pop();
                                  context.pushNamed(SubCategoryPage.name, pathParameters: {
                                    'urlSlug': category.urlSlug,
                                  });
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
            TextButton(
              onPressed: () {
                context.read<CategoryListingsFilterBloc>().add(
                      ResetCategoryListingsFilter(),
                    );
                context.pop();
              },
              child: Text(
                'Reset'.toUpperCase(),
                style: TextStyles.button(context: context).copyWith(color: theme.textPrimary),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<CategoryListingsFilterBloc>().add(
                      ApplyCategoryListingsFilter(
                        subCategory: subCategory,
                        division: division,
                        district: district,
                        thana: thana,
                        rating: rating,
                      ),
                    );
                context.pop();
              },
              child: Text(
                'Apply'.toUpperCase(),
                style: TextStyles.button(context: context),
              ),
            ),
          ],
        );
      },
    );
  }
}

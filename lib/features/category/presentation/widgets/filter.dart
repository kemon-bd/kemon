import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../location/location.dart';
import '../../../sub_category/sub_category.dart';
import '../../category.dart';

class FilterMenuWidget extends StatefulWidget {
  const FilterMenuWidget({
    super.key,
  });

  @override
  State<FilterMenuWidget> createState() => _FilterMenuWidgetState();
}

class _FilterMenuWidgetState extends State<FilterMenuWidget> {
  SortBy? sort;
  LocationEntity? division;
  LocationEntity? district;
  LocationEntity? thana;
  SubCategoryEntity? subCategory;

  final List<int> ratings = [];

  @override
  void initState() {
    super.initState();
    final filter = context.read<FilterBloc>().state;
    sort = filter.sortBy;
    ratings.addAll(filter.ratings);
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

        return Drawer(
          surfaceTintColor: theme.backgroundPrimary,
          backgroundColor: theme.backgroundPrimary,
          width: context.width * .95,
          child: ListView(
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
                    style: TextStyles.headline(
                        context: context, color: theme.textPrimary),
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
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: theme.backgroundSecondary,
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: theme.backgroundTertiary, width: .25),
                ),
                child: DropdownWidget(
                  label: 'Sort by',
                  labelStyle: TextStyles.subTitle(
                      context: context, color: theme.textSecondary),
                  text: sort.text,
                  textStyle: TextStyles.title(
                      context: context, color: theme.textPrimary),
                ),
              ),
              const Divider(height: 42),
              Text(
                'Location',
                style: TextStyles.subTitle(
                    context: context, color: theme.textPrimary),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: theme.backgroundSecondary,
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: theme.backgroundTertiary, width: .25),
                ),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    DropdownWidget(
                      label: 'Division',
                      labelStyle: TextStyles.subTitle(
                          context: context, color: theme.textSecondary),
                      text: division?.name.full ?? 'Select one',
                      textStyle: TextStyles.title(
                          context: context, color: theme.textPrimary),
                    ),
                    const Divider(),
                    DropdownWidget(
                      label: 'District',
                      labelStyle: TextStyles.subTitle(
                          context: context, color: theme.textSecondary),
                      text: district?.name.full ?? 'Select one',
                      textStyle: TextStyles.title(
                          context: context, color: theme.textPrimary),
                    ),
                    const Divider(),
                    DropdownWidget(
                      label: 'Thana',
                      labelStyle: TextStyles.subTitle(
                          context: context, color: theme.textSecondary),
                      text: thana?.name.full ?? 'Select one',
                      textStyle: TextStyles.title(
                          context: context, color: theme.textPrimary),
                    ),
                  ],
                ),
              ),
              const Divider(height: 42),
              Container(
                decoration: BoxDecoration(
                  color: theme.backgroundSecondary,
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: theme.backgroundTertiary, width: .25),
                ),
                child: DropdownWidget(
                  label: 'Category',
                  labelStyle: TextStyles.subTitle(
                      context: context, color: theme.textSecondary),
                  text: subCategory?.name.full ?? 'Select one',
                  textStyle: TextStyles.title(
                      context: context, color: theme.textPrimary),
                ),
              ),
              const Divider(height: 42),
              Text(
                'Rating',
                style: TextStyles.subTitle(
                    context: context, color: theme.textPrimary),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: theme.backgroundSecondary,
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: theme.backgroundTertiary, width: .25),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 8),
                  itemBuilder: (context, index) {
                    final rating = index + 1;
                    final selected = ratings.contains(rating);
                    return ListTile(
                      dense: true,
                      horizontalTitleGap: 24,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      leading: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: selected
                              ? theme.primary
                              : theme.backgroundTertiary,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: theme.textPrimary, width: 1),
                        ),
                        child: selected
                            ? Icon(
                                Icons.check_rounded,
                                size: 16,
                                color: theme.white,
                                weight: 700,
                                grade: 200,
                              )
                            : null,
                      ),
                      title: RatingBarIndicator(
                        itemBuilder: (_, index) =>
                            Icon(Icons.star_rounded, color: theme.primary),
                        itemSize: 24,
                        itemCount: rating,
                        unratedColor: theme.textSecondary,
                        rating: rating.toDouble(),
                      ),
                      onTap: () {
                        if (selected) {
                          ratings.remove(rating);
                        } else {
                          ratings.add(rating);
                        }
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
              BlocBuilder<FindBusinessesByCategoryBloc,
                  FindBusinessesByCategoryState>(
                builder: (context, state) {
                  if (state is FindBusinessesByCategoryDone) {
                    return Visibility(
                      visible: state.businesses.isNotEmpty,
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const Divider(height: 42),
                          Text(
                            'Related',
                            style: TextStyles.subTitle(
                                context: context, color: theme.textPrimary),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: theme.backgroundSecondary,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: theme.backgroundTertiary, width: .25),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.horizontal,
                              runAlignment: WrapAlignment.start,
                              verticalDirection: VerticalDirection.down,
                              children: state.related
                                  .map(
                                    (category) => ActionChip(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      backgroundColor: theme.backgroundPrimary,
                                      padding: const EdgeInsets.all(12),
                                      side: BorderSide(
                                          color: theme.backgroundTertiary,
                                          width: 1),
                                      visualDensity: const VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      label: Text(
                                        category.name.full,
                                        style: TextStyles.body(
                                                context: context,
                                                color: theme.textPrimary)
                                            .copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      onPressed: () {
                                        context.pop();
                                        context.pushNamed(SubCategoryPage.name,
                                            pathParameters: {
                                              'urlSlug': category.urlSlug,
                                            });
                                      },
                                    ),
                                  )
                                  .toList(),
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
              ElevatedButton(
                onPressed: () {
                  context.read<FilterBloc>().add(ApplyFilter(
                        sortBy: sort,
                        division: division,
                        district: district,
                        thana: thana,
                        subCategory: subCategory,
                        ratings: ratings,
                      ));
                  context.pop();
                },
                child: Text(
                  'Apply'.toUpperCase(),
                  style: TextStyles.miniHeadline(
                          context: context, color: theme.white)
                      .copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

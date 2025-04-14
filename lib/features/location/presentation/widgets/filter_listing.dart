import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../sub_category/sub_category.dart';

class LocationBasedListingsFilter extends StatefulWidget {
  final String division;
  final String? district;
  final String? thana;
  final IndustryWithListingCountEntity? industry;
  final CategoryWithListingCountEntity? category;
  final SubCategoryWithListingCountEntity? subCategory;
  final RatingRange ratings;
  const LocationBasedListingsFilter({
    super.key,
    required this.division,
    this.district,
    this.thana,
    required this.industry,
    required this.category,
    required this.subCategory,
    required this.ratings,
  });

  @override
  State<LocationBasedListingsFilter> createState() => _LocationBasedListingsFilterState();
}

class _LocationBasedListingsFilterState extends State<LocationBasedListingsFilter> {
  IndustryWithListingCountEntity? industry;
  CategoryWithListingCountEntity? category;
  SubCategoryWithListingCountEntity? subCategory;
  RatingRange rating = RatingRange.all;

  @override
  void initState() {
    super.initState();
    rating = widget.ratings;
    industry = widget.industry;
    category = widget.category;
    subCategory = widget.subCategory;
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
                  style: context.text.headlineSmall?.copyWith(
                    color: theme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
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
                  DropdownWidget<IndustryWithListingCountEntity>(
                    label: 'Industry',
                    labelStyle: context.text.bodyMedium?.copyWith(
                      height: 1.0,
                      color: theme.textSecondary,
                      fontWeight: FontWeight.normal,
                    ),
                    text: industry?.name.full ?? 'Select one',
                    textStyle: context.text.bodyMedium?.copyWith(
                      height: 1.0,
                      color: theme.link,
                      fontWeight: FontWeight.bold,
                    ),
                    iconColor: theme.link,
                    popup: IndustryFilter(
                      selection: industry,
                      division: widget.division,
                      district: widget.district,
                      thana: widget.thana,
                    ),
                    onSelect: (selection) {
                      setState(() {
                        industry = selection;
                        category = null;
                        subCategory = null;
                      });
                    },
                  ),
                  if (industry != null && industry!.categories.isNotEmpty)
                    DropdownWidget<CategoryWithListingCountEntity>(
                      label: 'Category',
                      labelStyle: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: theme.textSecondary,
                        fontWeight: FontWeight.normal,
                      ),
                      text: category?.name.full ?? 'Select one',
                      textStyle: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: theme.link,
                        fontWeight: FontWeight.bold,
                      ),
                      iconColor: theme.link,
                      popup: CategoryFilter(
                        selection: category,
                        categories: industry!.categories,
                        division: widget.division,
                        district: widget.district,
                        thana: widget.thana,
                      ),
                      onSelect: (selection) {
                        setState(() {
                          category = selection;
                          subCategory = null;
                        });
                      },
                    ),
                  if (category != null && category!.subCategories.isNotEmpty)
                    DropdownWidget<SubCategoryWithListingCountEntity>(
                      label: 'Sub-category',
                      labelStyle: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: theme.textSecondary,
                        fontWeight: FontWeight.normal,
                      ),
                      text: subCategory?.name.full ?? 'Select one',
                      textStyle: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: theme.link,
                        fontWeight: FontWeight.bold,
                      ),
                      iconColor: theme.link,
                      popup: LocationBasedSubCategoryFilter(
                        division: widget.division,
                        district: widget.district,
                        thana: widget.thana,
                        selection: subCategory,
                        subCategories: category!.subCategories,
                      ),
                      onSelect: (selection) {
                        setState(() {
                          subCategory = selection;
                        });
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Rating',
              style: context.text.labelMedium?.copyWith(
                height: 1.0,
                color: theme.textSecondary,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            CupertinoSlidingSegmentedControl<RatingRange>(
              groupValue: rating,
              children: {
                RatingRange.all: Text(
                  'All',
                  style: context.text.bodyMedium?.copyWith(
                    height: 1.0,
                    color: rating == RatingRange.all ? theme.white : theme.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RatingRange.poor: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.sentiment_dissatisfied_rounded,
                      color: rating == RatingRange.poor ? theme.white : theme.textSecondary,
                      size: Dimension.radius.sixteen,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Poor',
                      style: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: rating == RatingRange.poor ? theme.white : theme.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                RatingRange.average: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.sentiment_neutral_rounded,
                      color: rating == RatingRange.average ? theme.white : theme.textSecondary,
                      size: Dimension.radius.sixteen,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Average',
                      style: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: rating == RatingRange.average ? theme.white : theme.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                RatingRange.best: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.sentiment_very_satisfied_rounded,
                      color: rating == RatingRange.best ? theme.white : theme.textSecondary,
                      size: Dimension.radius.sixteen,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Best',
                      style: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: rating == RatingRange.best ? theme.white : theme.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
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
            const Divider(height: 42),
            TextButton(
              onPressed: () {
                context.pop((null, null, null, RatingRange.all));
              },
              child: Text(
                'Reset'.toUpperCase(),
                style: context.text.titleMedium?.copyWith(
                  color: theme.textPrimary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.pop((industry, category, subCategory, rating));
              },
              child: Text(
                'Apply'.toUpperCase(),
                style: context.text.titleMedium?.copyWith(
                  color: theme.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

import '../../../../core/shared/shared.dart';
import '../../../location/location.dart';

class CategoryBasedListingsFilter extends StatefulWidget {
  final Identity industry;
  final Identity? category;
  final Identity? subCategory;
  final DivisionWithListingCountEntity? division;
  final DistrictWithListingCountEntity? district;
  final ThanaWithListingCountEntity? thana;
  final RatingRange ratings;
  const CategoryBasedListingsFilter({
    super.key,
    required this.division,
    required this.district,
    required this.thana,
    required this.industry,
    this.category,
    this.subCategory,
    required this.ratings,
  });

  @override
  State<CategoryBasedListingsFilter> createState() => _CategoryBasedListingsFilterState();
}

class _CategoryBasedListingsFilterState extends State<CategoryBasedListingsFilter> {
  DivisionWithListingCountEntity? division;
  DistrictWithListingCountEntity? district;
  ThanaWithListingCountEntity? thana;
  RatingRange rating = RatingRange.all;

  @override
  void initState() {
    super.initState();
    rating = widget.ratings;
    division = widget.division;
    district = widget.district;
    thana = widget.thana;
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
                  DropdownWidget<DivisionWithListingCountEntity>(
                    label: 'Division',
                    labelStyle: context.text.bodyMedium?.copyWith(
                      height: 1.0,
                      color: theme.textSecondary,
                      fontWeight: FontWeight.normal,
                    ),
                    text: division?.name.full ?? 'Select one',
                    textStyle: context.text.bodyMedium?.copyWith(
                      height: 1.0,
                      color: theme.link,
                      fontWeight: FontWeight.bold,
                    ),
                    iconColor: theme.link,
                    popup: DivisionFilter(
                      selection: division,
                      industry: widget.industry,
                      category: widget.category,
                      subCategory: widget.subCategory,
                    ),
                    onSelect: (selection) {
                      setState(() {
                        division = selection;
                        district = null;
                        thana = null;
                      });
                    },
                  ),
                  if (division != null && division!.districts.isNotEmpty)
                    DropdownWidget<DistrictWithListingCountEntity>(
                      label: 'District',
                      labelStyle: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: theme.textSecondary,
                        fontWeight: FontWeight.normal,
                      ),
                      text: district?.name.full ?? 'Select one',
                      textStyle: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: theme.link,
                        fontWeight: FontWeight.bold,
                      ),
                      iconColor: theme.link,
                      popup: DistrictFilter(
                        selection: district,
                        districts: division!.districts,
                      ),
                      onSelect: (selection) {
                        setState(() {
                          district = selection;
                          thana = null;
                        });
                      },
                    ),
                  if (district != null && district!.thanas.isNotEmpty)
                    DropdownWidget<ThanaWithListingCountEntity>(
                      label: 'Thana',
                      labelStyle: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: theme.textSecondary,
                        fontWeight: FontWeight.normal,
                      ),
                      text: thana?.name.full ?? 'Select one',
                      textStyle: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: theme.link,
                        fontWeight: FontWeight.bold,
                      ),
                      iconColor: theme.link,
                      popup: ThanaFilter(
                        selection: thana,
                        thanas: district!.thanas,
                      ),
                      onSelect: (selection) {
                        setState(() {
                          thana = selection;
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
                context.pop((division, district, thana, rating));
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

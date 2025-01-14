import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../location.dart';

class FilterBusinessesByLocationWidget extends StatefulWidget {
  const FilterBusinessesByLocationWidget({super.key});

  @override
  State<FilterBusinessesByLocationWidget> createState() => _FilterBusinessesByLocationWidgetState();
}

enum RatingRange {
  all,
  worst,
  average,
  best,
}

class _FilterBusinessesByLocationWidgetState extends State<FilterBusinessesByLocationWidget> {
  RatingRange rating = RatingRange.all;

  @override
  void initState() {
    super.initState();
    final filter = context.read<FindBusinessesByLocationBloc>().state;
    rating = filter.ratings.isEmpty
        ? RatingRange.all
        : filter.ratings.contains(1) && filter.ratings.contains(2)
            ? RatingRange.worst
            : filter.ratings.contains(3) && filter.ratings.contains(4)
                ? RatingRange.average
                : RatingRange.best;
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
                      context.read<FindBusinessesByLocationBloc>().add(
                            FindBusinessesByLocation(
                              ratings: rating == RatingRange.all
                                  ? []
                                  : rating == RatingRange.worst
                                      ? [1, 2]
                                      : rating == RatingRange.average
                                          ? [3, 4]
                                          : [5],
                              location: state.location.urlSlug,
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

import '../../../../../core/shared/shared.dart';
import '../../category.dart';

class CategoryFilter extends StatefulWidget {
  final String division;
  final String? district;
  final String? thana;
  final List<CategoryWithListingCountEntity> categories;
  final CategoryEntity? selection;

  const CategoryFilter({
    super.key,
    required this.division,
    this.district,
    this.thana,
    required this.categories,
    required this.selection,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  final TextEditingController controller = TextEditingController();
  CategoryEntity? selection;
  late List<CategoryWithListingCountEntity> categories;

  @override
  void initState() {
    super.initState();
    selection = widget.selection;
    categories = widget.categories;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Padding(
        padding: context.viewInsets,
        child: Material(
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (themeContext, state) {
              final theme = state.scheme;
              return Container(
                decoration: BoxDecoration(
                  color: theme.backgroundPrimary,
                  border: Border(
                    top: BorderSide(color: theme.textPrimary, width: 1),
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16).copyWith(bottom: themeContext.bottomInset + 16),
                  physics: const ScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category",
                          style: context.text.headlineSmall?.copyWith(
                            color: theme.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            themeContext.pop();
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
                    TextField(
                      controller: controller,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          categories = widget.categories;
                          setState(() {});
                        } else {
                          categories = widget.categories
                              .where(
                                (element) => element.name.full.match(like: value),
                              )
                              .toList();
                          setState(() {});
                        }
                      },
                      style: TextStyles.body(context: themeContext, color: theme.textPrimary),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.backgroundSecondary,
                        hintText: "Search category ...",
                        hintStyle: TextStyles.body(context: themeContext, color: theme.textSecondary),
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.clear();
                            categories = widget.categories;
                            setState(() {});
                          },
                          child: Icon(
                            Icons.cancel_rounded,
                            color: theme.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    PhysicalModel(
                      color: theme.backgroundSecondary,
                      borderRadius: BorderRadius.circular(16),
                      child: categories.isNotEmpty
                          ? Container(
                              constraints: BoxConstraints(maxHeight: context.height * .5),
                              child: ListView.separated(
                                separatorBuilder: (context, index) => Divider(height: .25, color: theme.backgroundTertiary),
                                itemBuilder: (context, index) {
                                  final place = categories[index];
                                  final bool selected = place.name.full.same(as: selection?.name.full);

                                  return InkWell(
                                    onTap: () {
                                      context.pop(place);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                                            color: selected ? theme.positive : theme.textPrimary,
                                            size: 24,
                                            grade: 200,
                                            weight: 700,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text.rich(
                                              TextSpan(
                                                text: '',
                                                children: [
                                                  WidgetSpan(
                                                    alignment: PlaceholderAlignment.aboveBaseline,
                                                    baseline: TextBaseline.ideographic,
                                                    child: Text(
                                                      place.name.full,
                                                      style: TextStyles.body(
                                                        context: context,
                                                        color: selected ? theme.positive : theme.textPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                  WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.small)),
                                                  WidgetSpan(
                                                    alignment: PlaceholderAlignment.aboveBaseline,
                                                    baseline: TextBaseline.ideographic,
                                                    child: Text(
                                                      "(${place.listings})",
                                                      style: TextStyles.body(
                                                        context: context,
                                                        color: selected ? theme.positive : theme.textPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: categories.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero.copyWith(top: 8, bottom: 8),
                                physics: const ScrollPhysics(),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "No category found",
                                style: TextStyles.subTitle(context: themeContext, color: theme.textPrimary),
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

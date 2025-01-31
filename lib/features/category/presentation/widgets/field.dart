import '../../../../core/shared/shared.dart';
import '../../category.dart';

class CategoryField extends StatefulWidget {
  final CategoryEntity? category;
  final FocusNode? focusNode;
  final Function(CategoryEntity category) onSelect;
  const CategoryField({
    super.key,
    required this.category,
    required this.onSelect,
    this.focusNode,
  });

  @override
  State<CategoryField> createState() => _CategoryFieldState();
}

class _CategoryFieldState extends State<CategoryField> {
  CategoryEntity? category;

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final SuggestionsController<CategoryEntity> suggestionBoxController = SuggestionsController<CategoryEntity>();

  @override
  void initState() {
    super.initState();
    category = widget.category;
    suggestionBoxController.refresh();
    controller.text = category?.name.full ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;

        return BlocConsumer<FindCategoriesByIndustryBloc, FindCategoriesByIndustryState>(
          listener: (context, state) {
            if (state is FindCategoriesByIndustryDone) {
              setState(() {
                suggestionBoxController.refresh();
              });
            }
          },
          builder: (context, state) {
            if (state is FindCategoriesByIndustryDone) {
              final categories = state.categories;
              return TypeAheadField<CategoryEntity>(
                controller: controller,
                suggestionsController: suggestionBoxController,
                showOnFocus: true,
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    autofocus: true,
                    style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                  );
                },
                onSelected: (suggestion) {
                  setState(() {
                    category = suggestion;
                    controller.text = suggestion.name.full;
                    suggestionBoxController.close();
                    widget.onSelect(suggestion);
                  });
                },
                suggestionsCallback: (pattern) async {
                  if (pattern.isEmpty) {
                    return categories;
                  }
                  return categories
                      .where((category) => category.name.full.toLowerCase().contains(pattern.toLowerCase()))
                      .toList();
                },
                itemBuilder: (context, suggestion) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          suggestion.name.full,
                          style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                        ),
                      ],
                    ),
                  );
                },
                decorationBuilder: (context, child) {
                  return Material(
                    elevation: 16,
                    type: MaterialType.card,
                    color: theme.backgroundPrimary,
                    shadowColor: theme.backgroundPrimary,
                    borderRadius: BorderRadius.circular(16),
                    child: child,
                  );
                },
                listBuilder: (context, children) => ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) => children[index],
                  itemCount: children.length,
                ),
                offset: Offset.zero,
              );
            } else if (state is FindCategoriesByIndustryLoading) {
              return TextField(
                enabled: false,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Loading...",
                  isDense: true,
                ),
              );
            }
            return TextField(
              enabled: false,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Select an industry first.",
                isDense: true,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant CategoryField oldWidget) {
    super.didUpdateWidget(oldWidget);
    category = widget.category;
    controller.text = category?.name.full ?? '';
  }
}

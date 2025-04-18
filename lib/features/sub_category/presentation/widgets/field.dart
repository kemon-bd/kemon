import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class SubCategoryField extends StatefulWidget {
  final SubCategoryEntity? subCategory;
  final FocusNode? focusNode;
  final Function(SubCategoryEntity subCategory) onSelect;
  const SubCategoryField({
    super.key,
    required this.subCategory,
    required this.onSelect,
    this.focusNode,
  });

  @override
  State<SubCategoryField> createState() => _SubCategoryFieldState();
}

class _SubCategoryFieldState extends State<SubCategoryField> {
  SubCategoryEntity? subCategory;

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final SuggestionsController<SubCategoryEntity> suggestionBoxController = SuggestionsController<SubCategoryEntity>();

  @override
  void initState() {
    super.initState();
    subCategory = widget.subCategory;
    suggestionBoxController.refresh();
    controller.text = subCategory?.name.full ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final dark = state.mode == ThemeMode.dark;

        return BlocConsumer<SubCategoriesByCategoryBloc, SubCategoriesByCategoryState>(
          listener: (context, state) {
            if (state is SubCategoriesByCategoryDone) {
              setState(() {
                suggestionBoxController.refresh();
              });
            }
          },
          builder: (context, state) {
            if (state is SubCategoriesByCategoryDone) {
              final categories = state.subCategories.toList();
              return TypeAheadField<SubCategoryEntity>(
                controller: controller,
                suggestionsController: suggestionBoxController,
                showOnFocus: true,
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    autofocus: true,
                    style: context.text.bodyMedium?.copyWith(
                      color: theme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
                hideOnEmpty: true,
                onSelected: (suggestion) {
                  setState(() {
                    subCategory = suggestion;
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
                      .where(
                        (category) => subCategory?.name.full.match(like: pattern) ?? false,
                      )
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
                          style: context.text.bodyMedium?.copyWith(
                            color: theme.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                decorationBuilder: (context, child) {
                  return Material(
                    elevation: 16,
                    type: MaterialType.card,
                    color: dark ? theme.backgroundSecondary : theme.backgroundPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: theme.textPrimary,
                        width: .15,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                    shadowColor: theme.backgroundPrimary,
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
            } else if (state is SubCategoriesByCategoryLoading) {
              return TextField(
                enabled: false,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Loading...",
                  hintStyle: context.text.bodyMedium?.copyWith(
                    color: theme.textSecondary.withAlpha(200),
                    fontWeight: FontWeight.bold,
                  ),
                  isDense: true,
                ),
              );
            }
            return TextField(
              enabled: false,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Select a category first.",
                hintStyle: context.text.bodyMedium?.copyWith(
                  color: theme.textSecondary.withAlpha(200),
                  fontWeight: FontWeight.bold,
                ),
                isDense: true,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant SubCategoryField oldWidget) {
    super.didUpdateWidget(oldWidget);
    subCategory = widget.subCategory;
    controller.text = subCategory?.name.full ?? '';
  }
}

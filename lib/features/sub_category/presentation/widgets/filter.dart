import '../../../../../core/shared/shared.dart';
import '../../../../core/config/config.dart';
import '../../sub_category.dart';

class SubCategoryFilter extends StatefulWidget {
  final String category;
  final SubCategoryEntity? subCategory;

  const SubCategoryFilter({
    super.key,
    required this.category,
    required this.subCategory,
  });

  @override
  State<SubCategoryFilter> createState() => _SubCategoryFilterState();
}

class _SubCategoryFilterState extends State<SubCategoryFilter> {
  final TextEditingController controller = TextEditingController();
  SubCategoryEntity? subCategory;

  @override
  void initState() {
    super.initState();
    subCategory = widget.subCategory;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SubCategoriesByCategoryBloc>()..add(SubCategoriesByCategory(category: widget.category)),
      child: KeyboardDismissOnTap(
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
                            "Sub Category",
                            style: TextStyles.title(context: themeContext, color: theme.textPrimary),
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
                          themeContext.read<SubCategoriesByCategoryBloc>().add(
                                SearchSubCategoriesByCategory(
                                  query: value,
                                  category: widget.category,
                                ),
                              );
                        },
                        style: TextStyles.body(context: themeContext, color: theme.textPrimary),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.backgroundSecondary,
                          hintText: "Search sub-category ...",
                          hintStyle: TextStyles.body(context: themeContext, color: theme.textSecondary),
                          suffixIcon: InkWell(
                            onTap: () {
                              controller.clear();
                              themeContext.read<SubCategoriesByCategoryBloc>().add(
                                    SubCategoriesByCategory(category: widget.category),
                                  );
                            },
                            child: Icon(
                              Icons.cancel_rounded,
                              color: theme.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<SubCategoriesByCategoryBloc, SubCategoriesByCategoryState>(
                        builder: (districtContext, state) {
                          if (state is SubCategoriesByCategoryDone) {
                            return PhysicalModel(
                              color: theme.backgroundSecondary,
                              borderRadius: BorderRadius.circular(16),
                              child: state.subCategories.isNotEmpty
                                  ? Container(
                                      constraints: BoxConstraints(maxHeight: context.height * .5),
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Divider(height: .25, color: theme.backgroundTertiary),
                                        itemBuilder: (context, index) {
                                          final place = state.subCategories[index];
                                          final bool selected = place.name.full.same(as: subCategory?.name.full);

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
                                                    child: Text(
                                                      place.name.full,
                                                      style: TextStyles.body(
                                                        context: context,
                                                        color: selected ? theme.positive : theme.textPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: state.subCategories.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero.copyWith(top: 8, bottom: 8),
                                        physics: const ScrollPhysics(),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "No sub category found",
                                        style: TextStyles.subTitle(context: themeContext, color: theme.textPrimary),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

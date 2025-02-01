import '../../../../../core/shared/shared.dart';
import '../../../../core/config/config.dart';
import '../../../industry/industry.dart';
import '../../category.dart';

class CategoryFilter extends StatefulWidget {
  final IndustryEntity? industry;
  final CategoryEntity? selection;

  const CategoryFilter({
    super.key,
    required this.industry,
    required this.selection,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  final TextEditingController controller = TextEditingController();
  CategoryEntity? category;

  @override
  void initState() {
    super.initState();
    category = widget.selection;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FindCategoriesByIndustryBloc>()
        ..add(FindCategoriesByIndustry(industry: widget.industry?.urlSlug ?? '')),
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
                      children: [
                        Text(
                          "Category",
                          style: TextStyles.title(context: themeContext, color: theme.textPrimary),
                        ),
                        Spacer(),
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
                        themeContext.read<FindCategoriesByIndustryBloc>().add(
                              FindCategoriesByIndustry(industry: widget.industry?.urlSlug ?? '', query: value),
                            );
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
                            themeContext.read<FindCategoriesByIndustryBloc>().add(
                                  FindCategoriesByIndustry(industry: widget.industry?.urlSlug ?? ''),
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
                    BlocBuilder<FindCategoriesByIndustryBloc, FindCategoriesByIndustryState>(
                      builder: (builderContext, state) {
                        if (state is FindCategoriesByIndustryDone) {
                          final categories = state.categories;

                          return PhysicalModel(
                            color: theme.backgroundSecondary,
                            borderRadius: BorderRadius.circular(16),
                            child: categories.isNotEmpty
                                ? Container(
                                    constraints: BoxConstraints(
                                      maxHeight: context.height * .5,
                                    ),
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Divider(height: .25, color: theme.backgroundTertiary),
                                      itemBuilder: (context, index) {
                                        final item = categories[index];
                                        final bool selected = item.name.full.same(as: category?.name.full);
                                        return InkWell(
                                          onTap: () {
                                            context.pop(item);
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
                                                    item.name.full,
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
    );
  }
}

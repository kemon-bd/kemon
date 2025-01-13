import '../../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class SubCategoryFilterWidget extends StatefulWidget {
  final String category;
  final SubCategoryEntity? subCategory;

  const SubCategoryFilterWidget({
    super.key,
    required this.category,
    required this.subCategory,
  });

  @override
  State<SubCategoryFilterWidget> createState() =>
      _SubCategoryFilterWidgetState();
}

class _SubCategoryFilterWidgetState extends State<SubCategoryFilterWidget> {
  final TextEditingController controller = TextEditingController();
  SubCategoryEntity? subCategory;

  @override
  void initState() {
    super.initState();
    subCategory = widget.subCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.viewInsets,
      child: Material(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
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
                padding: const EdgeInsets.all(16)
                    .copyWith(bottom: context.bottomInset + 16),
                physics: const ScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sub Category",
                        style: TextStyles.subTitle(
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
                  BlocBuilder<SubCategoriesByCategoryBloc,
                      SubCategoriesByCategoryState>(
                    builder: (districtContext, state) {
                      if (state is SubCategoriesByCategoryDone) {
                        return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          children: [
                            TextField(
                              controller: controller,
                              onChanged: (value) {
                                districtContext
                                    .read<SubCategoriesByCategoryBloc>()
                                    .add(
                                      SearchSubCategoriesByCategory(
                                        query: value,
                                        category: widget.category,
                                      ),
                                    );
                              },
                              style: TextStyles.subTitle(
                                  context: context, color: theme.textPrimary),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: theme.backgroundSecondary,
                                hintText: "Search district ...",
                                suffixIcon: InkWell(
                                  onTap: () {
                                    controller.clear();
                                    districtContext
                                        .read<SubCategoriesByCategoryBloc>()
                                        .add(
                                          SubCategoriesByCategory(
                                              category: widget.category),
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
                            PhysicalModel(
                              color: theme.backgroundSecondary,
                              borderRadius: BorderRadius.circular(16),
                              child: state.subCategories.isNotEmpty
                                  ? ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Divider(
                                              height: .25,
                                              color: theme.backgroundTertiary),
                                      itemBuilder: (context, index) {
                                        final place =
                                            state.subCategories[index];
                                        final bool selected = place.name.full
                                            .same(as: subCategory?.name.full);

                                        return InkWell(
                                          onTap: () {
                                            context.pop(place);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  selected
                                                      ? Icons
                                                          .check_circle_rounded
                                                      : Icons.circle_outlined,
                                                  color: selected
                                                      ? theme.positive
                                                      : theme.textPrimary,
                                                  size: 24,
                                                  grade: 200,
                                                  weight: 700,
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Text(
                                                    place.name.full,
                                                    style: TextStyles.subTitle(
                                                      context: context,
                                                      color: selected
                                                          ? theme.positive
                                                          : theme.textPrimary,
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
                                      padding: EdgeInsets.zero
                                          .copyWith(top: 8, bottom: 8),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "No sub category found",
                                        style: TextStyles.subTitle(
                                            context: context,
                                            color: theme.textPrimary),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                            ),
                          ],
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
    );
  }
}

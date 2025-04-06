import '../../../../../core/shared/shared.dart';
import '../../../../category/category.dart';
import '../../../../industry/industry.dart';
import '../../../../sub_category/sub_category.dart';

class NewListingCategoryWidget extends StatefulWidget {
  final bool edit;
  final Function(IndustryEntity, CategoryEntity?, SubCategoryEntity?) onUpdate;
  final Function(IndustryEntity, CategoryEntity?, SubCategoryEntity?) onNext;
  final TextEditingController name;
  final IndustryEntity? industry;
  final CategoryEntity? category;
  final SubCategoryEntity? subCategory;

  const NewListingCategoryWidget({
    super.key,
    this.edit = false,
    required this.name,
    required this.onUpdate,
    required this.onNext,
    required this.industry,
    required this.category,
    required this.subCategory,
  });

  @override
  State<NewListingCategoryWidget> createState() => _NewListingLocationWidgetState();
}

class _NewListingLocationWidgetState extends State<NewListingCategoryWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController branch;

  final FocusNode industryFocusNode = FocusNode();
  IndustryEntity? industry;

  final FocusNode categoryFocusNode = FocusNode();
  CategoryEntity? category;

  final FocusNode subCategoryFocusNode = FocusNode();
  SubCategoryEntity? subCategory;

  @override
  void initState() {
    super.initState();
    industry = widget.industry;
    subCategory = widget.subCategory;
    category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(bottom: context.bottomInset + Dimension.radius.sixteen),
            children: [
              SizedBox(height: Dimension.padding.vertical.ultraProMax),
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      baseline: TextBaseline.ideographic,
                      child: Text(
                        "How would you categorize ",
                        style: context.text.headlineSmall?.copyWith(
                          color: theme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      baseline: TextBaseline.ideographic,
                      child: Text(
                        widget.name.text,
                        style: context.text.headlineSmall?.copyWith(
                          color: theme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      baseline: TextBaseline.ideographic,
                      child: Text(
                        " as ",
                        style: context.text.headlineSmall?.copyWith(
                          color: theme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 8)),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      baseline: TextBaseline.ideographic,
                      child: Icon(Icons.emergency_rounded, size: 18, color: theme.negative),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimension.padding.vertical.medium),
              Text(
                "Please select the appropriate industry, category, and sub-category for your listing.  This will help us to better understand your listing and to ensure that it is displayed correctly to potential customers.",
                style: context.text.labelSmall?.copyWith(
                  color: theme.textSecondary.withAlpha(200),
                  fontWeight: FontWeight.normal,
                  height: 1.15,
                ),
              ),
              SizedBox(height: Dimension.padding.vertical.ultraMax),
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      baseline: TextBaseline.ideographic,
                      child: Text(
                        "Industry",
                        style: context.text.bodyLarge?.copyWith(
                          color: theme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.medium)),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      baseline: TextBaseline.ideographic,
                      child: Icon(Icons.emergency_rounded, size: Dimension.radius.twelve, color: theme.negative),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimension.padding.vertical.small),
              IndustryField(
                industry: industry,
                focusNode: industryFocusNode,
                onSelect: (selection) {
                  industry = selection;
                  category = null;
                  subCategory = null;
                  categoryFocusNode.requestFocus();
                  context.read<FindCategoriesByIndustryBloc>().add(FindCategoriesByIndustry(
                        industry: selection.identity,
                      ));
                  setState(() {});
                },
              ),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      baseline: TextBaseline.ideographic,
                      child: Text(
                        "Category",
                        style: context.text.bodyLarge?.copyWith(
                          color: theme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.medium)),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      baseline: TextBaseline.ideographic,
                      child: Text(
                        "optional",
                        style: context.text.bodyMedium?.copyWith(
                          color: theme.textSecondary.withAlpha(200),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              CategoryField(
                category: category,
                focusNode: categoryFocusNode,
                onSelect: (selection) {
                  category = selection;
                  subCategory = null;
                  context.read<SubCategoriesByCategoryBloc>().add(SubCategoriesByCategory(category: selection.identity.guid));
                  subCategoryFocusNode.requestFocus();
                  setState(() {});
                },
              ),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      baseline: TextBaseline.ideographic,
                      child: Text(
                        "Sub-Category",
                        style: context.text.bodyLarge?.copyWith(
                          color: theme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.medium)),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      baseline: TextBaseline.ideographic,
                      child: Text(
                        "optional",
                        style: context.text.bodyMedium?.copyWith(
                          color: theme.textSecondary.withAlpha(200),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SubCategoryField(
                subCategory: subCategory,
                focusNode: subCategoryFocusNode,
                onSelect: (selection) {
                  subCategory = selection;
                  subCategoryFocusNode.requestFocus();
                  setState(() {});
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (industry != null) {
                      if (widget.edit) {
                        widget.onUpdate(industry!, category, subCategory);
                      } else {
                        widget.onNext(industry!, category, subCategory);
                      }
                    }
                  }
                },
                child: Text(
                  'Next'.toUpperCase(),
                  style: context.text.titleMedium?.copyWith(
                    color: theme.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

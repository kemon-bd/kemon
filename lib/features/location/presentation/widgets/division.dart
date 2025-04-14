import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../location.dart';

class DivisionFilter extends StatefulWidget {
  final Identity industry;
  final Identity? category;
  final Identity? subCategory;
  final LocationEntity? selection;

  const DivisionFilter({
    super.key,
    required this.selection,
    required this.industry,
    this.category,
    this.subCategory,
  });

  @override
  State<DivisionFilter> createState() => _DivisionFilterState();
}

class _DivisionFilterState extends State<DivisionFilter> {
  final TextEditingController controller = TextEditingController();
  LocationEntity? division;

  @override
  void initState() {
    super.initState();
    division = widget.selection;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FindLocationsByCategoryBloc>()
        ..add(FindLocationsByCategory(
          industry: widget.industry,
          category: widget.category,
          subCategory: widget.subCategory,
        )),
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
                          "Division",
                          style: context.text.headlineSmall?.copyWith(
                            color: theme.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
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
                        themeContext.read<FindLocationsByCategoryBloc>().add(SearchLocationsByCategory(
                              query: value,
                              industry: widget.industry,
                              category: widget.category,
                              subCategory: widget.subCategory,
                            ));
                      },
                      style: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: theme.textPrimary,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.backgroundSecondary,
                        hintText: "Search division ...",
                        hintStyle: context.text.bodyMedium?.copyWith(
                          height: 1.0,
                          color: theme.textSecondary.withAlpha(200),
                          fontWeight: FontWeight.normal,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.clear();
                            themeContext.read<FindLocationsByCategoryBloc>().add(FindLocationsByCategory(
                                  industry: widget.industry,
                                  category: widget.category,
                                  subCategory: widget.subCategory,
                                ));
                          },
                          child: Icon(
                            Icons.cancel_rounded,
                            color: theme.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<FindLocationsByCategoryBloc, FindLocationsByCategoryState>(
                      builder: (builderContext, state) {
                        if (state is FindLocationsByCategoryDone) {
                          final divisions = state.divisions;

                          return PhysicalModel(
                            color: theme.backgroundSecondary,
                            borderRadius: BorderRadius.circular(16),
                            child: divisions.isNotEmpty
                                ? Container(
                                    constraints: BoxConstraints(
                                      maxHeight: context.height * .5,
                                    ),
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Divider(height: .25, color: theme.backgroundTertiary),
                                      itemBuilder: (context, index) {
                                        final item = divisions[index];
                                        final bool selected = item.name.full.same(as: division?.name.full);
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
                                                  color: selected ? theme.primary : theme.textPrimary,
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
                                                          alignment: PlaceholderAlignment.middle,
                                                          baseline: TextBaseline.ideographic,
                                                          child: Text(
                                                            item.name.full,
                                                            style: context.text.bodyLarge?.copyWith(
                                                              height: 1.0,
                                                              color: selected ? theme.primary : theme.textPrimary,
                                                              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                                                            ),
                                                          ),
                                                        ),
                                                        WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.small)),
                                                        WidgetSpan(
                                                          alignment: PlaceholderAlignment.middle,
                                                          baseline: TextBaseline.ideographic,
                                                          child: Text(
                                                            "(${item.count})",
                                                            style: context.text.bodySmall?.copyWith(
                                                              height: 1.0,
                                                              color: selected ? theme.primary : theme.textPrimary,
                                                              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
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
                                      itemCount: divisions.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero.copyWith(top: 8, bottom: 8),
                                      physics: const ScrollPhysics(),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "No division found",
                                      style: context.text.bodyMedium?.copyWith(
                                        height: 1.0,
                                        color: theme.textPrimary,
                                        fontWeight: FontWeight.normal,
                                      ),
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

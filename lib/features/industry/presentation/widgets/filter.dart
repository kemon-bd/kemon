import '../../../../../../core/shared/shared.dart';
import '../../../../../core/config/config.dart';
import '../../industry.dart';

class IndustryFilter extends StatefulWidget {
  final String division;
  final String? district;
  final String? thana;
  final IndustryEntity? selection;

  const IndustryFilter({
    super.key,
    required this.selection,
    required this.division,
    this.district,
    this.thana,
  });

  @override
  State<IndustryFilter> createState() => _IndustryFilterState();
}

class _IndustryFilterState extends State<IndustryFilter> {
  final TextEditingController controller = TextEditingController();
  IndustryEntity? category;

  @override
  void initState() {
    super.initState();
    category = widget.selection;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FindIndustriesByLocationBloc>()
        ..add(FindIndustriesByLocation(
          division: widget.division,
          district: widget.district,
          thana: widget.thana,
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
                          "Industry",
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
                        themeContext.read<FindIndustriesByLocationBloc>().add(SearchIndustriesByLocation(
                              query: value,
                              division: widget.division,
                              district: widget.district,
                              thana: widget.thana,
                            ));
                      },
                      style: TextStyles.body(context: themeContext, color: theme.textPrimary),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.backgroundSecondary,
                        hintText: "Search industry ...",
                        hintStyle: TextStyles.body(context: themeContext, color: theme.textSecondary),
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.clear();
                            themeContext
                                .read<FindIndustriesByLocationBloc>()
                                .add(FindIndustriesByLocation(division: widget.division));
                          },
                          child: Icon(
                            Icons.cancel_rounded,
                            color: theme.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<FindIndustriesByLocationBloc, FindIndustriesByLocationState>(
                      builder: (builderContext, state) {
                        if (state is FindIndustriesByLocationDone) {
                          final industries = state.industries;

                          return PhysicalModel(
                            color: theme.backgroundSecondary,
                            borderRadius: BorderRadius.circular(16),
                            child: industries.isNotEmpty
                                ? Container(
                                    constraints: BoxConstraints(
                                      maxHeight: context.height * .5,
                                    ),
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Divider(height: .25, color: theme.backgroundTertiary),
                                      itemBuilder: (context, index) {
                                        final item = industries[index];
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
                                                  child: Text.rich(
                                                    TextSpan(
                                                      text: '',
                                                      children: [
                                                        WidgetSpan(
                                                          alignment: PlaceholderAlignment.aboveBaseline,
                                                          baseline: TextBaseline.ideographic,
                                                          child: Text(
                                                            item.name.full,
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
                                                            "(${item.listings})",
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
                                      itemCount: industries.length,
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

import '../../../../../core/shared/shared.dart';
import '../../location.dart';

class ThanaFilter extends StatefulWidget {
  final List<ThanaWithListingCountEntity> thanas;
  final LocationEntity? selection;

  const ThanaFilter({
    super.key,
    required this.thanas,
    required this.selection,
  });

  @override
  State<ThanaFilter> createState() => _ThanaFilterState();
}

class _ThanaFilterState extends State<ThanaFilter> {
  final TextEditingController controller = TextEditingController();
  LocationEntity? selection;
  late List<ThanaWithListingCountEntity> thanas;

  @override
  void initState() {
    super.initState();
    selection = widget.selection;
    thanas = widget.thanas;
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
                          "Thana",
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
                          thanas = widget.thanas;
                          setState(() {});
                        } else {
                          thanas = widget.thanas
                              .where(
                                (element) => element.name.full.match(like: value),
                              )
                              .toList();
                          setState(() {});
                        }
                      },
                      style: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: theme.textPrimary,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.backgroundSecondary,
                        hintText: "Search thana ...",
                        hintStyle: context.text.bodyMedium?.copyWith(
                          height: 1.0,
                          color: theme.textSecondary,
                          fontWeight: FontWeight.normal,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.clear();
                            thanas = widget.thanas;
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
                      child: thanas.isNotEmpty
                          ? Container(
                              constraints: BoxConstraints(maxHeight: context.height * .5),
                              child: ListView.separated(
                                separatorBuilder: (context, index) => Divider(height: .25, color: theme.backgroundTertiary),
                                itemBuilder: (context, index) {
                                  final item = thanas[index];
                                  final bool selected = item.name.full.same(as: selection?.name.full);

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
                                itemCount: thanas.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero.copyWith(top: 8, bottom: 8),
                                physics: const ScrollPhysics(),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "No thana found",
                                style: context.text.bodyMedium?.copyWith(
                                  height: 1.0,
                                  color: theme.textSecondary,
                                  fontWeight: FontWeight.normal,
                                ),
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

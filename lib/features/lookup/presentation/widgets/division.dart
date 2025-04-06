import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class DivisionField extends StatefulWidget {
  final LookupEntity? division;
  final FocusNode? focusNode;
  final Function(LookupEntity division) onSelect;
  const DivisionField({
    super.key,
    required this.division,
    required this.onSelect,
    this.focusNode,
  });

  @override
  State<DivisionField> createState() => _DivisionFieldState();
}

class _DivisionFieldState extends State<DivisionField> {
  LookupEntity? division;

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final SuggestionsController<LookupEntity> suggestionBoxController = SuggestionsController<LookupEntity>();

  @override
  void initState() {
    super.initState();
    division = widget.division;
    suggestionBoxController.refresh();
    controller.text = division?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final dark = state.mode == ThemeMode.dark;

        return BlocBuilder<DivisionsBloc, DivisionsState>(
          builder: (context, state) {
            if (state is DivisionsDone) {
              final divisions = state.divisions.toList();
              return TypeAheadField<LookupEntity>(
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
                    division = suggestion;
                    controller.text = suggestion.text;
                    suggestionBoxController.close();
                    widget.onSelect(suggestion);
                  });
                },
                suggestionsCallback: (pattern) async {
                  if (pattern.isEmpty) {
                    return divisions;
                  }
                  return divisions.where((d) => d.text.match(like: pattern)).toList();
                },
                itemBuilder: (context, suggestion) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          suggestion.text,
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
            } else if (state is DivisionsLoading) {
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
                hintText: "Select one.",
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
  void didUpdateWidget(covariant DivisionField oldWidget) {
    super.didUpdateWidget(oldWidget);
    division = widget.division;
    controller.text = division?.text ?? '';
  }
}

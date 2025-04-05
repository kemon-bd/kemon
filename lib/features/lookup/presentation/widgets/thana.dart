import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class ThanaField extends StatefulWidget {
  final LookupEntity? thana;
  final FocusNode? focusNode;
  final Function(LookupEntity district) onSelect;
  const ThanaField({
    super.key,
    required this.thana,
    required this.onSelect,
    this.focusNode,
  });

  @override
  State<ThanaField> createState() => _ThanaFieldState();
}

class _ThanaFieldState extends State<ThanaField> {
  LookupEntity? thana;

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final SuggestionsController<LookupEntity> suggestionBoxController = SuggestionsController<LookupEntity>();

  @override
  void initState() {
    super.initState();
    thana = widget.thana;
    suggestionBoxController.refresh();
    controller.text = thana?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;

        return BlocConsumer<ThanasBloc, ThanasState>(
          listener: (context, state) {
            if (state is ThanasDone) {
              setState(() {
                suggestionBoxController.refresh();
              });
            }
          },
          builder: (context, state) {
            if (state is ThanasDone) {
              final thanas = state.thanas.toList();
              return TypeAheadField<LookupEntity>(
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
                    thana = suggestion;
                    controller.text = suggestion.text;
                    suggestionBoxController.close();
                    widget.onSelect(suggestion);
                  });
                },
                suggestionsCallback: (pattern) async {
                  if (pattern.isEmpty) {
                    return thanas;
                  }
                  return thanas.where((t) => t.text.match(like: pattern)).toList();
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
            } else if (state is ThanasLoading) {
              return TextField(
                enabled: false,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Loading...",
                  hintStyle: TextStyles.subTitle(context: context, color: theme.textSecondary),
                  isDense: true,
                ),
              );
            }
            return TextField(
              enabled: false,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Select a district first.",
                hintStyle: TextStyles.subTitle(context: context, color: theme.textSecondary),
                isDense: true,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant ThanaField oldWidget) {
    super.didUpdateWidget(oldWidget);
    thana = widget.thana;
    controller.text = thana?.text ?? '';
  }
}

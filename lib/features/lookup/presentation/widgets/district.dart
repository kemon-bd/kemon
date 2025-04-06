import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class DistrictField extends StatefulWidget {
  final LookupEntity? district;
  final FocusNode? focusNode;
  final Function(LookupEntity district) onSelect;
  const DistrictField({
    super.key,
    required this.district,
    required this.onSelect,
    this.focusNode,
  });

  @override
  State<DistrictField> createState() => _DistrictFieldState();
}

class _DistrictFieldState extends State<DistrictField> {
  LookupEntity? district;

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final SuggestionsController<LookupEntity> suggestionBoxController = SuggestionsController<LookupEntity>();

  @override
  void initState() {
    super.initState();
    district = widget.district;
    suggestionBoxController.refresh();
    controller.text = district?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final dark = state.mode == ThemeMode.dark;

        return BlocConsumer<DistrictsBloc, DistrictsState>(
          listener: (context, state) {
            if (state is DistrictsDone) {
              setState(() {
                suggestionBoxController.refresh();
              });
            }
          },
          builder: (context, state) {
            if (state is DistrictsDone) {
              final districts = state.districts.toList();
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
                    district = suggestion;
                    controller.text = suggestion.text;
                    suggestionBoxController.close();
                    widget.onSelect(suggestion);
                  });
                },
                suggestionsCallback: (pattern) async {
                  if (pattern.isEmpty) {
                    return districts;
                  }
                  return districts.where((d) => d.text.match(like: pattern)).toList();
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
            } else if (state is DistrictsLoading) {
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
                hintText: "Select a division first.",
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
  void didUpdateWidget(covariant DistrictField oldWidget) {
    super.didUpdateWidget(oldWidget);
    district = widget.district;
    controller.text = district?.text ?? '';
  }
}

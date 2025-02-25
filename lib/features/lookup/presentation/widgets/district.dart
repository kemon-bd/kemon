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
              final categories = state.districts.toList();
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
                    district = suggestion;
                    controller.text = suggestion.text;
                    suggestionBoxController.close();
                    widget.onSelect(suggestion);
                  });
                },
                suggestionsCallback: (pattern) async {
                  if (pattern.isEmpty) {
                    return categories;
                  }
                  return categories
                      .where(
                        (category) => district?.text.match(like: pattern) ?? false,
                      )
                      .toList();
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
            } else if (state is DistrictsLoading) {
              return TextField(
                enabled: false,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Loading...",
                  isDense: true,
                ),
              );
            }
            return TextField(
              enabled: false,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Select a division first.",
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

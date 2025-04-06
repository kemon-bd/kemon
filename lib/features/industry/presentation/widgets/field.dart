import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class IndustryField extends StatefulWidget {
  final IndustryEntity? industry;
  final FocusNode? focusNode;
  final Function(IndustryEntity industry) onSelect;
  const IndustryField({
    super.key,
    required this.industry,
    required this.onSelect,
    this.focusNode,
  });

  @override
  State<IndustryField> createState() => _IndustryFieldState();
}

class _IndustryFieldState extends State<IndustryField> {
  IndustryEntity? industry;

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final SuggestionsController<IndustryEntity> suggestionBoxController = SuggestionsController<IndustryEntity>();

  @override
  void initState() {
    super.initState();
    industry = widget.industry;
    controller.text = industry?.name.full ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final dark = state.mode == ThemeMode.dark;

        return BlocBuilder<FindIndustriesBloc, FindIndustriesState>(
          builder: (context, state) {
            if (state is FindIndustriesDone) {
              final industries = state.industries;
              return TypeAheadField<IndustryEntity>(
                controller: controller,
                suggestionsController: suggestionBoxController,
                showOnFocus: true,
                builder: (context, controller, focusNode) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    autofocus: true,
                    style: context.text.bodyMedium?.copyWith(
                      color: theme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    validator: (value) => industry != null ? null : '',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  );
                },
                hideOnEmpty: true,
                onSelected: (suggestion) {
                  setState(() {
                    industry = suggestion;
                    controller.text = suggestion.name.full;
                    suggestionBoxController.close();
                    widget.onSelect(suggestion);
                  });
                },
                suggestionsCallback: (pattern) async {
                  if (pattern.isEmpty) {
                    return industries;
                  }
                  return industries
                      .where((industry) => industry.name.full.toLowerCase().contains(pattern.toLowerCase()))
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
                          suggestion.name.full,
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
            } else if (state is FindIndustriesLoading) {
              return TextField(
                enabled: false,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Loading...",
                  isDense: true,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: theme.backgroundTertiary, width: 1),
                  ),
                ),
              );
            }
            return Container();
          },
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant IndustryField oldWidget) {
    super.didUpdateWidget(oldWidget);
    industry = widget.industry;
    controller.text = industry?.name.full ?? '';
  }
}

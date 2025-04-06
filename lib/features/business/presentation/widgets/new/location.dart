import '../../../../../core/shared/shared.dart';
import '../../../../lookup/lookup.dart';

class NewListingLocationWidget extends StatefulWidget {
  final bool edit;
  final Function(LookupEntity?, LookupEntity?, LookupEntity?) onUpdate;
  final Function(LookupEntity?, LookupEntity?, LookupEntity?) onNext;
  final TextEditingController address;
  final LookupEntity? thana;
  final LookupEntity? district;
  final LookupEntity? division;

  const NewListingLocationWidget({
    super.key,
    this.edit = false,
    required this.onUpdate,
    required this.onNext,
    required this.address,
    required this.thana,
    required this.district,
    required this.division,
  });

  @override
  State<NewListingLocationWidget> createState() => _NewListingLocationWidgetState();
}

class _NewListingLocationWidgetState extends State<NewListingLocationWidget> {
  final FocusNode divisionFocusNode = FocusNode();
  LookupEntity? division;

  final FocusNode districtFocusNode = FocusNode();
  LookupEntity? district;

  final FocusNode thanaFocusNode = FocusNode();
  LookupEntity? thana;

  final FocusNode addressFocusNode = FocusNode();
  late final TextEditingController address;

  @override
  void initState() {
    super.initState();
    address = widget.address;
    thana = widget.thana;
    district = widget.district;
    division = widget.division;
    if (!widget.edit) {
      addressFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return ListView(
          padding: const EdgeInsets.all(16).copyWith(bottom: context.bottomInset + 16),
          children: [
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    baseline: TextBaseline.ideographic,
                    child: Text(
                      "Enter Location",
                      style: context.text.headlineSmall?.copyWith(
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
            SizedBox(height: Dimension.padding.vertical.medium),
            Text(
              "Providing an accurate location helps pinpoint where the listing is based, ensuring it’s easily discoverable and accessible to the right audience.",
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
                      "Address",
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
            SizedBox(height: Dimension.padding.vertical.medium),
            TextField(
              controller: address,
              autofocus: true,
              autocorrect: false,
              focusNode: addressFocusNode,
              style: context.text.bodyMedium?.copyWith(
                color: theme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'House No, Road No, etc',
                hintStyle: context.text.bodyMedium?.copyWith(
                  color: theme.textSecondary.withAlpha(200),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onEditingComplete: () {
                divisionFocusNode.requestFocus();
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
                      "Division",
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
            SizedBox(height: Dimension.padding.vertical.medium),
            DivisionField(
              division: division,
              focusNode: divisionFocusNode,
              onSelect: (selection) {
                division = selection;
                context.read<DistrictsBloc>().add(FindDistricts(division: selection.value));
                district = null;
                thana = null;
                districtFocusNode.requestFocus();
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
                      "District",
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
            SizedBox(height: Dimension.padding.vertical.medium),
            DistrictField(
              district: district,
              focusNode: districtFocusNode,
              onSelect: (selection) {
                district = selection;
                context.read<ThanasBloc>().add(FindThanas(district: selection.value));
                thana = null;
                thanaFocusNode.requestFocus();
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
                      "Thana",
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
            SizedBox(height: Dimension.padding.vertical.medium),
            ThanaField(
              thana: thana,
              focusNode: districtFocusNode,
              onSelect: (selection) {
                thana = selection;
                setState(() {});
              },
            ),
            SizedBox(height: Dimension.padding.vertical.ultraProMax),
            TextButton(
              onPressed: () {
                if (widget.edit) {
                  widget.onUpdate(thana, district, division);
                } else {
                  widget.onNext(thana, district, division);
                }
              },
              child: Text(
                'SKIP'.toUpperCase(),
                style: context.text.titleMedium?.copyWith(
                  color: theme.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: Dimension.padding.vertical.ultraMax),
            ElevatedButton(
              onPressed: () {
                if (widget.edit) {
                  widget.onUpdate(thana, district, division);
                } else {
                  widget.onNext(thana, district, division);
                }
              },
              child: Text(
                'Next'.toUpperCase(),
                style: context.text.titleMedium?.copyWith(
                  color: theme.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

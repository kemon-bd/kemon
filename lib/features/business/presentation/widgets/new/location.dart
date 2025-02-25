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
                  TextSpan(
                    text: "Enter Location",
                    style: TextStyles.title(context: context, color: theme.textPrimary),
                  ),
                  WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.large)),
                  WidgetSpan(
                    baseline: TextBaseline.ideographic,
                    alignment: PlaceholderAlignment.aboveBaseline,
                    child: Text(
                      "optional",
                      style: TextStyles.body(context: context, color: theme.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Providing an accurate location helps pinpoint where the listing is based, ensuring it’s easily discoverable and accessible to the right audience.",
              style: TextStyles.body(context: context, color: theme.textSecondary),
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Address",
                    style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                  ),
                  const WidgetSpan(child: SizedBox(width: 8)),
                  WidgetSpan(
                    baseline: TextBaseline.ideographic,
                    alignment: PlaceholderAlignment.aboveBaseline,
                    child: Text(
                      "optional",
                      style: TextStyles.body(context: context, color: theme.textSecondary),
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
              style: TextStyles.subTitle(context: context, color: theme.textPrimary),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'House No, Road No, etc',
                hintStyle: TextStyles.subTitle(context: context, color: theme.textSecondary),
              ),
              onEditingComplete: () {
                divisionFocusNode.requestFocus();
              },
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Division",
                    style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                  ),
                  WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.large)),
                  WidgetSpan(
                    baseline: TextBaseline.ideographic,
                    alignment: PlaceholderAlignment.aboveBaseline,
                    child: Text(
                      "optional",
                      style: TextStyles.body(context: context, color: theme.textSecondary),
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
                  TextSpan(
                    text: "District",
                    style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                  ),
                  WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.large)),
                  WidgetSpan(
                    baseline: TextBaseline.ideographic,
                    alignment: PlaceholderAlignment.aboveBaseline,
                    child: Text(
                      "optional",
                      style: TextStyles.body(context: context, color: theme.textSecondary),
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
                  TextSpan(
                    text: "Thana",
                    style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                  ),
                  WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.large)),
                  WidgetSpan(
                    baseline: TextBaseline.ideographic,
                    alignment: PlaceholderAlignment.aboveBaseline,
                    child: Text(
                      "optional",
                      style: TextStyles.body(context: context, color: theme.textSecondary),
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
                'Skip',
                style: TextStyles.button(context: context).copyWith(color: theme.textPrimary),
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
                'Next',
                style: TextStyles.button(context: context),
              ),
            ),
          ],
        );
      },
    );
  }
}

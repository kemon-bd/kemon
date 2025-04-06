import '../../../../../core/shared/shared.dart';

class NewListingTypeWidget extends StatefulWidget {
  final TextEditingController name;
  final ListingType? type;
  final Function(ListingType) onNext;
  final Function(ListingType) onUpdate;
  final bool edit;

  const NewListingTypeWidget({
    super.key,
    required this.onNext,
    required this.onUpdate,
    required this.name,
    required this.type,
    this.edit = false,
  });

  @override
  State<NewListingTypeWidget> createState() => _NewListingTypeWidgetState();
}

class _NewListingTypeWidgetState extends State<NewListingTypeWidget> {
  ListingType? type;

  @override
  void initState() {
    super.initState();
    type = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return ListView(
          padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(bottom: context.bottomInset + Dimension.radius.sixteen),
          children: [
            SizedBox(height: Dimension.padding.vertical.ultraMax),
            Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    baseline: TextBaseline.ideographic,
                    child: Text(
                      widget.name.text,
                      style: context.text.headlineSmall?.copyWith(
                        color: theme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.medium)),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    baseline: TextBaseline.ideographic,
                    child: Text(
                      "is best known as",
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
                    child: Icon(Icons.emergency_rounded, size: Dimension.radius.sixteen, color: theme.negative),
                  ),
                ],
              ),
            ),
            Text(
              "How would you describe your listing as, we currently accept the following types",
              style: context.text.labelSmall?.copyWith(
                color: theme.textSecondary.withAlpha(200),
                fontWeight: FontWeight.normal,
                height: 1.15,
              ),
            ),
            SizedBox(height: 2 * Dimension.padding.vertical.ultraProMax),
            Row(
              spacing: Dimension.padding.horizontal.ultraMax,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        type = ListingType.product;
                      });
                    },
                    borderRadius: BorderRadius.circular(Dimension.radius.twentyFour),
                    child: PhysicalModel(
                      color: type == ListingType.product ? theme.primary : theme.backgroundSecondary,
                      borderRadius: BorderRadius.circular(Dimension.radius.twentyFour),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: Dimension.size.vertical.sixtyFour),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                type == ListingType.product ? Icons.inventory_2_rounded : Icons.inventory_2_outlined,
                                size: Dimension.radius.twentyFour,
                                color: type == ListingType.product ? theme.backgroundPrimary : theme.primary,
                              ),
                              SizedBox(width: Dimension.padding.horizontal.large),
                              Text(
                                "Product",
                                style: context.text.titleLarge?.copyWith(
                                  color: type == ListingType.product ? theme.backgroundPrimary : theme.primary,
                                  fontWeight: FontWeight.bold,
                                  height: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        type = ListingType.business;
                      });
                    },
                    borderRadius: BorderRadius.circular(Dimension.radius.twentyFour),
                    child: PhysicalModel(
                      color: type == ListingType.business ? theme.primary : theme.backgroundSecondary,
                      borderRadius: BorderRadius.circular(Dimension.radius.twentyFour),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: Dimension.size.vertical.sixtyFour),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                type == ListingType.business ? Icons.maps_home_work_rounded : Icons.maps_home_work_outlined,
                                size: Dimension.radius.twentyFour,
                                color: type == ListingType.business ? theme.backgroundPrimary : theme.primary,
                              ),
                              SizedBox(width: Dimension.padding.horizontal.large),
                              Text(
                                "Business",
                                style: context.text.titleLarge?.copyWith(
                                  color: type == ListingType.business ? theme.backgroundPrimary : theme.primary,
                                  fontWeight: FontWeight.bold,
                                  height: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimension.padding.vertical.ultraProMax),
            SizedBox(height: Dimension.padding.vertical.ultraProMax),
            ElevatedButton(
              onPressed: type != null
                  ? () {
                      context.dismissKeyboard();
                      if (type != null) {
                        if (widget.edit) {
                          widget.onUpdate(type!);
                        } else {
                          widget.onNext(type!);
                        }
                      }
                    }
                  : null,
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

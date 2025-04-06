import '../../../../../core/shared/shared.dart';

class NewListingLogoWidget extends StatefulWidget {
  final Function(XFile?) onNext;
  final XFile? logo;
  final Function(XFile?) onUpdate;
  final bool edit;

  const NewListingLogoWidget({
    super.key,
    required this.onNext,
    required this.logo,
    required this.onUpdate,
    this.edit = false,
  });

  @override
  State<NewListingLogoWidget> createState() => _NewListingLogoWidgetState();
}

class _NewListingLogoWidgetState extends State<NewListingLogoWidget> {
  XFile? logo;

  @override
  void initState() {
    super.initState();
    logo = widget.logo;
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
                      "Do you have a logo",
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
            SizedBox(height: Dimension.padding.vertical.medium),
            Text(
              "A logo also adds a professional touch to your listing, making it more trustworthy and appealing.",
              style: context.text.labelSmall?.copyWith(
                color: theme.textSecondary.withAlpha(200),
                fontWeight: FontWeight.normal,
                height: 1.15,
              ),
            ),
            SizedBox(height: Dimension.padding.vertical.ultraProMax),
            SizedBox(height: Dimension.padding.vertical.ultraProMax),
            SizedBox(height: Dimension.padding.vertical.ultraProMax),
            Center(
              child: InkWell(
                onTap: () async {
                  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      logo = image;
                    });
                  }
                },
                borderRadius: BorderRadius.circular(Dimension.radius.twoFiftySix),
                child: Container(
                  width: Dimension.radius.twoFiftySix,
                  height: Dimension.radius.twoFiftySix,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: theme.backgroundSecondary,
                    borderRadius: BorderRadius.circular(Dimension.radius.twoFiftySix),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: logo != null
                        ? Image.file(
                            File(logo!.path),
                            width: Dimension.radius.twoFiftySix,
                            height: Dimension.radius.twoFiftySix,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.camera_alt_rounded,
                            size: Dimension.radius.oneFortyFour,
                            color: theme.backgroundTertiary,
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimension.padding.vertical.ultraProMax),
            SizedBox(height: Dimension.padding.vertical.ultraProMax),
            ElevatedButton(
              onPressed: logo == null
                  ? null
                  : () {
                      if (widget.edit) {
                        widget.onUpdate(logo);
                      } else {
                        widget.onNext(logo);
                      }
                    },
              child: Text(
                'Next'.toUpperCase(),
                style: context.text.titleMedium?.copyWith(
                  color: logo == null ? theme.textSecondary : theme.white,
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

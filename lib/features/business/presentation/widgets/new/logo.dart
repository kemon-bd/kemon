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
                  TextSpan(
                    text: "Do you have a logo",
                    style: TextStyles.title(context: context, color: theme.textPrimary),
                  ),
                  WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.large)),
                  WidgetSpan(
                    baseline: TextBaseline.alphabetic,
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
              "A logo also adds a professional touch to your listing, making it more trustworthy and appealing.",
              style: TextStyles.body(context: context, color: theme.textSecondary),
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
            TextButton(
              onPressed: () {
                if (widget.edit) {
                  widget.onUpdate(logo);
                } else {
                  widget.onNext(logo);
                }
              },
              child: Text(
                'Skip',
                style: TextStyles.button(context: context).copyWith(color: theme.textPrimary),
              ),
            ),
            SizedBox(height: Dimension.padding.vertical.max),
            ElevatedButton(
              onPressed: () {
                if (widget.edit) {
                  widget.onUpdate(logo);
                } else {
                  widget.onNext(logo);
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

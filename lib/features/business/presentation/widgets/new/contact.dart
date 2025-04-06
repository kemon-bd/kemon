import '../../../../../core/shared/shared.dart';

class NewListingContactWidget extends StatefulWidget {
  final bool edit;
  final VoidCallback onUpdate;
  final VoidCallback onNext;
  final TextEditingController name;
  final TextEditingController website;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController social;

  const NewListingContactWidget({
    super.key,
    this.edit = false,
    required this.onUpdate,
    required this.onNext,
    required this.name,
    required this.website,
    required this.email,
    required this.phone,
    required this.social,
  });

  @override
  State<NewListingContactWidget> createState() => _NewListingContactWidgetState();
}

class _NewListingContactWidgetState extends State<NewListingContactWidget> {
  final FocusNode phoneFocusNode = FocusNode();
  late final TextEditingController phone;

  final FocusNode emailFocusNode = FocusNode();
  late final TextEditingController email;

  final FocusNode websiteFocusNode = FocusNode();
  late final TextEditingController website;

  final FocusNode socialFocusNode = FocusNode();
  late final TextEditingController social;

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
    email = widget.email;
    website = widget.website;
    social = widget.social;
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
                    text: "How can others contact with ",
                    style: context.text.headlineSmall?.copyWith(
                      color: theme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: widget.name.text,
                    style: context.text.headlineSmall?.copyWith(
                      color: theme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " ?",
                    style: context.text.headlineSmall?.copyWith(
                      color: theme.textPrimary,
                      fontWeight: FontWeight.bold,
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
              "Providing a phone number, email address, website, or social network link ensures others can easily reach out to this listing when needed.",
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
                      "Phone",
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
              controller: phone,
              autofocus: true,
              autocorrect: false,
              focusNode: phoneFocusNode,
              style: context.text.bodyMedium?.copyWith(
                color: theme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '01XXXXXXXXX',
                hintStyle: context.text.bodyMedium?.copyWith(
                  color: theme.textSecondary.withAlpha(200),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onEditingComplete: () {
                emailFocusNode.requestFocus();
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
                      "Email",
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
              controller: email,
              autofocus: true,
              autocorrect: false,
              focusNode: emailFocusNode,
              style: context.text.bodyMedium?.copyWith(
                color: theme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'example@gmail.com',
                hintStyle: context.text.bodyMedium?.copyWith(
                  color: theme.textSecondary.withAlpha(200),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onEditingComplete: () {
                websiteFocusNode.requestFocus();
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
                      "Website",
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
              controller: website,
              autofocus: true,
              autocorrect: false,
              focusNode: websiteFocusNode,
              style: context.text.bodyMedium?.copyWith(
                color: theme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                hintText: 'domain.com',
                hintStyle: context.text.bodyMedium?.copyWith(
                  color: theme.textSecondary.withAlpha(200),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onEditingComplete: () {
                socialFocusNode.requestFocus();
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
                      "Social Network",
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
              controller: social,
              autofocus: true,
              autocorrect: false,
              focusNode: socialFocusNode,
              style: context.text.bodyMedium?.copyWith(
                color: theme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                hintText: 'e.g. instagram.com/username',
                hintStyle: context.text.bodyMedium?.copyWith(
                  color: theme.textSecondary.withAlpha(200),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onEditingComplete: () {
                if (widget.edit) {
                  widget.onUpdate();
                } else {
                  widget.onNext();
                }
              },
            ),
            const SizedBox(height: 24),
            SizedBox(height: Dimension.padding.vertical.ultraProMax),
            TextButton(
              onPressed: () {
                if (widget.edit) {
                  widget.onUpdate();
                } else {
                  widget.onNext();
                }
              },
              child: Text(
                'Skip'.toUpperCase(),
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
                  widget.onUpdate();
                } else {
                  widget.onNext();
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

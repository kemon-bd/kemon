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
                    style: TextStyles.title(context: context, color: theme.textPrimary),
                  ),
                  TextSpan(
                    text: widget.name.text,
                    style: TextStyles.title(context: context, color: theme.primary),
                  ),
                  TextSpan(
                    text: " ?",
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
              "Providing a phone number, email address, website, or social network link ensures others can easily reach out to this listing when needed.",
              style: TextStyles.body(context: context, color: theme.textSecondary),
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Phone",
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
              controller: phone,
              autofocus: true,
              autocorrect: false,
              focusNode: phoneFocusNode,
              style: TextStyles.subTitle(context: context, color: theme.textPrimary),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '01XXXXXXXXX',
                hintStyle: TextStyles.subTitle(context: context, color: theme.textSecondary),
              ),
              onEditingComplete: () {
                emailFocusNode.requestFocus();
              },
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Email",
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
              controller: email,
              autofocus: true,
              autocorrect: false,
              focusNode: emailFocusNode,
              style: TextStyles.subTitle(context: context, color: theme.textPrimary),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'example@gmail.com',
                hintStyle: TextStyles.subTitle(context: context, color: theme.textSecondary),
              ),
              onEditingComplete: () {
                websiteFocusNode.requestFocus();
              },
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Website",
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
              controller: website,
              autofocus: true,
              autocorrect: false,
              focusNode: websiteFocusNode,
              style: TextStyles.subTitle(context: context, color: theme.textPrimary),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                hintText: 'domain.com',
                hintStyle: TextStyles.subTitle(context: context, color: theme.textSecondary),
              ),
              onEditingComplete: () {
                socialFocusNode.requestFocus();
              },
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Social Network",
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
              controller: social,
              autofocus: true,
              autocorrect: false,
              focusNode: socialFocusNode,
              style: TextStyles.subTitle(context: context, color: theme.textPrimary),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                hintText: 'e.g. instagram.com/username',
                hintStyle: TextStyles.subTitle(context: context, color: theme.textSecondary),
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
                'Skip',
                style: TextStyles.button(context: context).copyWith(color: theme.textPrimary),
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

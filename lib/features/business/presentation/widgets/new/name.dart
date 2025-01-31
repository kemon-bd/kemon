import '../../../../../core/shared/shared.dart';
import '../../../business.dart';

class NewListingNameWidget extends StatefulWidget {
  final TextEditingController name;
  final TextEditingController urlSlug;
  final TextEditingController about;
  final VoidCallback onNext;
  final VoidCallback onUpdate;
  final bool edit;

  const NewListingNameWidget({
    super.key,
    required this.onNext,
    required this.onUpdate,
    required this.name,
    required this.urlSlug,
    required this.about,
    this.edit = false,
  });

  @override
  State<NewListingNameWidget> createState() => _NewListingNameWidgetState();
}

class _NewListingNameWidgetState extends State<NewListingNameWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController name, about, urlSlug;
  final FocusNode urlSlugFocusNode = FocusNode();
  final FocusNode aboutFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    name = widget.name;
    about = widget.about;
    urlSlug = widget.urlSlug;
    if (urlSlug.text.isEmpty && name.text.isNotEmpty) {
      urlSlug.text = name.text.paramCase;
      context.read<ValidateUrlSlugBloc>().add(ValidateUrlSlug(urlSlug: urlSlug.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(Dimension.radius.sixteen).copyWith(bottom: context.bottomInset + Dimension.radius.sixteen),
            children: [
              SizedBox(height: Dimension.padding.vertical.ultraMax),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Enter listing name",
                      style: TextStyles.title(context: context, color: theme.textPrimary),
                    ),
                    WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.large)),
                    WidgetSpan(
                      baseline: TextBaseline.alphabetic,
                      alignment: PlaceholderAlignment.aboveBaseline,
                      child: Icon(Icons.emergency_rounded, size: Dimension.radius.sixteen, color: theme.negative),
                    ),
                  ],
                ),
              ),
              Text(
                "The name you provide will help others recognize this listing and make it easier to search for and engage with.",
                style: TextStyles.body(context: context, color: theme.textSecondary),
              ),
              SizedBox(height: Dimension.padding.vertical.medium),
              TextFormField(
                controller: name,
                autofocus: true,
                autocorrect: false,
                style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value ?? '').isNotEmpty ? null : 'required',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      urlSlug.text = value.paramCase;
                    });
                    context.read<ValidateUrlSlugBloc>().add(ValidateUrlSlug(urlSlug: urlSlug.text));
                  } else {
                    setState(() {
                      urlSlug.text = '';
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'required',
                  hintStyle: TextStyles.subTitle(context: context, color: theme.textSecondary),
                ),
                onEditingComplete: () {
                  urlSlugFocusNode.requestFocus();
                },
              ),
              SizedBox(height: Dimension.padding.vertical.ultraMax),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: name.text,
                      style: TextStyles.subTitle(context: context, color: theme.primary),
                    ),
                    TextSpan(
                      text: " can be found as",
                      style: TextStyles.subTitle(context: context, color: theme.textPrimary),
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
                "Leave it as is if you do not have any idea about a how url-slug works.",
                style: TextStyles.body(context: context, color: theme.textSecondary),
              ),
              SizedBox(height: Dimension.padding.vertical.medium),
              Container(
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: theme.backgroundSecondary,
                  borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
                ),
                child: Row(
                  children: [
                    SizedBox(width: Dimension.padding.horizontal.max),
                    Icon(Icons.language_rounded, size: Dimension.radius.sixteen, color: theme.textSecondary),
                    SizedBox(width: Dimension.padding.horizontal.large),
                    Text(
                      "/",
                      style: TextStyles.subTitle(context: context, color: theme.textSecondary),
                    ),
                    Expanded(
                      child: TextField(
                        controller: urlSlug,
                        autofocus: true,
                        autocorrect: false,
                        style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onEditingComplete: () {
                          aboutFocusNode.requestFocus();
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            context.read<ValidateUrlSlugBloc>().add(ValidateUrlSlug(urlSlug: urlSlug.text));
                          }
                        },
                      ),
                    ),
                    BlocBuilder<ValidateUrlSlugBloc, ValidateUrlSlugState>(
                      builder: (context, state) {
                        if (state is ValidateUrlSlugLoading) {
                          return NetworkingIndicator(dimension: 20, color: theme.primary);
                        } else if (state is ValidateUrlSlugDone) {
                          return Icon(Icons.check_circle_rounded, size: Dimension.radius.twentyFour, color: theme.positive);
                        } else if (state is ValidateUrlSlugError && state.failure is InvalidUrlSlugFailure) {
                          return Text(
                            "Already taken.",
                            style: TextStyles.caption(context: context, color: theme.negative),
                          );
                        }
                        return Container();
                      },
                    ),
                    SizedBox(width: Dimension.padding.horizontal.max),
                  ],
                ),
              ),
              SizedBox(height: Dimension.padding.vertical.ultraMax),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "About",
                      style: TextStyles.subTitle(context: context, color: theme.textPrimary),
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
              SizedBox(height: Dimension.padding.vertical.medium),
              TextField(
                controller: about,
                autofocus: true,
                autocorrect: false,
                focusNode: aboutFocusNode,
                style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'short description about your listing',
                  hintStyle: TextStyles.subTitle(context: context, color: theme.textSecondary),
                ),
                onEditingComplete: () {
                  context.dismissKeyboard();
                  if (_formKey.currentState!.validate()) {
                    if (widget.edit) {
                      widget.onUpdate();
                    } else {
                      widget.onNext();
                    }
                  }
                },
              ),
              SizedBox(height: Dimension.padding.vertical.ultraMax),
              ElevatedButton(
                onPressed: () {
                  context.dismissKeyboard();
                  if (_formKey.currentState!.validate()) {
                    if (widget.edit) {
                      widget.onUpdate();
                    } else {
                      widget.onNext();
                    }
                  }
                },
                child: Text(
                  "Next",
                  style: TextStyles.button(context: context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

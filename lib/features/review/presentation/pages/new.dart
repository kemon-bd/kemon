import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../home/home.dart';
import '../../review.dart';

class NewReviewPage extends StatefulWidget {
  static const String path = '/business/:urlSlug/new-review';
  static const String name = 'NewReviewPage';

  final String urlSlug;
  final double rating;

  const NewReviewPage({
    super.key,
    required this.urlSlug,
    required this.rating,
  });

  @override
  State<NewReviewPage> createState() => _NewReviewPageState();
}

class _NewReviewPageState extends State<NewReviewPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double rating = 0;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime date = DateTime.now();

  final List<XFile> attachments = [];

  @override
  void initState() {
    super.initState();
    rating = widget.rating;
    dateController.text = date.dMMMMyyyy;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return KeyboardDismissOnTap(
          child: Scaffold(
            backgroundColor: theme.backgroundPrimary,
            appBar: AppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: theme.backgroundPrimary,
              surfaceTintColor: theme.backgroundPrimary,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded, color: theme.textPrimary),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.goNamed(HomePage.name);
                  }
                },
              ),
              title: Text(
                rating.toInt() == 0 ? "Please rate your experience" : "${rating.toInt()} star review",
                style: context.text.headlineSmall?.copyWith(
                  color: theme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
            ),
            body: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(16).copyWith(bottom: context.bottomInset + 16),
                children: [
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: RatingBar.builder(
                      itemCount: 5,
                      maxRating: 5,
                      minRating: 0,
                      initialRating: rating,
                      itemBuilder: (_, index) => Icon(
                        Icons.star_sharp,
                        color: rating > 4
                            ? theme.primary
                            : rating > 3
                                ? theme.positive.withRed(100)
                                : rating > 2
                                    ? theme.warning.withGreen(200)
                                    : rating > 1
                                        ? theme.warning.withGreen(100)
                                        : theme.negative,
                      ),
                      itemSize: 64,
                      unratedColor: theme.backgroundTertiary,
                      onRatingUpdate: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                      glow: false,
                    ),
                  ),
                  if (rating > 0) ...[
                    const SizedBox(height: 42),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Review",
                            style: context.text.labelMedium?.copyWith(
                              color: theme.textSecondary,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.medium)),
                          WidgetSpan(
                            baseline: TextBaseline.ideographic,
                            alignment: PlaceholderAlignment.middle,
                            child:
                                Icon(Icons.emergency_rounded, color: theme.negative, size: context.text.labelSmall?.fontSize),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: descriptionController,
                      style: context.text.bodyMedium?.copyWith(
                        color: theme.textPrimary,
                        fontWeight: FontWeight.normal,
                      ),
                      minLines: 4,
                      maxLines: 20,
                      validator: (value) => value?.isNotEmpty ?? false ? null : '',
                      decoration: InputDecoration(
                        hintText: "share your experience...",
                        hintStyle: context.text.bodyMedium?.copyWith(
                          color: theme.textSecondary,
                          fontWeight: FontWeight.normal,
                          height: 1.0,
                        ),
                        helperText: '',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Summary",
                            style: context.text.labelMedium?.copyWith(
                              color: theme.textSecondary,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.medium)),
                          WidgetSpan(
                            baseline: TextBaseline.ideographic,
                            alignment: PlaceholderAlignment.middle,
                            child: Text(
                              "optional",
                              style: context.text.labelSmall?.copyWith(
                                color: theme.textSecondary.withAlpha(150),
                                fontWeight: FontWeight.normal,
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: titleController,
                      style: context.text.bodyMedium?.copyWith(
                        color: theme.textPrimary,
                        fontWeight: FontWeight.normal,
                        height: 1.0,
                      ),
                      decoration: InputDecoration(
                        hintText: "in a few words...",
                        hintStyle: context.text.bodyMedium?.copyWith(
                          color: theme.textSecondary,
                          fontWeight: FontWeight.normal,
                          height: 1.0,
                        ),
                        helperText: '',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Date of experience",
                            style: context.text.labelMedium?.copyWith(
                              color: theme.textSecondary,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.medium)),
                          WidgetSpan(
                            baseline: TextBaseline.ideographic,
                            alignment: PlaceholderAlignment.middle,
                            child: Text(
                              "optional",
                              style: context.text.labelSmall?.copyWith(
                                color: theme.textSecondary.withAlpha(150),
                                fontWeight: FontWeight.normal,
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: dateController,
                      style: context.text.bodyMedium?.copyWith(
                        color: theme.textPrimary,
                        fontWeight: FontWeight.normal,
                        height: 1.0,
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "optional",
                        hintStyle: context.text.bodyMedium?.copyWith(
                          color: theme.textSecondary,
                          fontWeight: FontWeight.normal,
                          height: 1.0,
                        ),
                      ),
                      onTap: () async {
                        final DateTime? selection = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          builder: (_, child) => Theme(
                            data: Theme.of(context).copyWith(
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(),
                              ),
                            ),
                            child: child!,
                          ),
                        );
                        if (selection != null) {
                          setState(() {
                            date = selection;
                            dateController.text = selection.dMMMMyyyy;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Photos",
                            style: context.text.labelMedium?.copyWith(
                              color: theme.textSecondary,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                          ),
                          WidgetSpan(child: SizedBox(width: Dimension.padding.horizontal.medium)),
                          WidgetSpan(
                            baseline: TextBaseline.ideographic,
                            alignment: PlaceholderAlignment.middle,
                            child: Text(
                              "optional",
                              style: context.text.labelSmall?.copyWith(
                                color: theme.textSecondary.withAlpha(150),
                                fontWeight: FontWeight.normal,
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.backgroundSecondary,
                        border: Border.all(color: theme.backgroundTertiary, width: .15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            separatorBuilder: (_, __) => Divider(thickness: .1, height: .1, color: theme.textSecondary),
                            itemBuilder: (_, index) {
                              final file = attachments[index];
                              return ListTile(
                                contentPadding: EdgeInsets.zero.copyWith(left: 12, right: 8),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(file.path),
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  file.path.split('/').last,
                                  style: context.text.bodyMedium?.copyWith(
                                    color: theme.textSecondary,
                                    fontWeight: FontWeight.normal,
                                    height: 1.0,
                                  ),
                                  maxLines: 1,
                                ),
                                onTap: () {
                                  showAdaptiveDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (_) => Center(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image.file(
                                          File(file.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                      icon: Icon(
                                        Icons.zoom_out_map_rounded,
                                        color: theme.textSecondary,
                                      ),
                                      onPressed: () {
                                        showAdaptiveDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (_) => Center(
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Image.file(
                                                File(file.path),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                      icon: Icon(
                                        Icons.delete_forever_rounded,
                                        color: theme.negative,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          attachments.removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: attachments.length,
                          ),
                          if (attachments.isNotEmpty) Divider(thickness: .1, height: .1, color: theme.textSecondary),
                          ListTile(
                            leading: Icon(
                              Icons.add_photo_alternate_outlined,
                              color: theme.textPrimary,
                            ),
                            title: Text(
                              "Add a photo",
                              style: context.text.bodyMedium?.copyWith(
                                color: theme.textPrimary,
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                              ),
                            ),
                            onTap: () async {
                              final image = await ImagePicker().pickMultiImage();
                              if (image.isNotEmpty) {
                                setState(() {
                                  attachments.addAll(image);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocConsumer<CreateReviewBloc, CreateReviewState>(
                      listener: (context, state) {
                        if (state is CreateReviewDone) {
                          context.pop(true);
                          showDialog(
                            context: context,
                            barrierColor: context.barrierColor,
                            builder: (_) => AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: theme.positive,
                                    size: 144,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Review added successfully!',
                                    style: TextStyles.body(context: context, color: theme.textPrimary),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (state is CreateReviewError) {
                          showDialog(
                            context: context,
                            barrierColor: context.barrierColor,
                            builder: (_) => AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    color: theme.negative,
                                    size: 144,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    state.failure.message,
                                    style: TextStyles.body(context: context, color: theme.textPrimary),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is CreateReviewLoading) {
                          return ElevatedButton(
                            onPressed: () {},
                            child: NetworkingIndicator(dimension: Dimension.radius.twentyFour, color: theme.white),
                          );
                        }
                        return BlocBuilder<FindBusinessBloc, FindBusinessState>(
                          builder: (context, state) {
                            if (state is FindBusinessDone) {
                              final identity = state.business.identity;
                              return ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ?? false) {
                                    context.read<CreateReviewBloc>().add(CreateReview(
                                          listing: identity,
                                          rating: rating,
                                          title: titleController.text,
                                          description: descriptionController.text,
                                          date: date.toIso8601String(),
                                          attachments: attachments,
                                        ));
                                  }
                                },
                                child: Text(
                                  "Submit".toUpperCase(),
                                  style: context.text.titleMedium?.copyWith(
                                    color: theme.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                      },
                    ),
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

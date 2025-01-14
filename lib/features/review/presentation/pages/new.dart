import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
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

  final List<XFile> attachments = [];

  @override
  void initState() {
    super.initState();
    rating = widget.rating;
    dateController.text = DateTime.now().dMMMMyyyy;
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
                onPressed: context.pop,
              ),
              title: Text(
                rating.toInt() == 0 ? "Please rate your experience" : "${rating.toInt()} star review",
                style: TextStyles.overline(context: context, color: theme.textPrimary).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
                        Icons.stars_rounded,
                        color: rating > 4
                            ? theme.positive
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
                    Text(
                      "Review *",
                      style: TextStyles.body(context: context, color: theme.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: descriptionController,
                      style: TextStyles.body(context: context, color: theme.textPrimary),
                      minLines: 4,
                      maxLines: 20,
                      validator: (value) => value?.isNotEmpty ?? false ? null : '',
                      decoration: InputDecoration(
                        hintText: "share your experience...",
                        hintStyle: TextStyles.body(context: context, color: theme.textSecondary),
                        helperText: '',
                      ),
                      onChanged: (review) {
                        final String firstSentence = review.split('.').first.trim();
                        if (titleController.text.isEmpty ||
                            firstSentence.toLowerCase().trim().startsWith(titleController.text.toLowerCase().trim())) {
                          setState(() {
                            titleController.text = firstSentence;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Title *",
                      style: TextStyles.body(context: context, color: theme.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: titleController,
                      style: TextStyles.body(context: context, color: theme.textPrimary),
                      validator: (value) => value?.isNotEmpty ?? false ? null : '',
                      decoration: InputDecoration(
                        hintText: "required",
                        hintStyle: TextStyles.body(context: context, color: theme.textSecondary),
                        helperText: '',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Date of experience",
                      style: TextStyles.body(context: context, color: theme.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: dateController,
                      style: TextStyles.body(context: context, color: theme.textPrimary),
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "optional",
                        hintStyle: TextStyles.body(context: context, color: theme.textSecondary),
                      ),
                      onTap: () async {
                        final DateTime? date = await showDatePicker(
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
                        if (date != null) {
                          setState(() {
                            dateController.text = date.dMMMMyyyy;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Photos",
                      style: TextStyles.body(context: context, color: theme.textSecondary),
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
                                  style: TextStyles.body(context: context, color: theme.textSecondary),
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
                              style: TextStyles.body(context: context, color: theme.textSecondary).copyWith(
                                color: theme.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () async {
                              final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  attachments.add(image);
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
                                          date: dateController.text,
                                          attachments: attachments,
                                        ));
                                  }
                                },
                                child: Text(
                                  "Submit".toUpperCase(),
                                  style: TextStyles.button(context: context),
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

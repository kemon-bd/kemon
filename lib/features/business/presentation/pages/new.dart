import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

class NewListingPage extends StatefulWidget {
  static const String path = "/new-listing";
  static const String name = "NewListingPage";
  final String? suggestion;

  const NewListingPage({
    super.key,
    this.suggestion,
  });

  @override
  State<NewListingPage> createState() => _NewListingPageState();
}

class _NewListingPageState extends State<NewListingPage> with TickerProviderStateMixin {
  bool editListing = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController urlSlug = TextEditingController();
  final TextEditingController about = TextEditingController();

  bool editType = false;
  ListingType? type;

  bool editLogo = false;
  XFile? logo;

  bool editLocation = false;
  final TextEditingController branch = TextEditingController();
  final TextEditingController building = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController additionalAddress = TextEditingController();
  LookupEntity? area;
  LookupEntity? thana;
  LookupEntity? district;
  LookupEntity? division;

  bool editCategory = false;
  IndustryEntity? industry;
  CategoryEntity? category;
  SubCategoryEntity? subCategory;

  bool editContact = false;
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController website = TextEditingController();
  final TextEditingController social = TextEditingController();

  bool editOther = false;
  final TextEditingController since = TextEditingController();
  final TextEditingController tradeLicense = TextEditingController();
  bool active = true;

  int index = 0;
  late final AnimationController progress;

  @override
  void initState() {
    super.initState();
    progress = AnimationController(
      vsync: this,
      duration: 3.seconds,
      animationBehavior: AnimationBehavior.normal,
    )..addListener(() {
        setState(() {});
      });
    name.text = widget.suggestion ?? '';
    progress.value = 0.15;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final dark = state.mode == ThemeMode.dark;
        return KeyboardDismissOnTap(
          child: Scaffold(
            backgroundColor: theme.backgroundPrimary,
            appBar: AppBar(
              backgroundColor: theme.backgroundPrimary,
              elevation: 0,
              leading: IconButton(
                onPressed: () async {
                  if (index == 0) {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (_) => const DiscardConfirmationWidget(),
                    );
                    if (!context.mounted) return;

                    if (confirmed ?? false) {
                      context.pop();
                    }
                  } else {
                    switch (index) {
                      case 1:
                        progress.value = 0.15;
                        break;
                      case 2:
                        progress.value = 0.3;
                        break;
                      case 3:
                        progress.value = 0.6;
                        break;
                      case 4:
                        progress.value = 0.7;
                        break;
                      case 5:
                        progress.value = 0.8;
                        break;
                      case 6:
                        progress.value = 0.95;
                        break;
                    }
                    setState(() {
                      editListing = false;
                      index--;
                    });
                  }
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: Dimension.radius.twenty,
                ),
              ),
              bottom: index >= (type == ListingType.product ? 4 : 6)
                  ? null
                  : PreferredSize(
                      preferredSize: const Size.fromHeight(2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(
                            begin: 0,
                            end: progress.value,
                          ),
                          duration: 300.milliseconds,
                          builder: (_, anime, __) {
                            return LinearProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                              backgroundColor: theme.backgroundSecondary,
                              value: anime,
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(4),
                            );
                          },
                        ),
                      ),
                    ),
              actions: [
                if (index < (type == ListingType.product ? 4 : 6)) ...[
                  Text(
                    'Step ${index + 1} of ${type == ListingType.product ? 4 : 6}',
                    style: context.text.labelSmall?.copyWith(
                      color: dark ? theme.primary : theme.textSecondary,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                if (index >= (type == ListingType.product ? 4 : 6)) ...[
                  BlocConsumer<NewListingBloc, NewListingState>(
                    listener: (context, state) {
                      if (state is NewListingDone) {
                        context.goNamed(
                          BusinessPage.name,
                          pathParameters: {
                            "urlSlug": urlSlug.text,
                          },
                        );
                      } else if (state is NewListingError) {
                        context.errorNotification(message: state.failure.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is NewListingLoading) {
                        return ActionChip(
                          backgroundColor: theme.link,
                          onPressed: () {},
                          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimension.radius.max),
                            side: BorderSide(color: theme.link, width: 1.0),
                          ),
                          label: NetworkingIndicator(dimension: 20, color: theme.white),
                        );
                      }

                      return ActionChip(
                        backgroundColor: theme.link,
                        onPressed: () {
                          context.read<NewListingBloc>().add(PublishNewListing(
                                name: name.text,
                                urlSlug: urlSlug.text,
                                about: about.text,
                                type: type!,
                                logo: logo,
                                phone: phone.text,
                                email: email.text,
                                website: website.text,
                                social: social.text,
                                industry: industry!,
                                category: category,
                                subCategory: subCategory,
                                address: address.text,
                                division: division,
                                district: district,
                                thana: thana,
                              ));
                        },
                        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimension.radius.max),
                          side: BorderSide(color: theme.link, width: 1.0),
                        ),
                        label: Text(
                          "Publish".toUpperCase(),
                          style: context.text.titleMedium?.copyWith(
                            color: theme.backgroundPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                ],
              ],
            ),
            body: index == 0
                ? NewListingNameWidget(
                    name: name,
                    urlSlug: urlSlug,
                    about: about,
                    edit: editListing,
                    onNext: () {
                      index = 1;
                      editListing = false;
                      context.dismissKeyboard();
                      progress.value = 0.3;
                      setState(() {});
                    },
                    onUpdate: () {
                      context.dismissKeyboard();
                      index = 6;
                      editListing = false;
                      setState(() {});
                    },
                  )
                : index == 1
                    ? NewListingTypeWidget(
                        name: name,
                        edit: editType,
                        onNext: (selection) {
                          index = 2;
                          editType = false;
                          context.dismissKeyboard();
                          progress.value = 0.6;
                          setState(() {
                            type = selection;
                          });
                        },
                        onUpdate: (selection) {
                          index = 6;
                          editType = false;
                          context.dismissKeyboard();
                          setState(() {
                            type = selection;
                          });
                        },
                        type: type,
                      )
                    : index == 2
                        ? NewListingLogoWidget(
                            edit: editLogo,
                            onNext: (logo) {
                              progress.value = 0.7;
                              editLogo = false;
                              this.logo = logo;
                              setState(() {
                                index = 3;
                              });
                            },
                            onUpdate: (logo) {
                              editLogo = false;
                              this.logo = logo;
                              setState(() {
                                index = 6;
                              });
                            },
                            logo: logo,
                          )
                        : index == 3
                            ? NewListingCategoryWidget(
                                edit: editCategory,
                                onNext: (industry, category, subCategory) {
                                  progress.value = 0.8;
                                  editCategory = false;
                                  this.industry = industry;
                                  this.category = category;
                                  this.subCategory = subCategory;
                                  setState(() {
                                    index = 4;
                                  });
                                },
                                onUpdate: (industry, category, subCategory) {
                                  editCategory = false;
                                  this.industry = industry;
                                  this.category = category;
                                  this.subCategory = subCategory;
                                  setState(() {
                                    index = 6;
                                  });
                                },
                                name: name,
                                industry: industry,
                                category: category,
                                subCategory: subCategory,
                              )
                            : index == 4
                                ? type == ListingType.product
                                    ? NewListingPreviewWidget(
                                        name: name,
                                        urlSlug: urlSlug,
                                        about: about,
                                        onNameEdit: () {
                                          setState(() {
                                            editListing = true;
                                            index = 0;
                                          });
                                        },
                                        logo: logo,
                                        onLogoEdit: () {
                                          setState(() {
                                            editLogo = true;
                                            index = 2;
                                          });
                                        },
                                        type: type!,
                                        onTypeEdit: () {
                                          setState(() {
                                            editType = true;
                                            index = 1;
                                          });
                                        },
                                        onContactEdit: () {
                                          setState(() {
                                            editContact = true;
                                            index = 5;
                                          });
                                        },
                                        phone: phone,
                                        email: email,
                                        website: website,
                                        social: social,
                                        onCategoryEdit: () {
                                          setState(() {
                                            editCategory = true;
                                            index = 3;
                                          });
                                        },
                                        industry: industry!,
                                        category: category,
                                        subCategory: subCategory,
                                        onLocationEdit: () {
                                          setState(() {
                                            editLocation = true;
                                            index = 4;
                                          });
                                        },
                                        address: address,
                                        division: division,
                                        district: district,
                                        thana: thana,
                                      )
                                    : NewListingLocationWidget(
                                        edit: editLocation,
                                        onNext: (thana, district, division) {
                                          progress.value = 0.95;
                                          editLocation = false;
                                          this.thana = thana;
                                          this.district = district;
                                          this.division = division;
                                          setState(() {
                                            index = 5;
                                          });
                                        },
                                        onUpdate: (thana, district, division) {
                                          editLocation = false;
                                          this.thana = thana;
                                          this.district = district;
                                          this.division = division;
                                          setState(() {
                                            index = 6;
                                          });
                                        },
                                        division: division,
                                        district: district,
                                        thana: thana,
                                        address: address,
                                      )
                                : index == 5
                                    ? NewListingContactWidget(
                                        edit: editContact,
                                        onUpdate: () {
                                          editContact = false;
                                          setState(() {
                                            index = 6;
                                          });
                                        },
                                        onNext: () {
                                          progress.value = 1.0;
                                          setState(() {
                                            index = 6;
                                          });
                                        },
                                        name: name,
                                        phone: phone,
                                        email: email,
                                        website: website,
                                        social: social,
                                      )
                                    : NewListingPreviewWidget(
                                        name: name,
                                        urlSlug: urlSlug,
                                        about: about,
                                        onNameEdit: () {
                                          setState(() {
                                            editListing = true;
                                            index = 0;
                                          });
                                        },
                                        logo: logo,
                                        onLogoEdit: () {
                                          setState(() {
                                            editLogo = true;
                                            index = 2;
                                          });
                                        },
                                        type: type!,
                                        onTypeEdit: () {
                                          setState(() {
                                            editType = true;
                                            index = 1;
                                          });
                                        },
                                        onContactEdit: () {
                                          setState(() {
                                            editContact = true;
                                            index = 5;
                                          });
                                        },
                                        phone: phone,
                                        email: email,
                                        website: website,
                                        social: social,
                                        onCategoryEdit: () {
                                          setState(() {
                                            editCategory = true;
                                            index = 3;
                                          });
                                        },
                                        industry: industry!,
                                        category: category,
                                        subCategory: subCategory,
                                        onLocationEdit: () {
                                          setState(() {
                                            editLocation = true;
                                            index = 4;
                                          });
                                        },
                                        address: address,
                                        division: division,
                                        district: district,
                                        thana: thana,
                                      ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    progress.dispose();
    name.dispose();
  }
}

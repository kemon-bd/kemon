import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../home/home.dart';
import '../../profile.dart';

class EditProfilePage extends StatefulWidget {
  static const String path = '/profile/edit';
  static const String name = 'EditProfilePage';

  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  DateTime? dob;
  Gender? gender;
  XFile? profilePicture;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return KeyboardDismissOnTap(
          child: Scaffold(
            backgroundColor: theme.backgroundPrimary,
            body: BlocConsumer<FindProfileBloc, FindProfileState>(
              listener: (context, state) {
                if (state is FindProfileDone) {
                  final profile = state.profile;
                  setState(() {
                    firstNameController.text = profile.name.first;
                    lastNameController.text = profile.name.last;
                    emailController.text = profile.email?.address ?? '';
                    phoneController.text = profile.phone?.number ?? '';
                    dob = profile.dob;
                    gender = profile.gender;
                  });
                }
              },
              builder: (context, state) {
                if (state is FindProfileDone) {
                  final profile = state.profile;
                  return Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(left: 24, bottom: 16, top: context.topInset + 16),
                        decoration: BoxDecoration(
                          color: theme.primary,
                          image: const DecorationImage(
                            image: AssetImage('images/logo/full.png'),
                            opacity: .05,
                            scale: 50,
                            repeat: ImageRepeat.repeat,
                          ),
                        ),
                        child: KeyboardVisibilityBuilder(
                          builder: (_, visible) => visible
                              ? Container(height: 2)
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      padding: const EdgeInsets.all(0),
                                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                      onPressed: () {
                                        if (context.canPop()) {
                                          context.pop();
                                        } else {
                                          context.goNamed(HomePage.name);
                                        }
                                      },
                                      icon: Icon(Icons.arrow_back_rounded, color: theme.white),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Edit Profile',
                                            style: TextStyles.subTitle(context: context, color: theme.white).copyWith(
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Let us know more about you.',
                                            style: TextStyles.body(context: context, color: theme.semiWhite).copyWith(
                                              height: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      Expanded(
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            padding: const EdgeInsets.all(16).copyWith(bottom: 16 + context.bottomInset),
                            children: [
                              const SizedBox(height: 32),
                              Container(
                                width: 112,
                                height: 112,
                                alignment: Alignment.center,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: theme.positiveBackgroundSecondary,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: theme.positiveBackgroundTertiary,
                                          width: 4,
                                          strokeAlign: BorderSide.strokeAlignOutside,
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: profilePicture != null
                                          ? Image.file(
                                              File(profilePicture!.path),
                                              width: Dimension.radius.max,
                                              height: Dimension.radius.max,
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: state.profile.profilePicture?.url ?? '',
                                              width: Dimension.radius.max,
                                              height: Dimension.radius.max,
                                              fit: BoxFit.cover,
                                              placeholder: (_, __) => ShimmerIcon(radius: Dimension.radius.max),
                                              errorWidget: (_, __, ___) => Center(
                                                child: state.profile.name.symbol.isNotEmpty
                                                    ? Text(
                                                        state.profile.name.symbol,
                                                        style: TextStyles.body(context: context, color: theme.primary).copyWith(
                                                          fontSize: 64,
                                                        ),
                                                      )
                                                    : Icon(Icons.account_circle_outlined, color: theme.primary, size: 64),
                                              ),
                                            ),
                                    ),
                                    Positioned(
                                      top: -4,
                                      right: -4,
                                      child: InkWell(
                                        onTap: () async {
                                          final ImageSource? source = await showDialog(
                                            context: context,
                                            barrierColor: context.barrierColor,
                                            builder: (_) => const ChooseUploadMethodWidget(),
                                          );

                                          if (source != null) {
                                            final file = await ImagePicker().pickImage(source: source);
                                            if (file != null) {
                                              setState(() {
                                                profilePicture = file;
                                              });
                                            }
                                          }
                                        },
                                        borderRadius: BorderRadius.circular(Dimension.radius.max),
                                        child: CircleAvatar(
                                          backgroundColor: theme.primary,
                                          radius: Dimension.radius.sixteen,
                                          child: Icon(Icons.edit_outlined, color: theme.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                              Container(
                                decoration: BoxDecoration(
                                  color: theme.backgroundSecondary,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: theme.backgroundTertiary,
                                    width: .25,
                                  ),
                                ),
                                child: ListView(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero.copyWith(top: 4, bottom: 4),
                                  physics: const NeverScrollableScrollPhysics(),
                                  cacheExtent: double.maxFinite,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'First name *',
                                            style: TextStyles.body(context: context, color: theme.textSecondary),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: TextFormField(
                                              controller: firstNameController,
                                              keyboardType: TextInputType.name,
                                              textCapitalization: TextCapitalization.words,
                                              textAlign: TextAlign.end,
                                              textAlignVertical: TextAlignVertical.center,
                                              textInputAction: TextInputAction.next,
                                              autofillHints: const [
                                                AutofillHints.givenName,
                                                AutofillHints.name,
                                                AutofillHints.namePrefix,
                                              ],
                                              validator: (value) => firstNameController.validName ? null : "",
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'required',
                                                hintStyle: TextStyles.body(
                                                  context: context,
                                                  color: theme.textSecondary.withAlpha(150),
                                                ),
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                disabledBorder: InputBorder.none,
                                              ),
                                              style: TextStyles.body(
                                                context: context,
                                                color: firstNameController.validName ? theme.textPrimary : theme.negative,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(thickness: .15, height: .15, color: theme.backgroundTertiary),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Last',
                                            style: TextStyles.body(context: context, color: theme.textSecondary),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: TextField(
                                              controller: lastNameController,
                                              keyboardType: TextInputType.name,
                                              textCapitalization: TextCapitalization.words,
                                              textAlign: TextAlign.end,
                                              textAlignVertical: TextAlignVertical.center,
                                              textInputAction: TextInputAction.next,
                                              autofillHints: const [
                                                AutofillHints.familyName,
                                                AutofillHints.nameSuffix,
                                              ],
                                              decoration: InputDecoration(
                                                hintText: 'optional',
                                                isDense: true,
                                                hintStyle: TextStyles.body(
                                                  context: context,
                                                  color: theme.textSecondary.withAlpha(150),
                                                ),
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                disabledBorder: InputBorder.none,
                                              ),
                                              style: TextStyles.body(context: context, color: theme.textPrimary),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(thickness: .15, height: .15, color: theme.backgroundTertiary),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text: "Email",
                                              style: TextStyles.body(context: context, color: theme.textSecondary),
                                              children: context.auth.username.same(as: profile.email?.address)
                                                  ? <InlineSpan>[
                                                      WidgetSpan(child: SizedBox(width: 4)),
                                                      WidgetSpan(
                                                        child: Icon(
                                                          Icons.lock_rounded,
                                                          color: theme.textPrimary.withAlpha(100),
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ]
                                                  : null,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: TextFormField(
                                              controller: emailController,
                                              keyboardType: TextInputType.emailAddress,
                                              textAlign: TextAlign.end,
                                              textAlignVertical: TextAlignVertical.center,
                                              textInputAction: TextInputAction.next,
                                              autofillHints: const [AutofillHints.email],
                                              validator: (value) => context.auth.username.same(as: profile.email?.address)
                                                  ? null
                                                  : ((value ?? "").isNotEmpty
                                                      ? (emailController.validEmail ? null : "")
                                                      : null),
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                              readOnly: context.auth.username.same(as: profile.email?.address),
                                              decoration: InputDecoration(
                                                hintText: context.auth.username.same(as: profile.email?.address)
                                                    ? 'required'
                                                    : 'optional',
                                                isDense: true,
                                                hintStyle: TextStyles.body(
                                                  context: context,
                                                  color: theme.textSecondary.withAlpha(150),
                                                ),
                                                helperStyle: TextStyle(fontSize: 0),
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                disabledBorder: InputBorder.none,
                                                suffixIconConstraints: BoxConstraints(maxWidth: 24, maxHeight: 24),
                                                suffixIcon: !(profile.email?.verified ?? false) ||
                                                        !emailController.text.same(as: profile.email?.address)
                                                    ? IconButton(
                                                        padding: EdgeInsets.all(0),
                                                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                                        onPressed: () async {
                                                          final confirmed = await showDialog<bool>(
                                                            context: context,
                                                            builder: (_) => VerificationConfirmationWidget(affirm: 'Continue'),
                                                          );

                                                          if (!(confirmed ?? false)) return;
                                                          if (!context.mounted) return;

                                                          final verified = await showModalBottomSheet<bool>(
                                                            context: context,
                                                            isScrollControlled: true,
                                                            barrierColor: context.barrierColor,
                                                            builder: (_) => MultiBlocProvider(
                                                              providers: [
                                                                BlocProvider(
                                                                  create: (_) => sl<RequestOtpForPasswordChangeBloc>()
                                                                    ..add(
                                                                      RequestOtpForPhoneOrEmailVerification(
                                                                        username: profile.email!.address,
                                                                      ),
                                                                    ),
                                                                ),
                                                                BlocProvider(create: (_) => sl<UpdateProfileBloc>()),
                                                              ],
                                                              child: Padding(
                                                                padding: context.viewInsets,
                                                                child: VerifyPhoneOrEmailWidget(
                                                                  username: profile.phone!.number,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                          if (!(verified ?? true)) return;
                                                          if (!context.mounted) return;
                                                          context
                                                              .read<FindProfileBloc>()
                                                              .add(RefreshProfile(identity: context.auth.profile!.identity));
                                                        },
                                                        icon: Icon(Icons.verified_outlined, color: theme.link),
                                                      )
                                                    : null,
                                              ),
                                              style: TextStyles.body(
                                                context: context,
                                                color: emailController.validEmail ? theme.textPrimary : theme.negative,
                                              ),
                                              onTap: () {
                                                if (context.auth.username.same(as: profile.email?.address)) {
                                                  context.warningNotification(
                                                    message: "Kemon doesn't allow modifying username!!!",
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(thickness: .15, height: .15, color: theme.backgroundTertiary),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text: "Phone",
                                              style: TextStyles.body(context: context, color: theme.textSecondary),
                                              children: context.auth.username.same(as: profile.phone?.number)
                                                  ? <InlineSpan>[
                                                      WidgetSpan(child: SizedBox(width: 4)),
                                                      WidgetSpan(
                                                        child: Icon(
                                                          Icons.lock_rounded,
                                                          color: theme.textPrimary.withAlpha(100),
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ]
                                                  : null,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: TextFormField(
                                              controller: phoneController,
                                              keyboardType: TextInputType.phone,
                                              textAlign: TextAlign.end,
                                              textAlignVertical: TextAlignVertical.center,
                                              textInputAction: TextInputAction.next,
                                              validator: (value) => context.auth.username.same(as: profile.phone?.number)
                                                  ? null
                                                  : ((value ?? "").isNotEmpty
                                                      ? (phoneController.validPhone ? null : "")
                                                      : null),
                                              autofillHints: const [
                                                AutofillHints.telephoneNumber,
                                                AutofillHints.telephoneNumberDevice,
                                                AutofillHints.telephoneNumberNational,
                                                AutofillHints.telephoneNumberLocal,
                                              ],
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                              readOnly: context.auth.username.same(as: profile.phone?.number),
                                              decoration: InputDecoration(
                                                hintText: context.auth.username.same(as: profile.phone?.number)
                                                    ? 'required'
                                                    : 'optional',
                                                isDense: true,
                                                hintStyle: TextStyles.body(
                                                  context: context,
                                                  color: theme.textSecondary.withAlpha(150),
                                                ),
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                disabledBorder: InputBorder.none,
                                                suffixIconConstraints: BoxConstraints(maxWidth: 24, maxHeight: 24),
                                                suffixIcon: !(profile.phone?.verified ?? false) ||
                                                        !phoneController.text.same(as: profile.phone?.number)
                                                    ? IconButton(
                                                        padding: EdgeInsets.all(0),
                                                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                                        onPressed: () async {
                                                          final confirmed = await showDialog<bool>(
                                                            context: context,
                                                            builder: (_) => VerificationConfirmationWidget(affirm: 'Continue'),
                                                          );

                                                          if (!(confirmed ?? false)) return;
                                                          if (!context.mounted) return;

                                                          final verified = await showModalBottomSheet<bool>(
                                                            context: context,
                                                            isScrollControlled: true,
                                                            barrierColor: context.barrierColor,
                                                            builder: (_) => MultiBlocProvider(
                                                              providers: [
                                                                BlocProvider(
                                                                  create: (_) => sl<RequestOtpForPasswordChangeBloc>()
                                                                    ..add(
                                                                      RequestOtpForPhoneOrEmailVerification(
                                                                        username: profile.phone!.number,
                                                                      ),
                                                                    ),
                                                                ),
                                                                BlocProvider(create: (_) => sl<UpdateProfileBloc>()),
                                                              ],
                                                              child: Padding(
                                                                padding: context.viewInsets,
                                                                child: VerifyPhoneOrEmailWidget(
                                                                  username: profile.phone!.number,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                          if (!(verified ?? true)) return;
                                                          if (!context.mounted) return;
                                                          context
                                                              .read<FindProfileBloc>()
                                                              .add(RefreshProfile(identity: context.auth.profile!.identity));
                                                        },
                                                        icon: Icon(Icons.verified_outlined, color: theme.link),
                                                      )
                                                    : null,
                                              ),
                                              style: TextStyles.body(
                                                context: context,
                                                color: context.auth.username.same(as: profile.phone?.number)
                                                    ? theme.textSecondary
                                                    : phoneController.validPhone
                                                        ? theme.textPrimary
                                                        : theme.negative,
                                              ),
                                              onTap: () {
                                                if (context.auth.username.same(as: profile.phone?.number)) {
                                                  context.warningNotification(
                                                    message: "Kemon doesn't allow modifying username!!!",
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(thickness: .15, height: .15, color: theme.backgroundTertiary),
                                    InkWell(
                                      onTap: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: dob ?? DateTime(2000),
                                          firstDate: DateTime(1920),
                                          lastDate: DateTime.now().copyWith(year: DateTime.now().year - 16),
                                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                                          initialDatePickerMode: DatePickerMode.day,
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
                                            dob = date;
                                          });
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Date of birth',
                                              style: TextStyles.body(context: context, color: theme.textSecondary),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                dob?.dMMMMyyyy ?? 'Select one',
                                                style: TextStyles.body(context: context, color: theme.textPrimary),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Icon(Icons.arrow_drop_down_rounded, color: theme.textPrimary),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(thickness: .15, height: .15, color: theme.backgroundTertiary),
                                    DropdownWidget<Gender>(
                                      label: 'Gender',
                                      labelStyle: TextStyles.body(context: context, color: theme.textSecondary),
                                      onSelect: (selection) {
                                        setState(() {
                                          gender = selection;
                                        });
                                      },
                                      text: gender?.text ?? 'Select one',
                                      textStyle: TextStyles.body(context: context, color: theme.textPrimary),
                                      popup: GenderFilterWidget(selection: gender),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                                  listener: (context, state) {
                                    if (state is UpdateProfileError) {
                                      context.errorNotification(message: state.failure.message);
                                    } else if (state is UpdateProfileDone) {
                                      context.successNotification(
                                        message: 'Congratulations. Your profile has been updated :)',
                                      );
                                      context.pop(true);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is UpdateProfileLoading) {
                                      return ElevatedButton(
                                        onPressed: () {
                                          FocusScope.of(context).requestFocus(FocusNode());
                                        },
                                        child: NetworkingIndicator(dimension: Dimension.radius.eighteen, color: theme.white),
                                      );
                                    }
                                    return ElevatedButton(
                                      onPressed: () {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        if (formKey.currentState?.validate() ?? false) {
                                          final profile = context.auth.profile!;
                                          context.read<UpdateProfileBloc>().add(
                                                UpdateProfile(
                                                  profile: profile.copyWith(
                                                    firstName: firstNameController.text,
                                                    lastName: lastNameController.text,
                                                    email: emailController.text,
                                                    phone: phoneController.text,
                                                    dob: dob,
                                                    gender: gender,
                                                  ),
                                                  avatar: profilePicture,
                                                ),
                                              );
                                        }
                                      },
                                      child: Text(
                                        "Update".toUpperCase(),
                                        style: TextStyles.button(context: context),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}

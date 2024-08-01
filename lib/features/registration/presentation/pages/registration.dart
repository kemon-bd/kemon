import '../../../../core/shared/shared.dart';
import '../../../login/login.dart';
import '../../registration.dart';

class RegistrationPage extends StatefulWidget {
  static const String path = '/registration';
  static const String name = 'RegistrationPage';

  final String username;

  const RegistrationPage({
    super.key,
    required this.username,
  });

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  DateTime? dob;
  Gender? gender;

  bool isObscured = true;
  bool isConfirmPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final validPassword = (password: passwordController, confirmPassword: confirmPasswordController).valid;
        return KeyboardDismissOnTap(
          child: Scaffold(
            backgroundColor: theme.backgroundPrimary,
            body: Column(
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
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create an account',
                                style: TextStyles.headline(context: context, color: theme.white).copyWith(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Please fill all the required fields to create an account.',
                                style: TextStyles.body(context: context, color: theme.semiWhite).copyWith(
                                  height: 1,
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
                        Text(
                          'Password',
                          style: TextStyles.miniHeadline(context: context, color: theme.textPrimary),
                        ),
                        const SizedBox(height: 8),
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
                                padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(right: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Password *',
                                      style: TextStyles.body(context: context, color: theme.textSecondary),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextFormField(
                                        controller: passwordController,
                                        keyboardType: TextInputType.text,
                                        textAlign: TextAlign.end,
                                        textAlignVertical: TextAlignVertical.center,
                                        textInputAction: TextInputAction.next,
                                        autofillHints: const [AutofillHints.password, AutofillHints.newPassword],
                                        validator: (value) => passwordController.validPassword ? null : "",
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        decoration: InputDecoration(
                                          fillColor: theme.backgroundSecondary,
                                          filled: true,
                                          hintText: 'required',
                                          isDense: true,
                                          hintStyle: TextStyles.subTitle(
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
                                          suffixIcon: IconButton(
                                            padding: EdgeInsets.zero,
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                            icon: Icon(
                                              isObscured ? Icons.visibility : Icons.visibility_off,
                                              color: passwordController.validPassword ? theme.textPrimary : theme.negative,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isObscured = !isObscured;
                                              });
                                            },
                                          ),
                                        ),
                                        obscureText: isObscured,
                                        style: TextStyles.title(
                                          context: context,
                                          color: passwordController.validPassword ? theme.textPrimary : theme.negative,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (passwordController.validPassword) ...[
                                Divider(thickness: .15, height: .15, color: theme.backgroundTertiary),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(right: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Confirm password *',
                                        style: TextStyles.body(context: context, color: theme.textSecondary),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: TextFormField(
                                          controller: confirmPasswordController,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.end,
                                          textAlignVertical: TextAlignVertical.center,
                                          textInputAction: TextInputAction.done,
                                          validator: (value) => confirmPasswordController.validPassword ? null : "",
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                            fillColor: theme.backgroundSecondary,
                                            filled: true,
                                            hintText: 'required',
                                            isDense: true,
                                            hintStyle: TextStyles.subTitle(
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
                                            suffixIcon: IconButton(
                                              padding: EdgeInsets.zero,
                                              highlightColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                              icon: Icon(
                                                isConfirmPasswordObscured ? Icons.visibility : Icons.visibility_off,
                                                color: confirmPasswordController.validPassword
                                                    ? theme.textPrimary
                                                    : theme.negative,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isConfirmPasswordObscured = !isConfirmPasswordObscured;
                                                });
                                              },
                                            ),
                                          ),
                                          obscureText: isConfirmPasswordObscured,
                                          style: TextStyles.title(
                                            context: context,
                                            color: confirmPasswordController.validPassword ? theme.textPrimary : theme.negative,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (validPassword) ...[
                          const SizedBox(height: 16),
                          Text(
                            'Name',
                            style: TextStyles.miniHeadline(context: context, color: theme.textPrimary),
                          ),
                          const SizedBox(height: 8),
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
                                        'First *',
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
                                            fillColor: theme.backgroundSecondary,
                                            filled: true,
                                            hintText: 'required',
                                            isDense: true,
                                            hintStyle: TextStyles.subTitle(
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
                                          style: TextStyles.title(
                                            context: context,
                                            color: firstNameController.validName ? theme.textPrimary : theme.negative,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (firstNameController.validName) ...[
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
                                              fillColor: theme.backgroundSecondary,
                                              filled: true,
                                              hintText: 'optional',
                                              isDense: true,
                                              hintStyle: TextStyles.subTitle(
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
                                            style: TextStyles.title(context: context, color: theme.textPrimary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                        if (firstNameController.validName) ...[
                          const SizedBox(height: 16),
                          Text(
                            'Contact',
                            style: TextStyles.miniHeadline(context: context, color: theme.textPrimary),
                          ),
                          const SizedBox(height: 8),
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
                                        'Email *',
                                        style: TextStyles.body(context: context, color: theme.textSecondary),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: TextFormField(
                                          controller: emailController,
                                          keyboardType: TextInputType.emailAddress,
                                          textCapitalization: TextCapitalization.words,
                                          textAlign: TextAlign.end,
                                          textAlignVertical: TextAlignVertical.center,
                                          textInputAction: TextInputAction.next,
                                          autofillHints: const [AutofillHints.email],
                                          validator: (value) => emailController.validEmail ? null : "",
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                            fillColor: theme.backgroundSecondary,
                                            filled: true,
                                            hintText: 'required',
                                            isDense: true,
                                            hintStyle: TextStyles.subTitle(
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
                                          style: TextStyles.title(
                                            context: context,
                                            color: emailController.validEmail ? theme.textPrimary : theme.negative,
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
                                        'Phone *',
                                        style: TextStyles.body(context: context, color: theme.textSecondary),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: TextFormField(
                                          controller: phoneController,
                                          keyboardType: TextInputType.phone,
                                          textAlign: TextAlign.end,
                                          textAlignVertical: TextAlignVertical.center,
                                          textInputAction: TextInputAction.next,
                                          autofillHints: const [
                                            AutofillHints.telephoneNumber,
                                            AutofillHints.telephoneNumberDevice,
                                            AutofillHints.telephoneNumberNational,
                                            AutofillHints.telephoneNumberLocal,
                                          ],
                                          validator: (value) => phoneController.validPhone ? null : "",
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                            fillColor: theme.backgroundSecondary,
                                            filled: true,
                                            hintText: 'required',
                                            isDense: true,
                                            hintStyle: TextStyles.subTitle(
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
                                          style: TextStyles.title(
                                            context: context,
                                            color: phoneController.validPhone ? theme.textPrimary : theme.negative,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (emailController.validEmail && phoneController.validPhone) ...[
                          const SizedBox(height: 16),
                          Text(
                            'Others',
                            style: TextStyles.miniHeadline(context: context, color: theme.textPrimary),
                          ),
                          const SizedBox(height: 8),
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
                                            style: TextStyles.title(context: context, color: theme.textPrimary),
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
                                  onSelect: (selection) {
                                    setState(() {
                                      gender = selection;
                                    });
                                  },
                                  text: gender?.text ?? 'Select one',
                                  popup: GenderFilterWidget(selection: gender),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: BlocConsumer<RegistrationBloc, RegistrationState>(
                              listener: (context, state) {
                                if (state is RegistrationError) {
                                  context.errorNotification(message: state.failure.message);
                                } else if (state is RegistrationDone) {
                                  context.pushReplacementNamed(
                                    LoginPage.name,
                                    queryParameters: {
                                      'guid': state.identity.guid,
                                    },
                                  );
                                  context.successNotification(
                                    message: 'Congralutations. You have successfully registered. Have a nice one :)',
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is RegistrationLoading) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                    },
                                    child: NetworkingIndicator(dimension: 28, color: theme.backgroundPrimary),
                                  );
                                }
                                return ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    if (formKey.currentState?.validate() ?? false) {
                                      context.read<RegistrationBloc>().add(
                                            CreateAccount(
                                              username: widget.username,
                                              password: passwordController.text,
                                              firstName: firstNameController.text,
                                              lastName: lastNameController.text,
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              refference: '',
                                              dob: dob!,
                                              gender: gender!,
                                            ),
                                          );
                                    }
                                  },
                                  child: Text(
                                    "Sign up".toUpperCase(),
                                    style: TextStyles.miniHeadline(
                                      context: context,
                                      color: theme.backgroundPrimary,
                                    ).copyWith(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

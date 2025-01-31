// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:moumachi/src/core/extension/context.dart';

// import '../../../../../core/theme/scheme.dart';
// import '../../../../../core/theme/theme_cubit.dart';

// class NewListingAboutWidget extends StatefulWidget {
//   final Function(bool) onNext;
//   final Function(bool) onUpdate;
//   final bool edit;
//   final TextEditingController name;
//   final TextEditingController since;
//   final TextEditingController tradeLicense;
//   final bool active;

//   const NewListingAboutWidget({
//     super.key,
//     this.edit = false,
//     required this.onUpdate,
//     required this.onNext,
//     required this.name,
//     required this.since,
//     required this.tradeLicense,
//     required this.active,
//   });

//   @override
//   State<NewListingAboutWidget> createState() => _NewListingAboutWidgetState();
// }

// class _NewListingAboutWidgetState extends State<NewListingAboutWidget> {
//   late final TextEditingController tradeLicense;
//   late final TextEditingController since;
//   late bool active;

//   @override
//   void initState() {
//     super.initState();
//     tradeLicense = widget.tradeLicense;
//     since = widget.since;
//     active = widget.active;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeCubit, ThemeState>(
//       builder: (_, state) {
//         final theme = ThemeScheme(state.theme);
//         return ListView(
//           padding: const EdgeInsets.all(16).copyWith(bottom: context.navigationBarHeight + 16),
//           children: [
//             const SizedBox(height: 24),
//             Text.rich(
//               TextSpan(
//                 children: [
//                   TextSpan(
//                     text: "Almost There!",
//                     style: TextStyles.title(context: context, color: theme.textPrimary),
//                   ),
//                   const WidgetSpan(child: SizedBox(width: 8)),
//                   WidgetSpan(
//                     baseline: TextBaseline.ideographic,
//                     alignment: PlaceholderAlignment.aboveBaseline,
//                     child: Text(
//                       "optional",
//                       style: TextStyles.body(context: context, color: theme.textSecondary),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               "Just a few optional details like trade license, start date to complete the listing and enhance its credibility.",
//               style: TextStyles.body(context: context, color: theme.textSecondary),
//             ),
//             const SizedBox(height: 24),
//             Text.rich(
//               TextSpan(
//                 children: [
//                   TextSpan(
//                     text: "Trade License",
//                     style: TextStyles.subTitle(context: context, color: theme.textPrimary),
//                   ),
//                   const WidgetSpan(child: SizedBox(width: 8)),
//                   WidgetSpan(
//                     baseline: TextBaseline.ideographic,
//                     alignment: PlaceholderAlignment.aboveBaseline,
//                     child: Text(
//                       "optional",
//                       style: TextStyles.body(context: context, color: theme.textSecondary),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: tradeLicense,
//               autofocus: true,
//               autocorrect: false,
//               style: TextStyles.subTitle(context: context, color: theme.textPrimary),
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.phone,
//               autofillHints: const [AutofillHints.telephoneNumber],
//               decoration: InputDecoration(
//                 hintText: '',
//                 hintStyle: TextStyles.subTitle(context: context, color: theme.textSecondary),
//               ),
//             ),
//             const SizedBox(height: 24),
//             Text.rich(
//               TextSpan(
//                 children: [
//                   TextSpan(
//                     text: "In Business Since",
//                     style: TextStyles.subTitle(context: context, color: theme.textPrimary),
//                   ),
//                   const WidgetSpan(child: SizedBox(width: 8)),
//                   WidgetSpan(
//                     baseline: TextBaseline.ideographic,
//                     alignment: PlaceholderAlignment.aboveBaseline,
//                     child: Text(
//                       "optional",
//                       style: TextStyles.body(context: context, color: theme.textSecondary),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: since,
//               autofocus: true,
//               autocorrect: false,
//               enabled: true,
//               readOnly: true,
//               onTapAlwaysCalled: true,
//               onTap: () async {
//                 final initialDate = DateTime.tryParse(since.text);
//                 final DateTime? dateTime = await showDatePicker(
//                   context: context,
//                   initialDate: initialDate ?? DateTime.now(),
//                   firstDate: DateTime(1800),
//                   lastDate: DateTime.now(),
//                   initialDatePickerMode: DatePickerMode.year,
//                   initialEntryMode: DatePickerEntryMode.calendarOnly,
//                   builder: (context, child) {
//                     return Theme(
//                       data: ThemeData.light(useMaterial3: true).copyWith(
//                         colorScheme: ColorScheme.fromSeed(seedColor: theme.primaryColor),
//                       ),
//                       child: child ?? Container(),
//                     );
//                   },
//                 );

//                 if (dateTime != null) {
//                   setState(() {
//                     since.text = DateFormat("dd-MM-yyyy").format(dateTime);
//                   });
//                 }
//               },
//               style: TextStyles.subTitle(context: context, color: theme.textPrimary),
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.emailAddress,
//               autofillHints: const [AutofillHints.email],
//               decoration: InputDecoration(
//                 hintText: '',
//                 hintStyle: TextStyles.subTitle(context: context, color: theme.textSecondary),
//               ),
//               onEditingComplete: () {
//                 if (widget.edit) {
//                   widget.onUpdate(active);
//                 } else {
//                   widget.onNext(active);
//                 }
//               },
//             ),
//             const SizedBox(height: 24),
//             TextButton(
//               onPressed: () {
//                 if (widget.edit) {
//                   widget.onUpdate(active);
//                 } else {
//                   widget.onNext(active);
//                 }
//               },
//               child: Text(
//                 'Skip',
//                 style: TextStyles.subTitle(context: context, color: theme.textPrimary),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 if (widget.edit) {
//                   widget.onUpdate(active);
//                 } else {
//                   widget.onNext(active);
//                 }
//               },
//               child: Text(
//                 'Next',
//                 style: TextStyles.button(context: context),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }

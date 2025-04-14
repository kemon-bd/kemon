import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class LeaderboardFilterWidget extends StatefulWidget {
  const LeaderboardFilterWidget({super.key});

  @override
  State<LeaderboardFilterWidget> createState() => _LeaderboardFilterWidgetState();
}

class _LeaderboardFilterWidgetState extends State<LeaderboardFilterWidget> {
  late DateRangeOption option;
  late DateTime from, to;

  @override
  void initState() {
    super.initState();

    final filter = context.read<LeaderboardFilterBloc>().state;
    option = filter.option;
    from = filter.range.start;
    to = filter.range.end;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;

        return Material(
          child: Container(
            decoration: BoxDecoration(
              color: theme.backgroundPrimary,
              border: Border(
                top: BorderSide(color: theme.textPrimary, width: 1),
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16).copyWith(
                bottom: 16 + context.bottomInset,
              ),
              physics: const ScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filter",
                      style: context.text.headlineSmall?.copyWith(
                        color: theme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        color: theme.textPrimary,
                        size: 24,
                        weight: 400,
                        grade: 200,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: theme.backgroundSecondary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.backgroundTertiary, width: .25),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      DropdownWidget<DateRangeOption>(
                        label: 'Date range',
                        labelStyle: context.text.bodyMedium?.copyWith(
                        height: 1.0,
                        color: theme.textSecondary,
                        fontWeight: FontWeight.normal,
                      ),
                        text: option.name,
                        textStyle: TextStyles.body(context: context, color: theme.link).copyWith(fontWeight: FontWeight.bold),
                        iconColor: theme.link,
                        popup: DateRangeFilterWidget(selection: option),
                        onSelect: (selection) {
                          setState(() {
                            option = selection;
                            if (option != DateRangeOption.custom) {
                              final DateTimeRange dates = selection.evaluate;
                              from = dates.start;
                              to = dates.end;
                            }
                          });
                        },
                      ),
                      if (option == DateRangeOption.custom) ...[
                        Divider(height: .25, thickness: .25, color: theme.backgroundTertiary),
                        InkWell(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: from,
                              firstDate: DateTime(2010),
                              lastDate: DateTime.now(),
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
                                from = date;
                              });
                            }

                            if (to.isBefore(from)) {
                              setState(() {
                                to = from;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'From',
                                  style: TextStyles.body(context: context, color: theme.textSecondary),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      from.dMMMMyyyy,
                                      style: TextStyles.body(context: context, color: theme.link).copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(Icons.arrow_drop_down_rounded, size: 20, color: theme.link),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: .25, thickness: .25, color: theme.backgroundTertiary),
                        InkWell(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: to,
                              firstDate: from,
                              lastDate: DateTime.now(),
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
                                to = date;
                              });
                            }

                            if (to.isAfter(from)) {
                              setState(() {
                                from = to;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'To',
                                  style: TextStyles.body(context: context, color: theme.textSecondary),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      to.dMMMMyyyy,
                                      style: TextStyles.body(context: context, color: theme.link).copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(Icons.arrow_drop_down_rounded, size: 20, color: theme.link),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    context.read<LeaderboardFilterBloc>().add(const ResetLeaderboardFilter());
                    context.pop(true);
                    context.successNotification(message: 'Filter applied successfully.');
                  },
                  child: Text(
                    'reset'.toUpperCase(),
                    style: context.text.titleMedium?.copyWith(
                      color: theme.textPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    context.read<LeaderboardFilterBloc>().add(
                          SwitchLeaderboardFilter(
                            option: option,
                            range: DateTimeRange(start: from, end: to),
                          ),
                        );
                    context.pop(true);
                    context.successNotification(message: 'Filter applied successfully.');
                  },
                  child: Text(
                    'Apply'.toUpperCase(),
                    style: context.text.titleMedium?.copyWith(
                      color: theme.white,
                      fontWeight: FontWeight.w900,
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

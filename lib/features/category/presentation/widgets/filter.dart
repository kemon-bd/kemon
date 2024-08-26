import '../../../../core/shared/shared.dart';

class FilterMenuWidget extends StatefulWidget {
  const FilterMenuWidget({super.key});

  @override
  State<FilterMenuWidget> createState() => _FilterMenuWidgetState();
}

class _FilterMenuWidgetState extends State<FilterMenuWidget> {
  @override
  void initState() {
    super.initState();
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
                      style: TextStyles.headline(context: context, color: theme.textPrimary),
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
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status',
                                style: TextStyles.subTitle(context: context, color: theme.textSecondary),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Select one',
                                    style: TextStyles.title(context: context, color: theme.textPrimary),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.arrow_drop_down_rounded, size: 20, color: theme.textPrimary),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(height: .25, thickness: .25, color: theme.backgroundTertiary),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Type',
                                style: TextStyles.subTitle(context: context, color: theme.textSecondary),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Select one',
                                    style: TextStyles.title(context: context, color: theme.textPrimary),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.arrow_drop_down_rounded, size: 20, color: theme.textPrimary),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Apply'.toUpperCase(),
                    style: TextStyles.miniHeadline(context: context, color: theme.white).copyWith(
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

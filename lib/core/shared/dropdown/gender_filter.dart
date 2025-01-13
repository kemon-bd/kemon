import '../../../../core/shared/shared.dart';

class GenderFilterWidget extends StatelessWidget {
  final Gender? selection;

  const GenderFilterWidget({
    super.key,
    required this.selection,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final theme = state.scheme;
          return Container(
            decoration: BoxDecoration(
              color: theme.backgroundPrimary,
              border: Border(
                top: BorderSide(color: theme.textPrimary, width: 1),
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16)
                  .copyWith(bottom: context.bottomInset + 16),
              physics: const ScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Gender",
                      style: TextStyles.subTitle(
                          context: context, color: theme.textPrimary),
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
                    border:
                        Border.all(color: theme.backgroundTertiary, width: .25),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(height: .25, color: theme.backgroundTertiary),
                    itemBuilder: (context, index) {
                      final item = Gender.values[index];
                      final bool selected = selection == item;
                      return InkWell(
                        onTap: () {
                          context.pop(item);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(
                                selected
                                    ? Icons.check_circle_rounded
                                    : Icons.circle_outlined,
                                color: selected
                                    ? theme.positive
                                    : theme.textPrimary,
                                size: 24,
                                grade: 200,
                                weight: 700,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  item.text,
                                  style: TextStyles.subTitle(
                                    context: context,
                                    color: selected
                                        ? theme.positive
                                        : theme.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: Gender.values.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero.copyWith(top: 8, bottom: 8),
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

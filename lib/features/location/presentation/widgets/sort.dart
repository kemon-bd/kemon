import '../../../../core/shared/shared.dart';

class SortBusinessesByLocationWidget extends StatelessWidget {
  final SortBy selection;
  const SortBusinessesByLocationWidget({
    super.key,
    required this.selection,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;

        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16).copyWith(
            top: 16 + context.topInset,
            bottom: 16 + context.bottomInset,
          ),
          physics: const ScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sort By",
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
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: theme.backgroundSecondary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.backgroundTertiary, width: .25),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (_, index) {
                  final item = SortBy.values[index];
                  final selected = selection == item;

                  return InkWell(
                    onTap: () {
                      context.pop(item);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(Dimension.radius.sixteen),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                            size: Dimension.radius.twenty,
                            color: selected ? theme.primary : theme.textPrimary,
                          ),
                          SizedBox(width: Dimension.padding.horizontal.max),
                          Expanded(
                            child: Text(
                              item.text,
                              style: context.text.bodyMedium?.copyWith(
                                color: selected ? theme.primary : theme.textPrimary,
                                fontWeight: selected ? FontWeight.w900 : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: SortBy.values.length,
              ),
            ),
          ],
        );
      },
    );
  }
}

import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class FlagReasonFilter extends StatelessWidget {
  final LookupEntity? selection;
  const FlagReasonFilter({
    super.key,
    required this.selection,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;

        return BlocProvider(
          create: (context) => sl<FindLookupBloc>()..add(FindLookup(lookup: Lookups.flagReason)),
          child: AlertDialog(
            backgroundColor: theme.backgroundPrimary,
            clipBehavior: Clip.antiAlias,
            insetPadding: EdgeInsets.all(24),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Please choose a reason",
                  style: context.text.headlineSmall?.copyWith(
                    color: theme.textPrimary,
                    fontWeight: FontWeight.bold,
                    inherit: true,
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: context.pop,
                  icon: Icon(Icons.close_rounded, color: theme.textPrimary),
                ),
              ],
            ),
            titlePadding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 12, right: 8),
            contentPadding: const EdgeInsets.all(0).copyWith(bottom: 8),
            content: BlocBuilder<FindLookupBloc, FindLookupState>(
              builder: (context, state) {
                if (state is FindLookupDone) {
                  final reasons = state.lookups;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(thickness: .5, height: 8),
                      ...reasons.map(
                        (reason) {
                          final bool selected = selection?.value == reason.value;
                          return ListTile(
                            onTap: () {
                              if (selected) {
                                context.pop(null);
                              } else {
                                context.pop(reason);
                              }
                            },
                            leading: Icon(
                              selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                              color: selected ? theme.positive : theme.textSecondary,
                            ),
                            title: Text(
                              reason.text,
                              style: context.text.bodyLarge?.copyWith(
                                color: selected ? theme.positive : theme.textSecondary,
                                fontWeight: FontWeight.bold,
                                inherit: true,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else if (state is FindLookupLoading) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [0, 1, 2, 3]
                        .map(
                          (_) => ListTile(
                            leading: Icon(Icons.circle, size: 24, color: theme.backgroundSecondary),
                            title: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 112,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: theme.backgroundSecondary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
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
}

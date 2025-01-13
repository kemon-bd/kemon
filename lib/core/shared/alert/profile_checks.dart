import '../../../features/lookup/lookup.dart';
import '../shared.dart';

class ProfileCheckAlert extends StatelessWidget {
  final List<LookupEntity> checks;
  const ProfileCheckAlert({
    super.key,
    required this.checks,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Container(
          decoration: BoxDecoration(
            color: theme.backgroundPrimary,
            borderRadius: BorderRadius.circular(0).copyWith(
              topLeft: const Radius.circular(32),
              topRight: const Radius.circular(32),
            ),
            border: Border(
              top: BorderSide(color: theme.backgroundSecondary, width: 8),
            ),
          ),
          padding: const EdgeInsets.all(16).copyWith(bottom: 16 + context.bottomInset),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            children: [
              const SizedBox(height: 8),
              Text(
                'Incomplete profile',
                style: TextStyles.title(context: context, color: theme.primary),
              ),
              const SizedBox(height: 4),
              Text(
                'KEMON enforces ALL users to complete 50% of their public profile to prevent spam, troll, in-appropriate behavior and keeping the community safe.',
                style: TextStyles.caption(context: context, color: theme.textSecondary),
              ),
              Divider(height: 42, thickness: .25, color: theme.backgroundTertiary),
              Text(
                'Here is the missing information about your profile:',
                style: TextStyles.body(context: context, color: theme.textPrimary),
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: context.height * 0.5,
                ),
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    final checkpoint = checks[index];
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      leading: Icon(Icons.info_outline_rounded, color: theme.warning),
                      title: Text(
                        checkpoint.text,
                        style: TextStyles.subTitle(context: context, color: theme.warning),
                      ),
                      trailing: Text(
                        "+ ${checkpoint.point}",
                        style: TextStyles.subTitle(context: context, color: theme.warning),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => Divider(height: Dimension.padding.vertical.large),
                  itemCount: checks.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  physics: const ScrollPhysics(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

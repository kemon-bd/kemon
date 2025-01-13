import '../../../features/whats_new/whats_new.dart';
import '../shared.dart';

class WhatsNewAlert extends StatefulWidget {
  final String hash;
  final List<WhatsNewEntity> updates;
  const WhatsNewAlert({
    super.key,
    required this.hash,
    required this.updates,
  });

  @override
  State<WhatsNewAlert> createState() => _WhatsNewAlertState();
}

class _WhatsNewAlertState extends State<WhatsNewAlert> {
  @override
  void initState() {
    super.initState();
    context.read<WhatsNewBloc>().add(UpdateHash(hash: widget.hash));
  }

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
                'Whats\' New',
                style: TextStyles.title(context: context, color: theme.positive),
              ),
              Divider(height: 16, thickness: .25, color: theme.backgroundTertiary),
              Container(
                constraints: BoxConstraints(
                  maxHeight: context.height * 0.5,
                ),
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    final update = widget.updates[index];
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      leading: CircleAvatar(
                        backgroundColor: update.type.color.withAlpha(25),
                        child: Icon(update.type.icon, color: update.type.color),
                      ),
                      title: Text(
                        update.title,
                        style: TextStyles.subTitle(context: context, color: theme.textPrimary),
                      ),
                      subtitle: update.description != null
                          ? Text(
                              update.description!,
                              style: TextStyles.caption(context: context, color: theme.textSecondary),
                            )
                          : null,
                    );
                  },
                  separatorBuilder: (_, __) => Divider(height: Dimension.padding.vertical.large),
                  itemCount: widget.updates.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  physics: const ScrollPhysics(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: context.width,
                child: ElevatedButton(
                  onPressed: context.pop,
                  child: Text(
                    'Continue',
                    style: TextStyles.caption(context: context, color: theme.white).copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

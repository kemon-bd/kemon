import '../../../features/whats_new/whats_new.dart';
import '../shared.dart';

class NewUpdateDialog extends StatelessWidget {
  final String version;
  final List<WhatsNewEntity> updates;
  const NewUpdateDialog({
    super.key,
    required this.version,
    required this.updates,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final darkMode = state.mode == ThemeMode.dark;
        return Container(
          decoration: BoxDecoration(
            color: darkMode ? theme.backgroundSecondary : theme.backgroundPrimary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.textPrimary,
              width: darkMode ? 1 : 1,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16).copyWith(bottom: 16 + context.bottomInset),
            children: [
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                contentPadding: const EdgeInsets.all(0),
                leading: Icon(
                  !Platform.isAndroid ? FontAwesomeIcons.googlePlay : FontAwesomeIcons.appStoreIos,
                  color: theme.primary,
                  size: 20,
                ),
                title: Text(
                  "Update Available".toUpperCase(),
                  style: context.text.titleLarge?.copyWith(
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Chip(
                  backgroundColor: theme.primary,
                  side: BorderSide.none,
                  padding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                  label: Text(
                    "v$version",
                    style: context.text.labelSmall?.copyWith(
                      color: theme.white,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
              const Divider(height: 16, thickness: 1),
              Container(
                constraints: BoxConstraints(
                  maxWidth: context.width,
                  minWidth: context.width,
                  maxHeight: context.height * .5,
                  minHeight: 0,
                ),
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    final update = updates[index];
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                      leading: CircleAvatar(
                        backgroundColor: update.type.color.withAlpha(25),
                        child: Icon(update.type.icon, color: update.type.color),
                      ),
                      title: Text(
                        update.title,
                        style: context.text.bodyLarge?.copyWith(
                          color: theme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: update.description != null
                          ? Text(
                              update.description!,
                              style: context.text.bodyMedium?.copyWith(
                                color: theme.textSecondary,
                                fontWeight: FontWeight.normal,
                                height: 1.1,
                              ),
                            )
                          : null,
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(height: .1),
                  itemCount: updates.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const ScrollPhysics(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    launchUrlString(
                      Platform.isAndroid ? ExternalLinks.playStore : ExternalLinks.appStore,
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  icon: Icon(Platform.isAndroid ? FontAwesomeIcons.googlePlay : FontAwesomeIcons.appStore, color: theme.black),
                  label: Text(
                    "Update Now".toUpperCase(),
                    style: context.text.titleMedium?.copyWith(
                      color: theme.black,
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

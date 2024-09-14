import '../../../../../core/shared/shared.dart';

class ProfilePreferenceWidget extends StatelessWidget {
  const ProfilePreferenceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final themeMode = state.mode;
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Text(
              'Preferences',
              style: TextStyles.subTitle(
                  context: context, color: theme.textSecondary.withAlpha(100)),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: theme.backgroundSecondary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.backgroundTertiary, width: .25),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.antiAlias,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 16,
                      backgroundColor: themeMode == ThemeMode.dark
                          ? Colors.indigoAccent
                          : Colors.lightBlue,
                      child: Icon(
                        themeMode == ThemeMode.dark
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        color: theme.white,
                        size: 16,
                      ),
                    ),
                    title: Text(
                      'Theme',
                      style: TextStyles.title(
                          context: context, color: theme.textPrimary),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_rounded,
                        size: 12, color: theme.backgroundTertiary),
                    onTap: () {
                      context.read<ThemeBloc>().add(const ToggleTheme());
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  Divider(
                      height: .15,
                      thickness: .15,
                      color: theme.backgroundTertiary),
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.pinkAccent,
                      child: Icon(Icons.privacy_tip_rounded,
                          color: Colors.white, size: 16),
                    ),
                    title: Text(
                      'Privacy policy',
                      style: TextStyles.title(
                          context: context, color: theme.textPrimary),
                    ),
                    trailing: Icon(Icons.open_in_new_rounded,
                        color: theme.backgroundTertiary, size: 16),
                    onTap: () {
                      launchUrlString(ExternalLinks.privacyPolicy);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  Divider(
                      height: .15,
                      thickness: .15,
                      color: theme.backgroundTertiary),
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.indigoAccent,
                      child: Icon(Icons.policy_rounded,
                          color: Colors.white, size: 16),
                    ),
                    title: Text(
                      'Terms and conditions',
                      style: TextStyles.title(
                          context: context, color: theme.textPrimary),
                    ),
                    trailing: Icon(Icons.open_in_new_rounded,
                        color: theme.backgroundTertiary, size: 16),
                    onTap: () {
                      launchUrlString(ExternalLinks.termsAndConditions);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

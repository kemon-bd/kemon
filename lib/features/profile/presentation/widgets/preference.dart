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
          padding: EdgeInsets.all(Dimension.radius.sixteen),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Text(
              'Preferences',
              style: TextStyles.subTitle(
                  context: context, color: theme.textSecondary.withAlpha(100)),
            ),
            SizedBox(height: Dimension.padding.vertical.medium),
            Container(
              decoration: BoxDecoration(
                color: theme.backgroundSecondary,
                borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
                border: Border.all(color: theme.backgroundTertiary, width: .25),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    vertical: Dimension.padding.vertical.small),
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.antiAlias,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: Dimension.radius.sixteen,
                      backgroundColor: themeMode == ThemeMode.dark
                          ? Colors.indigoAccent
                          : Colors.lightBlue,
                      child: Icon(
                        themeMode == ThemeMode.dark
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        color: theme.white,
                        size: Dimension.radius.sixteen,
                      ),
                    ),
                    title: Text(
                      'Theme',
                      style: TextStyles.overline(
                          context: context, color: theme.textPrimary),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_rounded,
                        size: Dimension.radius.sixteen,
                        color: theme.backgroundTertiary),
                    onTap: () {
                      context.read<ThemeBloc>().add(const ToggleTheme());
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimension.radius.sixteen)),
                  ),
                  Divider(
                      height: Dimension.padding.vertical.small,
                      thickness: .5,
                      color: theme.backgroundTertiary),
                  ListTile(
                    leading: CircleAvatar(
                      radius: Dimension.radius.sixteen,
                      backgroundColor: Colors.pinkAccent,
                      child: Icon(Icons.privacy_tip_rounded,
                          color: Colors.white, size: Dimension.radius.sixteen),
                    ),
                    title: Text(
                      'Privacy policy',
                      style: TextStyles.overline(
                          context: context, color: theme.textPrimary),
                    ),
                    trailing: Icon(Icons.open_in_new_rounded,
                        color: theme.backgroundTertiary,
                        size: Dimension.radius.sixteen),
                    onTap: () {
                      launchUrlString(ExternalLinks.privacyPolicy);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  Divider(
                      height: Dimension.padding.vertical.small,
                      thickness: .5,
                      color: theme.backgroundTertiary),
                  ListTile(
                    leading: CircleAvatar(
                      radius: Dimension.radius.sixteen,
                      backgroundColor: Colors.indigoAccent,
                      child: Icon(Icons.policy_rounded,
                          color: theme.white, size: Dimension.radius.sixteen),
                    ),
                    title: Text(
                      'Terms and conditions',
                      style: TextStyles.overline(
                          context: context, color: theme.textPrimary),
                    ),
                    trailing: Icon(Icons.open_in_new_rounded,
                        color: theme.backgroundTertiary,
                        size: Dimension.radius.sixteen),
                    onTap: () {
                      launchUrlString(ExternalLinks.termsAndConditions);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimension.radius.sixteen)),
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

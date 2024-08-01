import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../../profile/profile.dart';

class DashboardMenuWidget extends StatelessWidget {
  const DashboardMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final themeMode = state.mode;
        final avatar = Icon(
          Icons.account_circle_outlined,
          size: 42,
          color: theme.textPrimary,
        );

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
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    final profile = state.profile;
                    final username = state.username;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (profile?.profilePicture ?? '').isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: CachedNetworkImage(
                                  imageUrl: profile!.profilePicture!.url,
                                  width: 42,
                                  height: 42,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const ShimmerIcon(radius: 42),
                                  errorWidget: (context, url, error) => avatar,
                                ),
                              )
                            : avatar,
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile?.name.full ?? "Login for more information.",
                                style: TextStyles.title(context: context, color: theme.textPrimary),
                              ),
                              Text(
                                "@${username.isEmpty ? 'guest' : username}",
                                style: TextStyles.body(context: context, color: theme.primary),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: Icon(Icons.close, color: theme.textPrimary),
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ],
                    );
                  },
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
                      ListTile(
                        leading: CircleAvatar(
                          radius: 16,
                          backgroundColor: themeMode == ThemeMode.dark ? Colors.orange : Colors.teal,
                          child: Icon(
                            themeMode == ThemeMode.dark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        title: Text(
                          'Theme',
                          style: TextStyles.title(context: context, color: theme.textPrimary),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                        onTap: () {
                          context.read<ThemeBloc>().add(const ToggleTheme());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    final bool loggedIn = state.profile != null;
                    return Container(
                      decoration: BoxDecoration(
                        color: loggedIn ? theme.negative.withAlpha(15) : theme.positiveBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: loggedIn ? theme.negative : theme.positiveBackground, width: .25),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 16,
                          backgroundColor: loggedIn ? theme.negative : theme.primary,
                          child: Icon(Icons.logout_rounded, color: theme.backgroundPrimary, size: 16),
                        ),
                        title: Text(
                          loggedIn ? 'Logout' : 'Login',
                          style: TextStyles.title(context: context, color: loggedIn ? theme.negative : theme.positive),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12,
                          color: loggedIn ? theme.negative : theme.positive,
                        ),
                        onTap: () async {
                          if (loggedIn) {
                            context.pop();
                            context.auth.add(const AuthenticationLogout());
                          } else {
                            context.pop();
                            context.pushNamed(CheckProfilePage.name);
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

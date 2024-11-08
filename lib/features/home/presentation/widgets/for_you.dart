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

        return Material(
          child: Container(
            decoration: BoxDecoration(
              color: theme.backgroundPrimary,
              border: Border(
                top: BorderSide(color: theme.textPrimary, width: Dimension.divider.veryLarge),
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: Dimension.padding.horizontal.max,
                vertical: Dimension.padding.vertical.max,
              ).copyWith(
                bottom: Dimension.padding.vertical.max + context.bottomInset,
              ),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    final profile = state.profile;
                    final username = state.username;
                    return InkWell(
                      onTap: () {
                        if (profile != null) {
                          context.pop();
                          context.pushNamed(ProfilePage.name);
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyProfilePictureWidget(size: Dimension.radius.thirtyTwo, showWhenUnAuthorized: true),
                          SizedBox(width: Dimension.padding.horizontal.large),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                profile != null
                                    ? MyProfileNameWidget(
                                        style: TextStyles.title(context: context, color: theme.textPrimary),
                                      )
                                    : Text(
                                        "Login for more information.",
                                        style: TextStyles.title(context: context, color: theme.textPrimary),
                                      ),
                                Text(
                                  "@${profile == null ? 'guest' : username.isEmpty ? 'guest' : username}",
                                  style: TextStyles.body(context: context, color: theme.primary),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: Dimension.padding.horizontal.large),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: theme.textPrimary,
                              size: Dimension.radius.twentyFour,
                            ),
                            onPressed: () {
                              context.pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: Dimension.padding.vertical.large),
                Container(
                  decoration: BoxDecoration(
                    color: theme.backgroundSecondary,
                    borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
                    border: Border.all(color: theme.backgroundTertiary, width: Dimension.divider.normal),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: Dimension.radius.sixteen,
                          backgroundColor: themeMode == ThemeMode.dark ? Colors.orange : Colors.teal,
                          child: Icon(
                            themeMode == ThemeMode.dark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                            color: theme.white,
                            size: Dimension.radius.sixteen,
                          ),
                        ),
                        title: Text(
                          'Theme',
                          style: TextStyles.title(context: context, color: theme.textPrimary),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, size: Dimension.radius.eight),
                        onTap: () {
                          context.read<ThemeBloc>().add(const ToggleTheme());
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimension.padding.vertical.large),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    final bool loggedIn = state.profile != null;
                    return Container(
                      decoration: BoxDecoration(
                        color: loggedIn ? theme.negative.withAlpha(15) : theme.primary.withAlpha(15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: loggedIn ? theme.negative : theme.primary,
                          width: Dimension.divider.veryLarge,
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: Dimension.radius.sixteen,
                          backgroundColor: loggedIn ? theme.negative : theme.primary,
                          child: Icon(Icons.logout_rounded, color: theme.backgroundPrimary, size: Dimension.radius.sixteen),
                        ),
                        title: Text(
                          loggedIn ? 'Logout' : 'Login',
                          style: TextStyles.title(context: context, color: loggedIn ? theme.negative : theme.primary),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: Dimension.radius.eight,
                          color: loggedIn ? theme.negative : theme.primary,
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

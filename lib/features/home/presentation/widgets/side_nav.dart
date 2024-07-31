import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';

class HomeSideNavWidget extends StatelessWidget {
  const HomeSideNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Drawer(
          backgroundColor: theme.backgroundPrimary,
          child: ListView(
            physics: const ScrollPhysics(),
            padding: EdgeInsets.only(top: context.topInset + 16),
            children: [
              ListTile(
                dense: true,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                title: Text(
                  "Categories",
                  style: TextStyles.subTitle(
                      context: context, color: theme.primary),
                ),
                onTap: () {
                  Scaffold.of(context).closeEndDrawer();
                  // context.pushNamed(CategoriesPage.tag);
                },
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state.profile != null) {
                    final profile = state.profile!;
                    return ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const ScrollPhysics(),
                      children: [
                        ListTile(
                          dense: true,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text(
                            profile.name.full,
                            style: TextStyles.subTitle(
                                context: context, color: theme.primary),
                          ),
                          onTap: () async {
                            // context.pushNamed(ProfilePage.tag);
                          },
                        ),
                        ListTile(
                          dense: true,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text(
                            "Logout",
                            style: TextStyles.subTitle(
                                context: context, color: theme.negative),
                          ),
                          onTap: () async {
                            context
                                .read<AuthenticationBloc>()
                                .add(const AuthenticationLogout());
                          },
                        ),
                      ],
                    );
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        ListTile(
                          dense: true,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text(
                            "Login",
                            style: TextStyles.subTitle(
                                context: context, color: theme.primary),
                          ),
                          onTap: () async {
                            // final user = await context.pushNamed<ProfileEntity?>(AuthenticationPage.tag);

                            // if (user != null) {}
                          },
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

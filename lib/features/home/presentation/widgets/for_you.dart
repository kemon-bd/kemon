import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../../profile/profile.dart';
import '../../../search/search.dart';

class DashboardForYouWidget extends StatelessWidget {
  const DashboardForYouWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        final darkMode = state.mode == ThemeMode.dark;

        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            horizontal: Dimension.padding.horizontal.max,
          ),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state.profile == null) {
                  return Container(
                    margin: EdgeInsets.only(bottom: Dimension.padding.vertical.max),
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimension.padding.horizontal.large,
                      vertical: Dimension.padding.vertical.large,
                    ),
                    decoration: BoxDecoration(
                      color: darkMode ? theme.backgroundSecondary : theme.backgroundPrimary,
                      border: Border.all(
                        color: darkMode ? theme.backgroundSecondary : theme.textPrimary,
                        width: darkMode ? 0 : .5,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      borderRadius: BorderRadius.circular(Dimension.radius.twentyFour),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          children: [1, 2, 3, 4, 5]
                              .map(
                                (index) => Transform.rotate(
                                  angle: (pi / 12) * (index.isOdd ? -1 : 1),
                                  child: Image.asset(
                                    'images/logo/full.png',
                                    width: Dimension.radius.thirty,
                                    height: Dimension.radius.thirty,
                                    color: theme.textSecondary.withAlpha(darkMode ? 150 : 100),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        SizedBox(height: Dimension.padding.vertical.large),
                        Text(
                          "Join for free and explore all of KEMON.",
                          style: context.text.bodySmall?.copyWith(color: theme.textSecondary),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Dimension.padding.vertical.large),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await sl<FirebaseAnalytics>().logEvent(
                                name: 'home_for_you_login',
                                parameters: {
                                  'id': context.auth.profile?.identity.id ?? 'anonymous',
                                  'name': context.auth.profile?.name.full ?? 'Guest',
                                },
                              );
                              if (!context.mounted) return;
                              final bool? loggedIn = await context.pushNamed<bool>(CheckProfilePage.name);
                              if (loggedIn == true && context.mounted) {
                                context.pushNamed(ProfilePage.name);
                              }
                            },
                            child: Text(
                              "Get Started".toUpperCase(),
                              style: context.text.titleMedium?.copyWith(
                                color: theme.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.link.withGreen(5).withRed(25).withBlue(50),
                border: Border.all(
                  width: darkMode ? 1.5 : 2.5,
                  color: darkMode ? theme.backgroundTertiary : theme.link.withGreen(5).withRed(25).withBlue(50),
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                borderRadius: BorderRadius.circular(Dimension.radius.twentyFour),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimension.padding.horizontal.max,
                            vertical: Dimension.padding.vertical.large,
                          ),
                          child: Text(
                            'Bought something recently?',
                            style: context.text.headlineSmall?.copyWith(
                              color: theme.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: theme.backgroundSecondary,
                          child: CachedNetworkImage(
                            imageUrl: 'https://kemon.com.bd/images/top_bg_man.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(border: Border(top: BorderSide(color: theme.white.withAlpha(150), width: .15))),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.white,
                      ),
                      onPressed: () async {
                        await sl<FirebaseAnalytics>().logEvent(
                          name: 'home_write_a_review',
                          parameters: {
                            'id': context.auth.profile?.identity.id ?? 'anonymous',
                            'name': context.auth.profile?.name.full ?? 'Guest',
                          },
                        );
                        if (!context.mounted) return;
                        context.pushNamed(SearchPage.name);
                      },
                      child: Text(
                        "Write a review".toUpperCase(),
                        style: context.text.titleMedium?.copyWith(
                          color: theme.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimension.padding.vertical.max),
          ],
        );
      },
    );
  }
}

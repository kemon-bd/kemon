import 'package:kemon/features/profile/profile.dart';

import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../leaderboard/leaderboard.dart';
import '../../../location/location.dart';
import '../../../review/review.dart';
import '../../../search/search.dart';
import '../../../version/version.dart';
import '../../../whats_new/whats_new.dart';
import '../../home.dart';

class HomePage extends StatefulWidget {
  static const String path = '/';
  static const String name = 'HomePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<WhatsNewBloc>().add(const CheckForUpdate());
    context.read<FindVersionBloc>().add(FindVersion(context: context));
    FirebaseMessaging.onMessage.listen(firebaseHandler);
    sl<FirebaseAnalytics>().logScreenView(
      screenName: "Home",
      parameters: {
        'id': context.auth.profile?.identity.id ?? 'anonymous',
        'name': context.auth.profile?.name.full ?? 'Guest',
      },
    );

    if (kReleaseMode) {
      InAppUpdate.checkForUpdate().then(
        (event) async {
          if (event.updateAvailability == UpdateAvailability.updateAvailable) {
            await InAppUpdate.performImmediateUpdate();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final themeMode = state.mode;
        return MultiBlocListener(
          listeners: [
            BlocListener<WhatsNewBloc, WhatsNewState>(
              listener: (context, state) {
                if (state is NewUpdate) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => WhatsNewAlert(updates: state.updates, hash: state.hash),
                  );
                }
              },
            ),
          ],
          child: Scaffold(
            backgroundColor: theme.backgroundPrimary,
            appBar: AppBar(
              backgroundColor: theme.primary,
              surfaceTintColor: theme.primary,
              titleSpacing: Dimension.size.horizontal.sixteen,
              title: InkWell(
                onTap: () async {
                  context.read<OverviewBloc>().add(FetchOverview());
                  await sl<FirebaseAnalytics>().logEvent(
                    name: 'home_logo',
                    parameters: {
                      'id': context.auth.profile?.identity.id ?? 'anonymous',
                      'name': context.auth.profile?.name.full ?? 'Guest',
                    },
                  );
                },
                borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
                child: Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'images/logo/full.png',
                      width: context.text.headlineMedium?.fontSize,
                      height: context.text.headlineMedium?.fontSize,
                      fit: BoxFit.contain,
                      color: theme.white,
                    ),
                    Text(
                      'KEMON',
                      style: context.text.headlineMedium?.copyWith(color: theme.white),
                    ),
                  ],
                ),
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: () async {
                    context.pushNamed(LeaderboardPage.name);
                    await sl<FirebaseAnalytics>().logEvent(
                      name: 'home_leaderboard',
                      parameters: {
                        'id': context.auth.profile?.identity.id ?? 'anonymous',
                        'name': context.auth.profile?.name.full ?? 'Guest',
                      },
                    );
                  },
                  padding: EdgeInsets.all(0),
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  icon: CircleAvatar(
                    radius: Dimension.radius.sixteen,
                    backgroundColor: theme.white,
                    child: Icon(
                      Icons.leaderboard_rounded,
                      color: theme.primary,
                      size: Dimension.radius.sixteen,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    context.read<ThemeBloc>().add(const ToggleTheme());
                    await sl<FirebaseAnalytics>().logEvent(
                      name: 'home_theme',
                      parameters: {
                        'id': context.auth.profile?.identity.id ?? 'anonymous',
                        'name': context.auth.profile?.name.full ?? 'Guest',
                        'theme': themeMode == ThemeMode.dark ? 'light' : 'dark',
                      },
                    );
                  },
                  icon: CircleAvatar(
                    radius: Dimension.radius.sixteen,
                    backgroundColor: theme.white,
                    child: Icon(
                      themeMode == ThemeMode.dark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      color: theme.primary,
                      size: Dimension.radius.sixteen,
                    ),
                  ),
                ),
                MyProfilePictureWidget(
                  size: Dimension.radius.thirtyTwo,
                  border: Dimension.divider.veryLarge,
                  borderColor: theme.white,
                  showWhenUnAuthorized: true,
                  onTap: () async {
                    await sl<FirebaseAnalytics>().logEvent(
                      name: 'home_avatar',
                      parameters: {
                        'id': context.auth.profile?.identity.id ?? 'anonymous',
                        'name': context.auth.profile?.name.full ?? 'Guest',
                        'loggedIn': (context.auth.profile != null).toString(),
                      },
                    );
                    if (!context.mounted) return;
                    if (context.auth.authenticated) {
                      context.pushNamed(ProfilePage.name);
                    } else {
                      final bool? loggedIn = await context.pushNamed(CheckProfilePage.name) as bool?;
                      if (loggedIn == true && context.mounted) {
                        context.pushNamed(ProfilePage.name);
                      }
                    }
                  },
                ),
                const SizedBox(width: 16),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<OverviewBloc>().add(FetchOverview());
                await sl<FirebaseAnalytics>().logEvent(
                  name: 'home_refresh',
                  parameters: {
                    'id': context.auth.profile?.identity.id ?? 'anonymous',
                    'name': context.auth.profile?.name.full ?? 'Guest',
                  },
                );
              },
              child: ListView(
                shrinkWrap: false,
                padding: EdgeInsets.zero,
                children: const [
                  DashboardSearchWidget(),
                  DashboardForYouWidget(),
                  FeaturedCategoriesWidget(),
                  FeaturedLocationsWidget(),
                  FeaturedReviewsWidget(),
                  FeaturedListingsWidget(),
                  HomeFooterWidget(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

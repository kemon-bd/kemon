import 'package:kemon/features/profile/profile.dart';

import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../leaderboard/leaderboard.dart';
import '../../../location/location.dart';
import '../../../review/review.dart';
import '../../../search/search.dart';
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
                  context.read<FeaturedCategoriesBloc>().add(const FeaturedCategories());
                  context.read<RecentReviewsBloc>().add(const RecentReviews());
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'images/logo/full.png',
                      width: Dimension.radius.twentyFour,
                      height: Dimension.radius.twentyFour,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: Dimension.size.horizontal.eight),
                    Text(
                      'KEMON',
                      style: TextStyles.title(context: context, color: theme.white),
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
            body: ListView(
              shrinkWrap: false,
              padding: EdgeInsets.zero,
              children: const [
                DashboardSearchWidget(),
                DashboardForYouWidget(),
                FeaturedCategoriesWidget(),
                FeaturedLocationsWidget(),
                FeaturedReviewsWidget(),
                HomeFooterWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}

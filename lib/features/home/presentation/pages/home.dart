import 'package:kemon/features/profile/profile.dart';

import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../review/review.dart';
import '../../../search/search.dart';
import '../../../whats_new/whats_new.dart';

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
    ScreenUtil.init(
      context,
      designSize: Size(
        Dimension.size.horizontal.max,
        Dimension.size.vertical.max,
      ),
    );
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
                onTap: () {
                  context.read<FeaturedCategoriesBloc>().add(const FeaturedCategories());
                  context.read<RecentReviewsBloc>().add(const RecentReviews());
                },
                borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'images/logo/full.png',
                      width: Dimension.size.horizontal.tweenty,
                      height: Dimension.size.vertical.tweenty,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: Dimension.size.horizontal.eight),
                    const Text('KEMON'),
                  ],
                ),
              ),
              titleTextStyle: TextStyles.headline(context: context, color: theme.white).copyWith(
                fontWeight: FontWeight.bold,
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<ThemeBloc>().add(const ToggleTheme());
                  },
                  icon: CircleAvatar(
                    radius: Dimension.radius.sixteen,
                    backgroundColor: themeMode == ThemeMode.dark ? theme.black : theme.white,
                    child: Icon(
                      themeMode == ThemeMode.dark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      color: theme.primary,
                      size: Dimension.radius.sixteen,
                    ),
                  ),
                ),
                MyProfilePictureWidget(
                  size: Dimension.radius.thirty,
                  border: Dimension.divider.veryLarge,
                  borderColor: theme.white,
                  showWhenUnAuthorized: true,
                  onTap: () async {
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
              padding: EdgeInsets.zero.copyWith(
                bottom: context.bottomInset + Dimension.padding.vertical.max,
              ),
              children: const [
                DashboardSearchWidget(),
                DashboardFeaturedCategoriesSectionWidget(),
                FeaturedReviewsWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}

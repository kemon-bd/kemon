import 'package:kemon/features/profile/profile.dart';

import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../location/location.dart';
import '../../../review/review.dart';
import '../../../search/search.dart';
import '../../home.dart';

class HomePage extends StatefulWidget {
  static const String path = '/home';
  static const String name = 'HomePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

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
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          endDrawer: const HomeSideNavWidget(),
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: theme.primary,
            surfaceTintColor: theme.primary,
            leading: Image.asset(
              'images/logo/full.png',
              height: 24,
              width: 24,
              fit: BoxFit.cover,
            ),
            title: const Text('KEMON'),
            titleTextStyle: TextStyles.headline(context: context, color: theme.white).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            centerTitle: false,
            actions: [
              MyProfilePictureWidget(
                size: 32,
                border: .25,
                borderColor: Colors.white,
                onTap: () {
                  context.pushNamed(ProfilePage.name);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: theme.white,
                  size: 24.0,
                  grade: 200,
                  weight: 700,
                ),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    barrierColor: context.barrierColor,
                    barrierDismissible: true,
                    builder: (_) => const DashboardMenuWidget(),
                  );
                },
              ),
            ],
          ),
          body: ListView(
            shrinkWrap: false,
            padding: EdgeInsets.zero,
            children: const [
              DashboardSearchSectionWidget(),
              DashboardFeaturedCategoriesSectionWidget(),
              DashboardFeaturedLocationsSectionWidget(),
              DashboardRecentReviewsSectionWidget(),
            ],
          ),
        );
      },
    );
  }
}

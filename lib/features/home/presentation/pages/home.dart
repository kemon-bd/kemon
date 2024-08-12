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
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            backgroundColor: theme.primary,
            surfaceTintColor: theme.primary,
            leading: Image.asset(
              'images/logo/full.png',
              width: Dimension.size.horizontal.twentyFour,
              height: Dimension.size.vertical.twentyFour,
              fit: BoxFit.cover,
            ),
            title: const Text('KEMON'),
            titleTextStyle: TextStyles.headline(context: context, color: theme.white).copyWith(
              fontWeight: FontWeight.bold,
            ),
            centerTitle: false,
            actions: [
              MyProfilePictureWidget(
                size: Dimension.radius.thirtyTwo,
                border: Dimension.divider.normal,
                borderColor: theme.white,
                onTap: () {
                  context.pushNamed(ProfilePage.name);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: theme.white,
                  size: Dimension.size.horizontal.twentyFour,
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
            padding: EdgeInsets.zero.copyWith(
              bottom: context.bottomInset + Dimension.padding.vertical.max,
            ),
            children: const [
              DashboardSearchSectionWidget(),
              DashboardFeaturedCategoriesSectionWidget(),
              DashboardFeaturedLocationsSectionWidget(),
              FeaturedReviewsWidget(),
            ],
          ),
        );
      },
    );
  }
}

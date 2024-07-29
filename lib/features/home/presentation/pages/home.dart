import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../location/location.dart';
import '../../../review/review.dart';
import '../../../search/search.dart';

class HomePage extends StatelessWidget {
  static const String path = '/home';
  static const String name = 'HomePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
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
            titleTextStyle: TextStyles.headline(context: context, color: theme.backgroundPrimary).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: theme.backgroundPrimary,
                  size: 24.0,
                  grade: 200,
                  weight: 700,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
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

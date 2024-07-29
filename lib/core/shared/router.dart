import '../../features/category/category.dart';
import '../../features/home/home.dart';
import '../../features/location/location.dart';
import '../../features/login/login.dart';
import '../../features/profile/profile.dart';
import '../../features/review/review.dart';
import '../../features/search/search.dart';
import '../config/config.dart';
import 'shared.dart';

final router = GoRouter(
  initialLocation: HomePage.path,
  routes: [
    GoRoute(
      path: HomePage.path,
      name: HomePage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<FeaturedCategoriesBloc>()..add(const FeaturedCategories())),
          BlocProvider(create: (context) => sl<FeaturedLocationsBloc>()..add(const FeaturedLocations())),
          BlocProvider(create: (context) => sl<RecentReviewsBloc>()..add(const RecentReviews())),
          BlocProvider(create: (context) => sl<CheckProfileBloc>()),
          BlocProvider(create: (context) => sl<LoginBloc>()),
        ],
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: LoginPage.path,
      name: LoginPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<CheckProfileBloc>()),
          BlocProvider(create: (context) => sl<LoginBloc>()),
        ],
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: SearchPage.path,
      name: SearchPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<SearchSuggestionBloc>()),
        ],
        child: const SearchPage(),
      ),
    ),
  ],
);

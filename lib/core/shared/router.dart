import '../../features/business/business.dart';
import '../../features/category/category.dart';
import '../../features/home/home.dart';
import '../../features/industry/industry.dart';
import '../../features/location/location.dart';
import '../../features/login/login.dart';
import '../../features/profile/profile.dart';
import '../../features/review/review.dart';
import '../../features/search/search.dart';
import '../../features/sub_category/sub_category.dart';
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
    GoRoute(
      path: ResultPage.path,
      name: ResultPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<SearchResultBloc>()
              ..add(
                SearchResult(
                  query: state.uri.queryParameters['query']!,
                  filter: (
                    category: null,
                    subCategory: null,
                    division: null,
                    district: null,
                    thana: null,
                    industry: null,
                    sortBy: null,
                    filterBy: null,
                  ),
                ),
              ),
          ),
        ],
        child: ResultPage(
          query: state.uri.queryParameters['query']!,
        ),
      ),
    ),
    GoRoute(
      path: BusinessPage.path,
      name: BusinessPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindBusinessBloc>()
              ..add(
                FindBusiness(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(
            create: (context) => sl<FindRatingBloc>()
              ..add(
                FindRating(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(
            create: (context) => sl<FindListingReviewsBloc>()
              ..add(
                FindListingReviews(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
        ],
        child: BusinessPage(
          urlSlug: state.pathParameters['urlSlug']!,
        ),
      ),
    ),
    GoRoute(
      path: IndustryPage.path,
      name: IndustryPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindIndustryBloc>()
              ..add(
                FindIndustry(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(
            create: (context) => sl<FindBusinessesByCategoryBloc>()
              ..add(
                FindBusinessesByCategory(category: state.pathParameters['urlSlug']!),
              ),
          ),
        ],
        child: IndustryPage(
          urlSlug: state.pathParameters['urlSlug']!,
        ),
      ),
    ),
    GoRoute(
      path: CategoryPage.path,
      name: CategoryPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindCategoryBloc>()
              ..add(
                FindCategory(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(
            create: (context) => sl<FindBusinessesByCategoryBloc>()
              ..add(
                FindBusinessesByCategory(category: state.pathParameters['urlSlug']!),
              ),
          ),
        ],
        child: CategoryPage(
          urlSlug: state.pathParameters['urlSlug']!,
        ),
      ),
    ),
    GoRoute(
      path: SubCategoryPage.path,
      name: SubCategoryPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindSubCategoryBloc>()
              ..add(
                FindSubCategory(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(
            create: (context) => sl<FindBusinessesByCategoryBloc>()
              ..add(
                FindBusinessesByCategory(category: state.pathParameters['urlSlug']!),
              ),
          ),
        ],
        child: SubCategoryPage(
          urlSlug: state.pathParameters['urlSlug']!,
        ),
      ),
    ),
  ],
);

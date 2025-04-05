import '../../features/business/business.dart';
import '../../features/category/category.dart';
import '../../features/home/home.dart';
import '../../features/industry/industry.dart';
import '../../features/leaderboard/leaderboard.dart';
import '../../features/location/location.dart';
import '../../features/login/login.dart';
import '../../features/lookup/lookup.dart';
import '../../features/profile/profile.dart';
import '../../features/registration/registration.dart';
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
          BlocProvider(create: (context) => sl<OverviewBloc>()..add(const FetchOverview())),
        ],
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: LoginPage.path,
      name: LoginPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindProfileBloc>()
              ..add(
                FindProfile(identity: Identity.guid(guid: state.uri.queryParameters['guid']!)),
              ),
          ),
          BlocProvider(create: (context) => sl<LoginBloc>()),
        ],
        child: LoginPage(
          username: state.uri.queryParameters['username']!,
          authorize: bool.tryParse(state.uri.queryParameters['authorize'] ?? ''),
        ),
      ),
      redirect: (context, state) => state.uri.queryParameters.containsKey('guid') ? null : CheckProfilePage.path,
    ),
    GoRoute(
      path: CheckProfilePage.path,
      name: CheckProfilePage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<CheckProfileBloc>()),
          BlocProvider(create: (context) => sl<FacebookLoginBloc>()),
          BlocProvider(create: (context) => sl<AppleLoginBloc>()),
          BlocProvider(create: (context) => sl<GoogleSignInBloc>()),
        ],
        child: CheckProfilePage(
          authorize: bool.tryParse(state.uri.queryParameters['authorize'] ?? '') ?? false,
        ),
      ),
    ),
    GoRoute(
      path: VerifyOTPPage.path,
      name: VerifyOTPPage.name,
      builder: (_, state) => BlocProvider(
        create: (_) => sl<OtpBloc>(),
        child: VerifyOTPPage(
          otp: state.uri.queryParameters['otp']!,
          username: state.uri.queryParameters['username']!,
          authorize: bool.tryParse(state.uri.queryParameters['authorize'] ?? '') ?? false,
        ),
      ),
    ),
    GoRoute(
      path: RegistrationPage.path,
      name: RegistrationPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<RegistrationBloc>(),
          ),
        ],
        child: RegistrationPage(
          username: state.uri.queryParameters['username']!,
          authorize: bool.tryParse(state.uri.queryParameters['authorize'] ?? '') ?? false,
        ),
      ),
    ),
    GoRoute(
      path: ProfilePage.path,
      name: ProfilePage.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: context.auth.identity!)),
        child: const ProfilePage(),
      ),
    ),
    GoRoute(
      path: ForgotPasswordPage.path,
      name: ForgotPasswordPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<RequestOtpForPasswordChangeBloc>()),
          BlocProvider(create: (context) => sl<ResetPasswordBloc>()),
        ],
        child: ForgotPasswordPage(),
      ),
    ),
    GoRoute(
      path: ChangePasswordPage.path,
      name: ChangePasswordPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<RequestOtpForPasswordChangeBloc>()
              ..add(
                RequestOtpForPasswordChange(username: context.auth.username!),
              ),
          ),
          BlocProvider(create: (context) => sl<ResetPasswordBloc>()),
        ],
        child: ChangePasswordPage(),
      ),
    ),
    GoRoute(
      path: DeactivateAccountPage.path,
      name: DeactivateAccountPage.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<DeactivateAccountBloc>(),
        child: DeactivateAccountPage(
          otp: state.uri.queryParameters['otp']!,
        ),
      ),
    ),
    GoRoute(
      path: PublicProfilePage.path,
      name: PublicProfilePage.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<FindProfileBloc>()
          ..add(
            FindProfile(
              identity: Identity.guid(guid: state.pathParameters['user']!),
            ),
          ),
        child: PublicProfilePage(
          identity: Identity.guid(guid: state.pathParameters['user']!),
        ),
      ),
    ),
    GoRoute(
      path: BlockedAccountsPage.path,
      name: BlockedAccountsPage.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<BlockListBloc>()..add(FindBlockList()),
        child: BlockedAccountsPage(),
      ),
    ),
    GoRoute(
      path: EditProfilePage.path,
      name: EditProfilePage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: context.auth.identity!)),
          ),
          BlocProvider(create: (context) => sl<UpdateProfileBloc>()),
        ],
        child: const EditProfilePage(),
      ),
    ),
    GoRoute(
      path: UserReviewsPage.path,
      name: UserReviewsPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindProfileBloc>()
              ..add(
                FindProfile(
                  identity: Identity.guid(guid: state.pathParameters['user']!),
                ),
              ),
          ),
          BlocProvider(
            create: (context) => sl<FindUserReviewsBloc>()
              ..add(
                FindUserReviews(
                  user: Identity.guid(guid: state.pathParameters['user']!),
                ),
              ),
          ),
        ],
        child: UserReviewsPage(
          identity: Identity.guid(guid: state.pathParameters['user']!),
        ),
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
        ],
        child: BusinessPage(
          urlSlug: state.pathParameters['urlSlug']!,
        ),
      ),
    ),
    GoRoute(
      path: NewListingPage.path,
      name: NewListingPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<ValidateUrlSlugBloc>()),
          BlocProvider(create: (context) => sl<FindIndustriesBloc>()..add(FindIndustries())),
          BlocProvider(create: (context) => sl<FindCategoriesByIndustryBloc>()),
          BlocProvider(create: (context) => sl<SubCategoriesByCategoryBloc>()),
          BlocProvider(create: (context) => sl<DivisionsBloc>()..add(FindDivisions())),
          BlocProvider(create: (context) => sl<DistrictsBloc>()),
          BlocProvider(create: (context) => sl<ThanasBloc>()),
          BlocProvider(create: (context) => sl<NewListingBloc>()),
        ],
        child: NewListingPage(
          suggestion: state.uri.queryParameters['suggestion'],
        ),
      ),
    ),
    GoRoute(
      path: NewReviewPage.path,
      name: NewReviewPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindBusinessBloc>()
              ..add(
                FindBusiness(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(create: (context) => sl<CreateReviewBloc>()),
        ],
        child: NewReviewPage(
          urlSlug: state.pathParameters['urlSlug']!,
          rating: double.tryParse(state.uri.queryParameters['rating'] ?? '') ?? 0.0,
        ),
      ),
    ),
    GoRoute(
      path: EditReviewPage.path,
      name: EditReviewPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindBusinessBloc>()
              ..add(
                FindBusiness(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(create: (context) => sl<UpdateReviewBloc>()),
        ],
        child: EditReviewPage(
          urlSlug: state.pathParameters['urlSlug']!,
          review: state.extra as UserReviewEntity,
        ),
      ),
    ),
    GoRoute(
      path: PhotoPreviewPage.path,
      name: PhotoPreviewPage.name,
      builder: (context, state) => PhotoPreviewPage(
        url: state.pathParameters['url']!.split(','),
        index: int.tryParse(state.uri.queryParameters['index'] ?? '') ?? 0,
      ),
    ),
    GoRoute(
      path: IndustryPage.path,
      name: IndustryPage.name,
      builder: (context, state) {
        final industry = Identity.guid(guid: state.uri.queryParameters['industry']!);
        return MultiBlocProvider(
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
                  FindBusinessesByCategory(
                    industry: industry,
                  ),
                ),
            ),
          ],
          child: IndustryPage(industry: industry),
        );
      },
    ),
    GoRoute(
      path: CategoriesPage.path,
      name: CategoriesPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindAllCategoriesBloc>()..add(FindAllCategories(query: null)),
          ),
        ],
        child: CategoriesPage(),
      ),
    ),
    GoRoute(
      path: CategoryPage.path,
      name: CategoryPage.name,
      builder: (context, state) {
        final industry = Identity.guid(guid: state.uri.queryParameters['industry']!);
        final category = Identity.guid(guid: state.uri.queryParameters['category']!);
        return MultiBlocProvider(
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
                  FindBusinessesByCategory(industry: industry, category: category),
                ),
            ),
          ],
          child: CategoryPage(
            category: category,
            industry: industry,
          ),
        );
      },
    ),
    GoRoute(
      path: DivisionPage.path,
      name: DivisionPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindLookupBloc>()..add(FindLookup(lookup: Lookups.division)),
          ),
          BlocProvider(
            create: (context) => sl<FindBusinessesByLocationBloc>()
              ..add(
                FindBusinessesByLocation(
                  division: state.pathParameters['division']!,
                ),
              ),
          ),
        ],
        child: DivisionPage(
          division: state.pathParameters['division']!,
        ),
      ),
    ),
    GoRoute(
      path: DistrictPage.path,
      name: DistrictPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindLookupBloc>()
              ..add(FindLookupWithParent(
                lookup: Lookups.district,
                parent: state.pathParameters['division']!,
              )),
          ),
          BlocProvider(
            create: (context) => sl<FindBusinessesByLocationBloc>()
              ..add(
                FindBusinessesByLocation(
                  division: state.pathParameters['division']!,
                  district: state.pathParameters['district'],
                ),
              ),
          ),
        ],
        child: DistrictPage(
          division: state.pathParameters['division']!,
          district: state.pathParameters['district']!,
        ),
      ),
    ),
    GoRoute(
      path: ThanaPage.path,
      name: ThanaPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindLookupBloc>()
              ..add(FindLookupWithParent(
                lookup: Lookups.thana,
                parent: state.pathParameters['district']!,
              )),
          ),
          BlocProvider(
            create: (context) => sl<FindBusinessesByLocationBloc>()
              ..add(
                FindBusinessesByLocation(
                  division: state.pathParameters['division']!,
                  district: state.pathParameters['district']!,
                  thana: state.pathParameters['thana']!,
                ),
              ),
          ),
        ],
        child: ThanaPage(
          division: state.pathParameters['division']!,
          district: state.pathParameters['district']!,
          thana: state.pathParameters['thana']!,
        ),
      ),
    ),
    GoRoute(
      path: LocationsPage.path,
      name: LocationsPage.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<FindAllLocationsBloc>()..add(FindAllLocations()),
        child: LocationsPage(),
      ),
    ),
    GoRoute(
      path: SubCategoryPage.path,
      name: SubCategoryPage.name,
      builder: (context, state) {
        final industry = Identity.guid(guid: state.uri.queryParameters['industry']!);
        final category = Identity.guid(guid: state.uri.queryParameters['category']!);
        final subCategory = Identity.guid(guid: state.uri.queryParameters['subCategory']!);
        return MultiBlocProvider(
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
                  FindBusinessesByCategory(
                    industry: industry,
                    category: category,
                    subCategory: subCategory,
                  ),
                ),
            ),
          ],
          child: SubCategoryPage(
            subCategory: subCategory,
            category: category,
            industry: industry,
          ),
        );
      },
    ),
    GoRoute(
      path: LeaderboardPage.path,
      name: LeaderboardPage.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<FindLeaderboardBloc>()..add(FindLeaderboard(query: '')),
        child: const LeaderboardPage(),
      ),
    ),
    GoRoute(
      path: PrivacyPolicyPage.path,
      name: PrivacyPolicyPage.name,
      builder: (context, state) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: TermsAndConditionsPage.path,
      name: TermsAndConditionsPage.name,
      builder: (context, state) => const TermsAndConditionsPage(),
    ),
  ],
);

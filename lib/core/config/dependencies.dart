part of 'config.dart';

final sl = GetIt.instance;

Future<void> _setupDependencies() async {
  await _core;

  await Future.wait([
    //! mason:linking-dependencies - DO NOT REMOVE THIS COMMENT --------------------------->
    analyticsDependencies,
    leaderboardDependencies,
    registrationDependencies,
    searchDependencies,
    reviewDependencies,
    businessDependencies,
    locationDependencies,
    lookupDependencies,
    subCategoryDependencies,
    categoryDependencies,
    industryDependencies,
    profileDependencies,
    loginDependencies,
    authenticationDependencies,
    homeDependencies,
    versionDependencies,
    whatsNewDependencies,
  ]);
}

Future<void> get _core async {
  sl.registerFactory(
    () => ThemeBloc(),
  );

  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<FacebookAuth>(() => FacebookAuth.instance);
  sl.registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics.instance);
  sl.registerLazySingleton<FirebaseRemoteConfig>(() => FirebaseRemoteConfig.instance);
  sl.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(
      scopes: [
        'email',
        'profile',
      ],
    ),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(checker: sl()));
}

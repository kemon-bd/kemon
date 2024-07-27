part of '../config.dart';

Future<void> get loginDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => LoginBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ForgotPasswordBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => SignInWithAppleBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => SignInWithFacebookBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => SignInWithGoogleBloc(
      useCase: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => LoginUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => ForgotPasswordUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => AppleSignInUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FacebookSignInUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => GoogleSignInUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      network: sl(),
      auth: sl(),
      remote: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      client: sl(),
      facebookSdk: sl(),
      googleSdk: sl(),
    ),
  );
}

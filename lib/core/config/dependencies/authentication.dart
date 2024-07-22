part of '../config.dart';

Future<void> get authenticationDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(() => AuthenticationBloc());
}

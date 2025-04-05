part of '../config.dart';

Future<void> get whatsNewDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => WhatsNewBloc(),
  );
}

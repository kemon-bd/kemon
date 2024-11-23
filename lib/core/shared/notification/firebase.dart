import '../shared.dart';

@pragma('vm:entry-point')
Future<void> firebaseHandler(RemoteMessage message) async {
  print(message);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

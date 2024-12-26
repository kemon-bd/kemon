import '../shared.dart';

@pragma('vm:entry-point')
Future<void> firebaseHandler(RemoteMessage message) async {
  try {
    final notificationPlugin = FlutterLocalNotificationsPlugin();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    final NotificationDetails notificationDetails = NotificationDetails(
      android: _androidNotificationDetails,
    );
    await notificationPlugin.show(
      DateTime.now().microsecond,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: json.encode(message.toMap()),
    );
  } catch (error) {
    debugPrint(error.toString());
  }
}

Future<void> setupFirebaseMessaging() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final NotificationSettings settings = await messaging.getNotificationSettings();
  FirebaseMessaging.onBackgroundMessage(firebaseHandler);
  if (settings.authorizationStatus != AuthorizationStatus.authorized) {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  // debugPrint(await FirebaseMessaging.instance.getToken());
}

AndroidNotificationDetails get _androidNotificationDetails => AndroidNotificationDetails(
      'kemon_megaphone',
      'KEMON general notification',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'kemon_ticker',
      playSound: true,
      enableVibration: true,
      icon: 'drawable/ic_notification',
      sound: RawResourceAndroidNotificationSound('notification'),
      audioAttributesUsage: AudioAttributesUsage.notification,
      colorized: true,
      color: ThemeScheme.light().primary,
      groupKey: 'kemon_notification_syndicate',
      setAsGroupSummary: true,
      groupAlertBehavior: GroupAlertBehavior.children,
    );

import '../shared.dart';

@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(NotificationResponse details) async {
  debugPrint(details.payload);
}

Future<void> setupLocalNotification() async {
  final notificationPlugin = FlutterLocalNotificationsPlugin();
  notificationPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission(

      );
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
    'drawable/ic_notification',
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await notificationPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
  );
}

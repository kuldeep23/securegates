import 'dart:developer';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/firebase_options.dart';
import 'package:secure_gates_project/secure_gates_app.dart';
import 'package:secure_gates_project/services/login_presistence_service.dart';
import 'package:secure_gates_project/services/notification_service.dart';

final localNotif = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  int i = 0;
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
          'custom_sound_channel', 'your other channel name',
          channelDescription: 'your other channel description',
          importance: Importance.max,
          sound: RawResourceAndroidNotificationSound('ring'),
          timeoutAfter: 15000,
          playSound: true);

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  await FlutterLocalNotificationsPlugin().show(
    i++,
    'custom sound notification title',
    'custom sound notification body',
    payload: "payload data",
    notificationDetails,
  );

  log("Handling a background message: ${message.messageId}");
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print(
      "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ notification tap");
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     // 'This channel is used for important notifications.', // description
//     importance: Importance.max,
//     sound: RawResourceAndroidNotificationSound("ring"),
//     playSound: true);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initialise();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

//   final token = await FirebaseMessaging.instance.getToken();

// <<<<<<< feature/handle_notif_cases
//   print(token);
//   print("++++++++++++++++++++++++++++++++++++++++");
// =======
//   log(token.toString());
// >>>>>>> main
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final token = await FirebaseMessaging.instance.getToken();

  print(token);
  print("++++++++++++++++++++++++++++++++++++++++");
  await LoginPresistenceService.init();
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
  runApp(const ProviderScope(child: MyApp()));
}

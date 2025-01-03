import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/entities/visitor_from_notification.dart';
import 'package:secure_gates_project/general_providers.dart';
import 'package:secure_gates_project/routes/app_routes_config.dart';
import 'package:secure_gates_project/routes/app_routes_constants.dart';

///Handle Clicks
Future<void> didRecieveNotification(NotificationResponse details) async {
  log("onSelectNotification ${details.payload}");
  MyAppRouterConfig.rootNavigatorKey.currentContext?.pushNamed(
      MyAppRoutes.notificationResponsePage,
      extra: VisitorFromNotification.fromMap(jsonDecode(details.payload!)));
  Fluttertoast.showToast(msg: "notification service 21");
  if (details.actionId != null && details.actionId!.isNotEmpty) {
    log("Router Value1234 ${details.actionId}");
  }
}

///[iOS]-Displays notification in foreground and background
///Then calls [didRecieveNotification] for handling the clicks on [iOS]
///[Android] displays the notification while app is killed
///Then calls [didNotificationLaunchDetails] on homescreen to redirect
@pragma('vm:entry-point')
Future<void> notificationTappedBackground(NotificationResponse details) async {
  MyAppRouterConfig.rootNavigatorKey.currentContext?.pushNamed(
    MyAppRoutes.notificationResponsePage,
    extra: VisitorFromNotification.fromMap(
      jsonDecode(details.payload!),
    ),
  );
  // Fluttertoast.showToast(msg: "Notificiaton Received");
  Fluttertoast.showToast(msg: "notification service 40");
  log("onBackground");
  if (details.actionId!.isNotEmpty) {
    log("Router Value1234 ${details.actionId}");
  }
}

class NotificationService {
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future<void> initialise() async {
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/launcher_icon"),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );
    _notificationsPlugin.initialize(
      initializationSettings,
      //Handle Clicks
      onDidReceiveNotificationResponse: didRecieveNotification,
      //
      onDidReceiveBackgroundNotificationResponse: notificationTappedBackground,
      // onSelectNotification: (String? id) async {
      //   log("onSelectNotification");
      //   if (id!.isNotEmpty) {
      //     log("Router Value1234 $id");
      //   }
      // },
    );
    final bool? result = Platform.isIOS
        ? await _notificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
              critical: false,
              provisional: false,
            )
        : await _notificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestPermission();
    log("notifiiiiiiiiiii: $result");
  }
  // final Ref _ref;
  // NotificationService(this._ref);

  static Future<void> sendNotification(
      {required String title,
      required String subject,
      required String topic,
      // required String type,
      // required String id,
      required String fbID,
      String? tojen}) async {
    String postUrl = "https://fcm.googleapis.com/fcm/send";
    // log(topic);

    // log(toParams);

    final data = FormData.fromMap({
      "notification": {"body": subject, "title": title},
      "priority": "high",
      "data": {
        "name": "ninja hatori",
        "sound": 'default',
      },
      "to": fbID // tojen
      // ?? toParams
    });

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key= $tojen'
    };
    final response = await Dio().post(postUrl,
        data: data,
        options: Options(
          headers: headers,
        ));
    log(response.data);
    if (response.statusCode == 200) {
      log(response.data);
      log("send respo: true");
    } else {
      log("send respo: false");
    }
  }

  static Future<void> updateFBID(
      {required String token, required String uid}) async {
    String apiUrl =
        "https://peru-heron-650794.hostingersite.com/user_firebase_id.php";
    final data = FormData.fromMap({
      "uid": uid,
      "fb_id": token,
    });
    final headers = {
      'content-type': 'application/json',
    };
    final response = await Dio().post(
      apiUrl,
      data: data,
      options: Options(headers: headers),
    );
    print(response.data["status"]);
  }

  // static Future<void> requestNotificationPermission() async {
  //   NotificationSettings settings =
  //       await _ref.read(firebaseMessagingProvider).requestPermission(
  //             alert: true,
  //             announcement: false,
  //             badge: true,
  //             carPlay: false,
  //             criticalAlert: false,
  //             provisional: false,
  //             sound: true,
  //           );
  // }

  static void createanddisplaynotification(RemoteMessage message,
      {required String source}) async {
    log("Source: $source");
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'Event Managers',
          'Offers and News',
          playSound: true,
          channelDescription: "Offers and News",
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: false,
          sound: RawResourceAndroidNotificationSound('notification'),
        ),
        // iOS: DarwinNotificationDetails(
        //   'Event Managers',
        //   'Offers and News',
        //   playSound: true,
        //   channelDescription: "Offers and News",
        //   importance: Importance.max,
        //   priority: Priority.high,
        //   fullScreenIntent: false,
        // )
      );

      await _notificationsPlugin.show(
        id,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static void createNotificationChannel(
      String id, String name, String description, String sound) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidNotificationChannel? androidNotificationChannel;
    if (sound == 'notification') {
      androidNotificationChannel = AndroidNotificationChannel(
        id,
        name,
        sound: RawResourceAndroidNotificationSound(sound),
        playSound: true,
      );
    } else {
      androidNotificationChannel = AndroidNotificationChannel(
        id,
        name,
        playSound: true,
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }
}

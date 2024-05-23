import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> didRecieveNotification(details) async {
  log("onSelectNotification");
  if (details.actionId != null && details.actionId!.isNotEmpty) {
    log("Router Value1234 ${details.actionId}");
  }
}

Future<void> didRecieveBackgroudNotification(details) async {
  log("onSelectNotification");
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
      onDidReceiveNotificationResponse: didRecieveNotification,
      onDidReceiveBackgroundNotificationResponse:
          didRecieveBackgroudNotification,
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
      required String type,
      required String id,
      String? tojen}) async {
    String postUrl = "https://fcm.googleapis.com/fcm/send";
    // log(topic);
    String toParams = "/topics/$topic";
    // log(toParams);

    final data = FormData.fromMap({
      "notification": {"body": subject, "title": title},
      "priority": "high",
      "data": {
        "type": type,
        "id": id,
        "sound": 'default',
      },
      "to": toParams // tojen
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

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'Event Managers', 'Offers and News',
          playSound: true,
          channelDescription: "Offers and News",
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: false,
          // sound: RawResourceAndroidNotificationSound("zomato")
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
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['id'],
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

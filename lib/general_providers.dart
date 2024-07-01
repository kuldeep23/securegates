import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseMessagingProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});

final generalUrlPathProvider = Provider<String>((ref) {
  return "https://superhuman-shortage.000webhostapp.com";
});

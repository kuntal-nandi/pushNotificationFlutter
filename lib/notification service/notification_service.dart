import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
	// Initialization setting for android
	const InitializationSettings initializationSettings =
		InitializationSettings(
			android: AndroidInitializationSettings("@mipmap/ic_launcher"));
	
  
  _notificationsPlugin.initialize(
	initializationSettings,
	// to handle event when we receive notification
	onDidReceiveNotificationResponse: (details) {
		if (details.input != null) {}
	},
	);
}

static Future<void> display(RemoteMessage message) async {
	// To display the notification in device
	try {
	final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
	 NotificationDetails notificationDetails = const NotificationDetails(
		android:  AndroidNotificationDetails(
			"push_notification",
			"push_notificationchannel",
			importance: Importance.max,
			playSound: true,
			priority: Priority.high),
	);
	await _notificationsPlugin.show(id, message.notification?.title,
		message.notification?.body, notificationDetails,
		payload: message.data['_id']);
	}on Exception catch (e) {
	debugPrint(e.toString());
	}
}

}
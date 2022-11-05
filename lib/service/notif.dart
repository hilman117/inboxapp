import 'dart:convert';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Notif {
  var serverkey =
      "AAAA5wRMCcM:APA91bFKmnPpduoGw0-scInqjxcXJ-99eUPTVORgbsSRjFGJlLkdmyOR5Ail6I2KYvjAfvoPaJ9vYXo6eXQ5a4caMEeF2EuMN8cFMkLFRQceZxEgY2B7puAPn4HWChx00P-v2-lVWWrK";
  Future<String> getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    return fcmToken!;
  }

  Future<void> saveTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  init() {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/logoblue',
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              groupKey: 'message',
              importance: NotificationImportance.High,
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Colors.orange,
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupkey: 'basic_channel_group',
              channelGroupName: 'Basic notifications')
        ],
        debug: true);
  }

  requestPermission() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  createNotification(String title, String body, String image) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            summary: 'summary',
            id: (1 + Random().nextInt(1000)),
            groupKey: 'message',
            channelKey: 'basic_channel',
            title: title,
            body: body,
            notificationLayout: NotificationLayout.Inbox,
            bigPicture: image,
            category: NotificationCategory.Message),
        actionButtons: <NotificationActionButton>[
          NotificationActionButton(
              key: "Open", label: "Open", enabled: true, color: Colors.blue),
          NotificationActionButton(
              key: "Accept",
              label: "Accept",
              enabled: true,
              color: Colors.blue),
        ]);
  }

  foreground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        createNotification(
            notification.title ?? '', notification.body ?? '', '');
        print(notification.title);
      }
    });
  }

  void sendNotif(String topic, String title, String body) async {
    var data = {
      "notification": {"title": title, "body": body},
      "data": {"score": "5x1", "time": "15:10"},
      "priority": "high",
      "to": "/topics/$topic"
    };
    print("----------------------------");
    print(data);
    var respon = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "key=$serverkey"
        },
        body: jsonEncode(data));
    print(respon.body);
  }

  void sendNotifToToken(
    String token,
    String title,
    String body,
  ) async {
    var data = {
      "notification": {"title": title, "body": body},
      "data": {"score": "5x1", "time": "15:10"},
      "priority": "high",
      "to": token
    };
    print("----------------------------");
    print(data);
    var respon = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "key=$serverkey"
        },
        body: jsonEncode(data));
    print(respon.body);
  }
}

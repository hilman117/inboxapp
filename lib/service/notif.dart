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
        'resource://drawable/androidnotif',
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              groupKey: 'message',
              importance: NotificationImportance.High,
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Colors.orange,
              ledColor: Colors.white),
          NotificationChannel(
              channelKey: "scheduled_channel",
              channelName: "scheduled notification",
              channelDescription: "scheduled notification",
              importance: NotificationImportance.High,
              locked: true)
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

  createNotificationForegroundWithImage(
      String title, String body, String image) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      largeIcon: image,
      id: (1 + Random().nextInt(1000)),
      channelKey: 'basic_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.Default,
      bigPicture: image,
    ));
  }

  createNotificationForeground(String title, String body) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: (1 + Random().nextInt(1000)),
      channelKey: 'basic_channel',
      notificationLayout: NotificationLayout.Default,
      title: title,
      body: body,
    ));
  }

  Future<void> scheduleNotification(
      {required int scheduleId,
      required String title,
      required String location,
      required int month,
      required int day,
      required int hour,
      required int minute,
      required String body}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: scheduleId,
          channelKey: "scheduled_channel",
          title: 'Reminder for "$location" : "$title"',
          body: body,
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationCalendar(
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: 0,
            millisecond: 0,
            repeats: true));
  }

  //method when cacthing the message from fcm
  foreground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        if (android.imageUrl != '') {
          createNotificationForegroundWithImage(notification.title ?? '',
              notification.body ?? '', android.imageUrl ?? '');
        } else {
          createNotificationForeground(
              notification.title ?? '', notification.body ?? '');
        }
      }
    });
  }

  //void to send push notification
  void sendNotif(String topic, String title, String body) async {
    var data = {
      "notification": {"title": title, "body": body},
      "data": {"score": "5x1", "time": "15:10"},
      "priority": "high",
      "to": "/topics/$topic"
    };
    // print("----------------------------");
    // print(data);
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
    String image,
  ) async {
    var data = {
      "notification": {"title": title, "body": body, "image": image},
      "data": {"score": "5x1", "time": "15:10"},
      "priority": "high",
      "to": token
    };
    // print("----------------------------");
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

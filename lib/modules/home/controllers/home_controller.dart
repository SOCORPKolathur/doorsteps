import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/modules/home/controllers/userModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class HomeController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? mtoken = "";

  @override
  void onReady() {
    super.onReady();
    requestPermission();
    listenFCM();
    loadFCM();
    _allclint.bindStream(FirebaseFirestore.instance
        .collection("Admintoken")
        .snapshots()
        .map((QuerySnapshot queryy) {
      List<Usermodel> allvideos = [];
      for (var elment in queryy.docs) {
        allvideos.add(Usermodel.formSnap(elment));
      }
      return allvideos;
    }));
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: '@mipmap/launcher_icon',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAkHaaZZY:APA91bE0FhEoa38cvpPiY4rvDcl6Obp5ggiHj7Udi25On7dPmLGrgUbSBAneBuJ-GOzG_bvIXr7ji-xpJiO5QNaDohL0B7ljr4beSE3poy1jOcd96g6G8iQWcbv4Fwh27QuwwrzYAMcp',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }

  final Rx<List<Usermodel>> _allclint = Rx<List<Usermodel>>([]);
  List<Usermodel> get clientusers => _allclint.value;

  Future<void> findusers(orderno,type,usertoken) async {
 if(type=="myorder"){
        sendPushMessage(usertoken, "Order ID: ${orderno}", "Your Order is placed successfully");
    }
    else{
        sendPushMessage(usertoken, "Order ID: ${orderno}", "New Order Received");
    }
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
}

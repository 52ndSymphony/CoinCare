import 'dart:io';
import 'dart:math';

import 'package:coincare/chat/users_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices{

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  void requestNotificationPermission () async{
    NotificationSettings settings=await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true

    );
    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      print('user granted permission');
    }else if(settings.authorizationStatus==AuthorizationStatus.provisional){
      print('user granted provisional permission');
    }else{
      print('user denied permission');
    }

  }
  void initLocalNotifications(BuildContext context,RemoteMessage message)async{
    var androidIntializationSettings=const AndroidInitializationSettings('@drawable/noti');
    var iosInitializationSettings=const DarwinInitializationSettings();
    var initializationSetting=InitializationSettings(
      android: androidIntializationSettings,
      iOS: iosInitializationSettings
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,onDidReceiveBackgroundNotificationResponse: (payload){
      handleMessage(context, message);

    });


  }
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {


       if (kDebugMode) {
         print(message.notification!.title.toString());

         print(message.notification!.body.toString());

         print(message.data.toString());
       }
       if(Platform.isAndroid){
         initLocalNotifications(context, message);
       }
        showNotification(message);

    });
  }
  Future<void>showNotification(RemoteMessage message)async{
    AndroidNotificationChannel channel=AndroidNotificationChannel(Random.secure().nextInt(100000).toString(), 'CoinCare',importance: Importance.max);
   AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(channel.id.toString(),channel.name.toString(),channelDescription: 'your channel description',importance: Importance.high,priority: Priority.high,
     ticker: 'ticker'
   );
   const DarwinNotificationDetails darwinNotificationDetails=DarwinNotificationDetails(
     presentAlert: true,
     presentBadge: true,
     presentSound: true
   );
   NotificationDetails notificationDetails=NotificationDetails(
     android: androidNotificationDetails
   );
     Future.delayed(Duration.zero,()
    {
      _flutterLocalNotificationsPlugin.show(
          0
          , message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });

  }
  Future<String> getDeviceToken()async{
    String? token=await messaging.getToken();
    return token!;
  }
  void isTokenRefresh()async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('refresh');
    });

  }
  Future<void> setupInteractMessage(BuildContext context)async{
    RemoteMessage? initialMessage=await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage!=null){
      handleMessage(context, initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
        handleMessage(context, event);
    });
  }
  void handleMessage(BuildContext context,RemoteMessage message){
  if(message.data['type']=='msg'){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
  }
  }
}
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coincare/chat/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'chat/users_page.dart';

class Chat_Notification_Services{
  static const key=
      'AAAA3VRGKVg:APA91bHUghxaCKhpLdjeEOe3JyUmk2SNCFJgX-U_jBrI6Cz3ukceFEJDsR-ULRLUyzatmnSWQItFPmVK6hgcIqM8Xi7cn8M-CyypG5SKp6EU0lpXgFtFgkJtvPjmDZHKxCyJQi7J7tMs';
  final flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  void _initLocalNotification(){
    const androidSettings=AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings=DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true

    );
    const initializationSettings=InitializationSettings(
      android: androidSettings,iOS: iosSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveBackgroundNotificationResponse: (response){
      debugPrint(response.payload.toString());
    });

  }
  Future<void> _showLocalNotification(RemoteMessage message)async {
    final styleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatTitle: true,
    );
    final androidDetails = const AndroidNotificationDetails(
        'com.example.CoinCare', 'HelloThere', importance: Importance.max, priority: Priority.max);
    const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true
    );

    final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails
    );
    await flutterLocalNotificationsPlugin.show(
        0, message.notification!.title, message.notification!.body,
        notificationDetails, payload: message.data['body']);
  }
    Future<void> requestNotiPermission () async {
      final messaging = FirebaseMessaging.instance;
      final settings = await messaging.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: true,
          criticalAlert: true,
          provisional: true,
          sound: true

      );
      if(settings.authorizationStatus==AuthorizationStatus.authorized){
        debugPrint('user granted permission');
      }else if(settings.authorizationStatus==AuthorizationStatus.provisional){
        debugPrint('user granted provisional permission');
      }else{
        debugPrint('user denied permission');
      }

    }
    Future<void> saveToken(String token)async{
      await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).set({'token':token},SetOptions(merge: true));
    }
    Future<void> getToken() async{
      final token=await FirebaseMessaging.instance.getToken();
      saveToken(token!);
    }
    String recieverToken='';
    Future<void>getRecieverToken(String? recieverID)async{
    final getToken=await FirebaseFirestore.instance.collection("Users").doc(recieverID).get();
    recieverToken=await getToken.data()!['token'];
    }
    void firebaseNotification(context){
        _initLocalNotification();
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (_)=>ChatPage(username: message.data['uid'], receiverID: message.data['senderID'])),

          );
        });
        FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
          await _showLocalNotification(message);
        });
    }
    Future<void> sendNotification(
       { required String body,required String senderID})async{
      try{
  await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  headers: <String,String>{
    'Content -Type':'application/json',
    'Authorization':'key=$key',
  },
  body: jsonEncode(<String,dynamic>{
    "to":recieverToken,
    'priority':'high',
    'notification':<String,dynamic>{
      'body':body,
      'title':'New Message!',
    },
    'data':<String,String>{
      'click_action':'FLUTTER_NOTIFICATION_CLICK',
      'status':'done',
      'senderID':senderID,
    }
  }),
  );}catch(e){
        debugPrint(e.toString());
      }

    }

    
  }




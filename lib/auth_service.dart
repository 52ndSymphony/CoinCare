import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coincare/chat/chat_page.dart';
import 'package:coincare/chat/welcome_page.dart';
import 'package:coincare/chat_notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthService{
  final FirebaseAuth auth=FirebaseAuth.instance;



  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  User? getCurrentUser(){
    return auth.currentUser;
  }
  Future<UserCredential> signInWithEmailPassword(String email, password)async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
          //username: username
      );
      /*firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid':userCredential.user!.uid,
            'email':email,
            //'username':username,


          }
      );*/
      return userCredential;
    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }
  Future<UserCredential> signUpWithEmailPassword(String email, password,username,balance)async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password);

      firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid':userCredential.user!.uid,
          'email':email,
          'username':username,
          'balance' : balance,
        }
      );


      return userCredential;
    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }
}

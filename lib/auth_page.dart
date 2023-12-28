import 'package:coincare/loginPage.dart';
import 'package:coincare/loginorregisterpage.dart';
import 'package:coincare/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'package:flutter/material.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            //user logged in
            if(snapshot.hasData){
              //Navigator.pop(context);
              return HomePage();
            }
            //user not logged in
            else{
              return const LoginOrRegistered();
            }
          },
        )
    );
  }
}
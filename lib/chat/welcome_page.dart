import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coincare/chat/start_chatting.dart';
import 'package:coincare/chat/users_page.dart';
import 'package:flutter/material.dart';
import 'package:coincare/splash_screen.dart';
class chatWelcomePage extends StatelessWidget{
  const chatWelcomePage({super.key});
  @override
  Widget build(BuildContext context){
    return AnimatedSplashScreen(
      backgroundColor: Color.fromARGB(200, 207, 177, 119),
      splash: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message,size: 100,color: Colors.white),
            SizedBox(height: 15),
            Text('Welcome',style: TextStyle(fontFamily: 'signika',color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      nextScreen:  Home(),
      splashIconSize: double.infinity,
      duration: 700,
      splashTransition: SplashTransition.fadeTransition,

    );

  }
}

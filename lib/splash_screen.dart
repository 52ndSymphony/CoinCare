import 'package:flutter/material.dart';
import 'auth_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      splash:
      Center(

        child: Image.asset(
          'assets/logo.png',
          width: 500.0,
          height: 500.0,

        ),
      ),
      nextScreen:  Authpage(),
      splashIconSize: double.infinity,
      duration: 700,
      splashTransition: SplashTransition.fadeTransition,

    );
  }
}

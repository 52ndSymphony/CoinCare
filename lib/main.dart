

import 'package:coincare/splash_screen.dart';
import 'package:coincare/theme/light_mode.dart';
import 'package:coincare/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( ChangeNotifierProvider(create: (context)=>ThemeProvider(),
  child:  MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: SplashScreen(),
      routes: {

      },
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}



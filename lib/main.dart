import 'package:coincare/auth_page.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        title: Text('Logo Page'),
        backgroundColor: Color.fromARGB(235, 0, 255, 42),
      ),*/
      body: Center(

          child: Image.asset(
              'assets/firstpage.jpg',
            width: 500.0,
              height: 500.0,

          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Authpage(),
          ));
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

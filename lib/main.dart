import 'package:flutter/material.dart';
import 'loginPage.dart';


void main() async{
  
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FirstPage extends StatelessWidget {
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
            MaterialPageRoute(builder: (context) => SecondPage()),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

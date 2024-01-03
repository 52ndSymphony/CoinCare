import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bottomnavigationbar.dart';
class HomePage extends StatelessWidget{

  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;
  //sign user out
  void signUserOut(){
    try{
      FirebaseAuth.instance.signOut();
    }on FirebaseAuthException catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(


          preferredSize: const Size.fromHeight(110.0), // here the desired height
          child: AppBar(
            actions: [
              IconButton(
                  onPressed: signUserOut, icon: Icon(Icons.logout))],
            toolbarHeight: 220,
            title: const Text(
                'Home',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color: Colors.white)
            ),
            centerTitle: true,
            backgroundColor: Colors.deepOrange,
          )
      ),

      body: Padding(
          padding: EdgeInsets.fromLTRB(130, 20, 10, 10),
          //padding: EdgeInsets.all(10),
          child:Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Column(
                children: <Widget>[
                  Image.asset('assets/stat 2.jpg', height: 150.0,fit: BoxFit.cover),
                  TextButton.icon(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Bottom()),
                    );
                  }, icon: Icon(Icons.access_time_filled_sharp), label: Text('Statistics')),
                ],
              ),
              Column(
                children: <Widget>[
                  Image.asset('assets/transaction 2.jpg', height: 150.0,),
                  TextButton.icon(onPressed: () {}, icon: Icon(Icons.access_time_filled_sharp), label: Text('Transactions')),
                ],
              ),
              Column(
                children: <Widget>[
                  Image.asset('assets/chat 2.jpg', height: 150.0,),
                  TextButton.icon(onPressed: () {}, icon: Icon(Icons.access_time_filled_sharp), label: Text('Inbox')),
                ],
              ),
            ], // <Widget>
          )
      ), // Row



      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

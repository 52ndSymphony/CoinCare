import 'package:coincare/transfer%20page.dart';
import 'package:flutter/material.dart';

import 'package:coincare/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:coincare/user_tile.dart';

import 'package:coincare/auth_page.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coincare/chat_model/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoneyTransfer{
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String amount;

  MoneyTransfer({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.amount,
  });
  Map<String,dynamic> toMap(){
    return{
      'senderID':senderID,
      'senderEmail':receiverID,
      'receiverID':receiverID,
      'amount':amount,
    };
  }
}



class Transfer {

  String? uid = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  final FirebaseAuth auth=FirebaseAuth.instance;
  Stream<List<Map<String,dynamic>>> getUserStream(){
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc){
        final user=doc.data();
        return user;
      }).toList();
    });

  }
  Future<void> sendMoney(String receiverID,amount) async{
    final String currentUserID=auth.currentUser!.uid;
    final String currentUserEmail=auth.currentUser!.email!;
    final Timestamp timestamp=Timestamp.now();
    MoneyTransfer newMoney=MoneyTransfer(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      amount: amount,
    );
    List<String> ids=[currentUserID,receiverID];
    ids.sort();
    String chatRoomID=ids.join('_');
    await firestore.collection("Users").doc(uid).collection("transactions").add(newMoney.toMap());
  }
  Stream<QuerySnapshot> getMoney(String userID,otherUserID){
    List<String> ids=[userID,otherUserID];
    ids.sort();
    String chatRoomID=ids.join('_');
    return firestore.collection("Users").doc(uid).collection("transactions").snapshots();

  }




}
class Money extends StatelessWidget {
  Money({super.key});

  final Transfer transferService = Transfer();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,

      appBar: PreferredSize(


          preferredSize: const Size.fromHeight(110.0),
          // here the desired height

          child: AppBar(

            leading: BackButton(
              color: Colors.white,
            ),
            toolbarHeight: 220,
            title: const Text(
                'USERS',
                style: TextStyle(fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'signika')
            ),

            centerTitle: true,

            backgroundColor:  Color.fromARGB(200, 221, 201, 166),
          )
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/chat.jpg'), // Provide your image path here
            fit: BoxFit.cover,
          ),
        ),
        child: buildUserList(), // Assuming buildUserList() returns a widget for user list
      ),

    );
  }

  Widget buildUserList() {
    return StreamBuilder(stream: transferService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading.....');
          }
          return ListView(
            children: snapshot.data!.map<Widget>((userData) =>
                buildUserListItem(
                    userData, context)).toList(),
          );
        }
    );
  }

  Widget buildUserListItem(Map<String, dynamic>userData, BuildContext context) {
    if (userData["email"] != authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["username"]==null?'set your name':userData["username"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                transferPage(
                  username: userData["username"]==null?'set your name':userData["username"],
                  receiverID: userData["uid"],)
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
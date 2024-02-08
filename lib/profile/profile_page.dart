import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coincare/profile/my_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser=FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Page'),
      backgroundColor: Colors.grey[900],),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.uid).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
    final userData=snapshot.data!.data() as Map<String,dynamic>;
    return ListView(

    children: [
    SizedBox(height: 100,),
    Icon(Icons.person,size: 70,),
    Text(currentUser.email!,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[700]),),
    Padding(
    padding: const EdgeInsets.all(20.0),
    child: Text('My Details',textAlign: TextAlign.start,style: TextStyle(color: Colors.grey[700],fontSize: 20),),

    ),
    MylistTile(
    text:userData["username"],sectionName:'Username',) ,
      const SizedBox(height: 50,),
      MylistTile(
        text:userData["balance"],sectionName:'Current Balance',)


    ],
    );
    }
            else if (snapshot.hasError){
              return Center(
                child: Text('Error'+snapshot.error.toString()),
              );
          }
            return const Center(child: CircularProgressIndicator(),);


        },
      )
    );
  }
}

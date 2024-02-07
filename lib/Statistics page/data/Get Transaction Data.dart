import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class GetTransactionData extends StatelessWidget {


  final String DocumentId;
  String? uid = FirebaseAuth.instance.currentUser?.uid;

  GetTransactionData({required this.DocumentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users=FirebaseFirestore.instance.collection('Users').doc(uid).collection('data');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(DocumentId).get(),
        builder: ((context,snapshot){
            if(snapshot.connectionState==ConnectionState.done){
              Map<String,dynamic>data=snapshot.data!.data() as Map<String,dynamic>;
              return Text('${data['explain']} \n${data['name']}\n'
                  'Ammount: ${data['amount']} Taka'

              );
            }
            return Text('Loading.....');
        }

        ));
  }
}

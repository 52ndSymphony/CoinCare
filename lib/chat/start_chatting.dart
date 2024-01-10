import 'package:cloud_firestore/cloud_firestore.dart';

 class Hello {


  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  Stream<List<Map<String,dynamic>>> getUserStream(){
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc){
        final user=doc.data();
        return user;
      }).toList();
    });

  }



}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<String> getUsername() async {
    String uid = _auth.currentUser!.uid;
    DocumentSnapshot snapshot = await _db.collection('Users').doc(uid).get();
    String username = snapshot.get('username');
    return username;
  }
}
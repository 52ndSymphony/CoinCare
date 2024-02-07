import 'package:cloud_firestore/cloud_firestore.dart';

import '../signUp.dart';
import 'package:flutter/material.dart';

class UserModel{

    final String Username;
    final String email;

    const UserModel({
      required this.Username,
      required this.email,

    });
    toJson(){
        return{
          "Username": Username,
          "Email": email,
        };
    }
    factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>document){
      final data=document.data()!;
      return UserModel(
          email: data["Email"],
          Username: data["Username"],
      );

    }

}


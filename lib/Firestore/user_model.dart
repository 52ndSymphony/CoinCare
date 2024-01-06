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

}


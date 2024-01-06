import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coincare/Firestore/user_model.dart';
import 'package:coincare/signUp.dart';
import 'package:get/get.dart';


class UserRepository extends GetxController{
    static UserRepository get instance => Get.find();

    final _db = FirebaseFirestore.instance;


    creatUser(UserModel user) async {
       await _db.collection("Users").add(user.toJson())
       .whenComplete(
               () => Get.snackbar("success", "Your account is created",
               snackPosition: SnackPosition.BOTTOM,
               colorText: Colors.green)
       )
           .catchError(
      (error) {
      // Error handling
      // Display error snackbar
      Get.snackbar(
      "Error",
      error.toString(), // Displaying the error message
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.red,
      );
      },
      );


    }

}









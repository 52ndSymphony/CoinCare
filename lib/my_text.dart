import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscuretext;


  const Mytextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscuretext,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscuretext,


        decoration: InputDecoration(

          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white,fontFamily: 'signika',fontWeight: FontWeight.bold),
          fillColor: Colors.orangeAccent,
          filled: true,

        ),
      ),
    );
  }
}

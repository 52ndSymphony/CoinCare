import 'package:coincare/loginPage.dart';
import 'package:coincare/signUp.dart';
import 'package:flutter/material.dart';

class LoginOrRegistered extends StatefulWidget {
  const LoginOrRegistered({super.key});

  @override
  State<LoginOrRegistered> createState() => _LoginOrRegisteredState();
}

class _LoginOrRegisteredState extends State<LoginOrRegistered> {
  //initially show the login page
  bool showLoginPage = true;

  //toggle between login and register pages

  void togglePages(){
    print(showLoginPage);
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(
        ontap: togglePages,
      );
    }
    else{
      return RegisterPage(
        ontap: togglePages,
      );
    }
  }
}

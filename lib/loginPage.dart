import 'package:coincare/auth_service.dart';
import 'package:coincare/chat_notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'forgot_password.dart';
import 'button.dart';
class LoginPage extends StatefulWidget {
  final Function()? ontap;

  LoginPage({Key? key, required this.ontap});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  static final notifications=Chat_Notification_Services();

  bool crossVisible1 = false;
  bool crossVisible2 = false;


  void signUserIn(BuildContext context) async {
    final authservice=AuthService();
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),

        );

      },
    );

    try {
      await authservice.signInWithEmailPassword(
        emailcontroller.text,
        passwordcontroller.text,

      );
      await notifications.requestNotiPermission();
      await notifications.getToken();
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      AlertDialog(
        title: Text(e.toString()),

      );
      Navigator.pop(context);

    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login.jpg'),
              fit: BoxFit.cover,
            )
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),



                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,fontFamily: 'signika',
                    ),
                  ),

                  const SizedBox(height: 45,),

                  TextFormField(

                    controller: emailcontroller,
                    cursorColor: Colors.black,
                    onTap: () {
                      setState(() {
                        crossVisible1 = true;
                      });
                    },
                    onTapOutside: (PointerDownEvent event) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        crossVisible1 = false;
                      });
                    },
                    onFieldSubmitted: (text) {
                      setState(() {
                        crossVisible1 = false;
                      });
                    },



                    validator: (value) {
                      TextStyle(color: Colors.black);
                      if (value!.trim().isEmpty) {
                        return 'Please enter your email !';
                      } else
                        return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person_2_outlined,color: Colors.black),
                      // hintText: "Enter Email",

                      enabledBorder:  OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(15.0),
                        borderSide:  BorderSide(color: Colors.black,width: 2
                        ),

                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 2),
                      ),
                      errorStyle:TextStyle(color: Colors.black),
                      label: Text(
                        'Enter Username/Email',
                        style: TextStyle(fontSize: 20,color: Colors.black),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(200, 180, 180, 200),
                      suffixIcon: Visibility(
                        visible: crossVisible1,
                        child: IconButton(
                          icon: Icon(Icons.clear,color: Colors.black),
                          onPressed: () {
                            emailcontroller.clear();
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15,),

                  TextFormField(
                    obscureText: true,
                    controller: passwordcontroller,
                    onTap: () {
                      setState(() {
                        crossVisible2 = true;
                        crossVisible1 = false;
                      });
                    },
                    onTapOutside: (PointerDownEvent event) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        crossVisible2 = false;
                      });
                    },
                    onFieldSubmitted: (text) {
                      setState(() {
                        crossVisible2 = false;
                      });
                    },
                    validator: (value) {

                      if (value!.trim().isEmpty) {
                        return 'Please enter your password !';
                      } else
                        return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      icon: Icon(Icons.key_outlined,color: Colors.black,),
                      // hintText: "Enter Email",
                      enabledBorder:  OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(15.0),
                        borderSide:  BorderSide(color: Colors.black,width: 2
                        ),

                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange,width: 2),
                      ),
                      errorStyle:TextStyle(color: Colors.black),
                      label: Text(
                        'Password',
                        style: TextStyle(fontSize: 20,color: Colors.black),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(200, 180, 180, 200),
                      suffixIcon: Visibility(
                        visible: crossVisible2,
                        child: IconButton(
                          icon: Icon(Icons.clear,color: Colors.black),
                          onPressed: () {
                            passwordcontroller.clear();
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                )
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'signika'

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25,),

                  MyButton(
                    text: 'Sign in',
                    onTap: ()=>signUserIn(context),
                  ),

                  const SizedBox(height: 25,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'signika',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: widget.ontap,
                        child: Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'signika',
                          ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
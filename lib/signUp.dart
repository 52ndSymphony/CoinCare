

import 'package:coincare/Firestore/user_model.dart';
import 'package:coincare/Firestore/user_repository.dart';
import 'package:coincare/auth_service.dart';
import 'package:coincare/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_notification_service.dart';
import 'loginorregisterpage.dart';
import 'chat_notification_service.dart';


class RegisterPage extends StatefulWidget {

  final Function()? ontap;
  const RegisterPage({super.key, required this.ontap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var confirmPassController = TextEditingController();
  var balanceController=  TextEditingController();
  static final notification=Chat_Notification_Services();
  bool crossVisible1 = false;
  bool crossVisible2 = false;
  bool crossVisible3 = false;
  bool crossVisible4 = false;
  bool crossVisible5 = false;



  void signUserUp(BuildContext context) async {
    final auth=AuthService();
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      },
    );

    try {
      if (passwordController.text == confirmPassController.text) {
        await auth.signUpWithEmailPassword(
           emailController.text,
           passwordController.text,
           nameController.text,
          balanceController.text,
        );

      } else {
        Navigator.pop(context);
        //ErrorShowMessage(context, 'Password Don\'t Match');
        return;
      }
      await notification.requestNotiPermission();
      await notification.getToken();
      Navigator.pop(context);


    } on FirebaseAuthException catch (e) {
      AlertDialog(
        title: Text(e.toString()),

      );
      Navigator.pop(context);
      //ErrorShowMessage(context, e.code);
    }
    /*final user=UserModel(
      Username: nameController.text.trim(),
      email: emailController.text.trim(),
    );
    creatUser(user);

     */

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(


          preferredSize: const Size.fromHeight(110.0), // here the desired height
          child: AppBar(
            leading: BackButton(
              color: Colors.white,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginOrRegistered(),
                    ));
              },
            ),

            toolbarHeight: 220,
            title: const Text(
                'SIGN UP',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'signika')
            ),
            centerTitle: true,
            backgroundColor: Colors.orange,
          )
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logi.jpg'),
              fit: BoxFit.cover,
            )
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 45,),
                  TextFormField(

                    controller: nameController,
                    onTap: () {
                      setState(() {
                        crossVisible1 = true;
                        crossVisible2 = false;
                        crossVisible3 = false;
                        crossVisible4 = false;
                        crossVisible5 = false;
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
                      if (value!.trim().isEmpty) {
                        return 'Please enter your user name !';
                      } else
                        return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person_2_outlined,color: Colors.white),
                      // hintText: "Enter Email",
                      enabledBorder:  OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(15.0),
                        borderSide:  BorderSide(color: Colors.white,width: 2
                        ),

                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,width: 2),
                      ),
                      errorStyle:TextStyle(color: Colors.white),
                      label: Text(
                        'Enter Your User Name',
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(200, 255, 187, 119),
                      suffixIcon: Visibility(
                        visible: crossVisible1,
                        child: IconButton(
                          icon: Icon(Icons.clear,color: Colors.white),
                          onPressed: () {
                            nameController.clear();
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15,),

                  TextFormField(

                    controller: emailController,
                    onTap: () {
                      setState(() {
                        crossVisible2 = true;
                        crossVisible1 = false;
                        crossVisible3 = false;
                        crossVisible4 = false;
                        crossVisible5 = false;
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
                        return 'Please enter your email !';
                      } else
                        return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person_2_outlined,color: Colors.white),
                      // hintText: "Enter Email",

                      enabledBorder:  OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(15.0),
                        borderSide:  BorderSide(color: Colors.white,width: 2
                        ),

                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,width: 2),
                      ),
                      errorStyle:TextStyle(color: Colors.white),
                      label: Text(
                        'Enter your Email',
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(200, 255, 187, 119),
                      suffixIcon: Visibility(
                        visible: crossVisible2,
                        child: IconButton(
                          icon: Icon(Icons.clear,color: Colors.white,),
                          onPressed: () {
                            emailController.clear();
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15,),

                  TextFormField(

                    controller: balanceController,
                    onTap: () {
                      setState(() {
                        crossVisible3 = true;
                        crossVisible2 = false;
                        crossVisible1= false;
                        crossVisible4 = false;
                        crossVisible5 = false;
                      });
                    },
                    onTapOutside: (PointerDownEvent event) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        crossVisible3 = false;
                      });
                    },
                    onFieldSubmitted: (text) {
                      setState(() {
                        crossVisible3 = false;
                      });
                    },

                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter your balance !';
                      } else
                        return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person_2_outlined,color: Colors.white),
                      // hintText: "Enter Email",
                      enabledBorder:  OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(15.0),
                        borderSide:  BorderSide(color: Colors.white,width: 2
                        ),

                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,width: 2),
                      ),
                      errorStyle:TextStyle(color: Colors.white),
                      label: Text(
                        'Enter Your Bank Balance',
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(200, 255, 187, 119),
                      suffixIcon: Visibility(
                        visible: crossVisible1,
                        child: IconButton(
                          icon: Icon(Icons.clear,color: Colors.white),
                          onPressed: () {
                            balanceController.clear();
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15,),

                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    onTap: () {
                      setState(() {
                        crossVisible4 = true;
                        crossVisible2 = false;
                        crossVisible1 = false;
                        crossVisible3= false;
                        crossVisible5 = false;
                      });
                    },
                    onTapOutside: (PointerDownEvent event) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        crossVisible4 = false;
                      });
                    },
                    onFieldSubmitted: (text) {
                      setState(() {
                        crossVisible4= false;
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
                      icon: Icon(Icons.key_outlined,color: Colors.white,),
                      // hintText: "Enter Email",
                      enabledBorder:  OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(15.0),
                        borderSide:  BorderSide(color: Colors.white,width: 2
                        ),

                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,width: 2),
                      ),
                      errorStyle:TextStyle(color: Colors.white),
                      label: Text(
                        'Password',
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(200, 255, 187, 119),
                      suffixIcon: Visibility(
                        visible: crossVisible3,
                        child: IconButton(
                          icon: Icon(Icons.clear,color: Colors.white,),
                          onPressed: () {
                            passwordController.clear();
                          },
                        ),
                      ),
                    ),


                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    obscureText: true,
                    controller: confirmPassController,
                    onTap: () {
                      setState(() {
                        crossVisible5 = true;
                        crossVisible2 = false;
                        crossVisible3 = false;
                        crossVisible1 = false;
                        crossVisible4= false;
                      });
                    },
                    onTapOutside: (PointerDownEvent event) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        crossVisible5 = false;
                      });
                    },
                    onFieldSubmitted: (text) {
                      setState(() {
                        crossVisible5 = false;
                      });
                    },

                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please confirm your password !';
                      } else
                        return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      icon: Icon(Icons.key_off_rounded,color: Colors.white),
                      // hintText: "Enter Email",
                      enabledBorder:  OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(15.0),
                        borderSide:  BorderSide(color: Colors.white,width: 2
                        ),

                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,width: 2),
                      ),
                      errorStyle:TextStyle(color: Colors.white),
                      label: Text(
                        'Confirm Your Password',
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(200, 255, 187, 119),
                      suffixIcon: Visibility(
                        visible: crossVisible4,
                        child: IconButton(
                          icon: Icon(Icons.clear,color: Colors.white,),
                          onPressed: () {
                            confirmPassController.clear();
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),

                  ),

                  const SizedBox(height: 15,),

                  MyButton(
                    text: 'Sign Up',
                    onTap:()=> signUserUp(context),

                  ),

                  const SizedBox(height: 25,),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


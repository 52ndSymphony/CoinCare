import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'my_text.dart';
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


  void signUserIn() async {

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const SizedBox(height: 20),



                     Text(
                      'Welcome Back!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 36,fontFamily: 'signika',
                      ),
                    ),

                  const SizedBox(height: 45,),

                     Mytextfield(
                      controller: emailcontroller,
                      hintText: 'Username/Email',
                      obscuretext: false,
                    ),

                  const SizedBox(height: 15,),

                     Mytextfield(
                      controller: passwordcontroller,
                      hintText: 'Password',
                      obscuretext: true,
                    ),

                  const SizedBox(height: 5,),

                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                             /* Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPasswordPage(),
                                  )
                              );*/
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                      onTap: signUserIn,
                    ),

                  const SizedBox(height: 25,),


                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\' have an account?',
                          style: TextStyle(
                            color: Colors.white,
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
                              color: Colors.white,
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
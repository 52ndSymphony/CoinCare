import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassWordScreen extends StatefulWidget {
  const ForgotPassWordScreen({super.key});

  @override
  State<ForgotPassWordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPassWordScreen> {
  
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(199, 238, 125, 32),
        title: Text('Forgot Password'),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email'
            ),
          ),
          SizedBox(height: 10,),

          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'New Password'
            ),
          ),

          SizedBox(height: 10,),
          ElevatedButton(onPressed: () {
            /*auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
              //Utils().toastMessage
          }).onError((error, stackTrace){
            
          });*/
          ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('Email has been sent'),

behavior: SnackBarBehavior.floating,
action: SnackBarAction(
label: 'Undo'
,

onPressed: () {
// Undo the action
},
),
duration: Duration(seconds: 3),
) // SnackBar
); // SnackBarMessenger
          }, child: Text('Reset', style: TextStyle(color: Colors.orange, fontSize: 15),),),
          
          
      ]
    )
    );
  }
}
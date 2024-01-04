import 'package:coincare/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'my_text.dart';


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


  void signUserUp() async {
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
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        Navigator.pop(context);
        //ErrorShowMessage(context, 'Password Don\'t Match');
        return;
      }

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      //ErrorShowMessage(context, e.code);
    }
  }
  void goToPrevPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  LoginPage(ontap: widget.ontap),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(220, 255, 204, 0),
      appBar: PreferredSize(


          preferredSize: const Size.fromHeight(110.0), // here the desired height
          child: AppBar(
            actions: [
              IconButton(
                  onPressed: goToPrevPage, icon: Icon(Icons.account_circle_outlined),color: Colors.white,)],

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
                  Mytextfield(
                    controller: nameController,
                    hintText: 'Username',
                    obscuretext: false,
                  ),

                  const SizedBox(height: 15,),

                  Mytextfield(
                    controller: emailController,
                    hintText: 'Username/Email',
                    obscuretext: false,
                  ),

                  const SizedBox(height: 15,),

                  Mytextfield(
                    controller: passwordController,
                    hintText: 'Password',
                    obscuretext: true,
                  ),
                  const SizedBox(height: 15,),
                  Mytextfield(
                    controller: confirmPassController,
                    hintText: 'Confirm Your Password',
                    obscuretext: true,
                  ),

                  const SizedBox(height: 5,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),

                  ),

                  const SizedBox(height: 15,),

                  MyButton(
                    text: 'Sign Up',
                    onTap: signUserUp,

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


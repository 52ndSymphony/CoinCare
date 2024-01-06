import 'package:coincare/auth_page.dart';
import 'package:coincare/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});


  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailcontroller = TextEditingController();
  bool crossVisible1 = true;

  @override
  void dispose(){
    emailcontroller.dispose();
    super.dispose();
  }
  Future passwordReset()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text.trim());
      showDialog(

          context: context,
          builder: (context){
            return AlertDialog(
              backgroundColor: Colors.white,
                content: Text('Password reset link sent to your email. '
                ,style: TextStyle(color: Colors.deepOrange,fontSize: 20,fontFamily: 'signika'),),
            );

          }
      );
    }on FirebaseAuthException catch(e){
      print(e);
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
                backgroundColor: Colors.white,
              content: Text(e.message.toString(),style: TextStyle(color: Colors.deepOrange,fontSize: 20,fontFamily: 'signika'),)
            );

      }
      );
    }

  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: PreferredSize(


          preferredSize: const Size.fromHeight(110.0), // here the desired height
          child: AppBar(

            leading: BackButton(
              color: Colors.white,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Authpage(),
                    ));
              },
            ),
            toolbarHeight: 220,
            title: const Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'signika')
            ),
            centerTitle: true,
            backgroundColor: Colors.orange,
          )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //SizedBox(height: 150),

            //padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text('Enter your email and we will send you a password reset link',style: TextStyle(color: Colors.white,fontFamily: 'signika',fontSize: 20),textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(

              controller: emailcontroller,
              cursorColor: Colors.white,
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
                TextStyle(color: Colors.white);
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
                  'Enter Your Email',
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                filled: true,
                fillColor: Color.fromARGB(200, 255, 187, 119),
                suffixIcon: Visibility(
                  visible: crossVisible1,
                  child: IconButton(
                    icon: Icon(Icons.clear,color: Colors.white),
                    onPressed: () {
                      emailcontroller.clear();
                    },
                  ),
                ),
              ),
            ),
          ),
          MaterialButton(
              onPressed: passwordReset,
              child:Text('Reset Password',style: TextStyle(color: Colors.white,fontFamily: 'signika',fontWeight: FontWeight.bold)),
              color: Colors.orange,
          ),

        ],
      ),


    );
  }
}

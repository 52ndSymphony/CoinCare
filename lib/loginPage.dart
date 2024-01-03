import 'package:coincare/loginorregisterpage.dart';
import 'package:coincare/signUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'button.dart';



class SecondPage extends StatefulWidget {

  final Function()? ontap;
  const SecondPage({super.key, required this.ontap});

  @override
  State<SecondPage> createState() => _SecondPageState();

}

class _SecondPageState extends State<SecondPage> {

  var userController = TextEditingController();
  var passwordController = TextEditingController();
  void signUserIn() async {

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
      print(userController.text);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);

  }
  bool crossVisible1 = false;
  bool crossVisible2 = false;
  bool _isHidden=true;

  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(

          preferredSize: const Size.fromHeight(110.0), // here the desired height
          child: AppBar(
            toolbarHeight: 220,
            title: const Text(
                'LOGIN',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,
                  color: Colors.white,
                )
            ),
            centerTitle: true,
            backgroundColor: Colors.orangeAccent,
          )
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:<Widget> [

            Padding(
              padding: const EdgeInsets.only(top: 180.0),

            ),


            Container(
              height: 250,
              // flex: 2,
              child: Form(
                key: formKey,
                child: Column(
                    children: [
                      //Divider(height: 30, color: Colors.black, indent: 5, endIndent: 5, thickness: 0.7,),

                      /// For User Name ///
                      Expanded(
                        flex: 3,
                        child: TextFormField(

                          controller: userController,
                          onTap: () {
                            setState(() {
                              crossVisible1 = true;
                              crossVisible2 = false;
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
                              return 'Please enter your username';
                            } else
                              return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person_2_outlined),
                            // hintText: "Enter Email",
                            enabledBorder:  OutlineInputBorder(
                              borderRadius:  BorderRadius.circular(25.0),
                              borderSide:  BorderSide(color: Colors.orange,width: 4
                              ),

                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange,width: 5),
                            ),
                            label: Text(
                              'Enter Username or email',
                              style: TextStyle(fontSize: 20,color: Colors.black),
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(200, 255, 187, 119),
                            suffixIcon: Visibility(
                              visible: crossVisible1,
                              child: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  userController.clear();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///For password ///
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          obscureText: _isHidden,
                          controller: passwordController,
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
                            icon: Icon(Icons.key_outlined),
                            // hintText: "Enter Email",
                            enabledBorder:  OutlineInputBorder(
                              borderRadius:  BorderRadius.circular(25.0),
                              borderSide:  BorderSide(color: Colors.orange,width: 4
                              ),

                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange,width: 5),
                            ),
                            label: Text(
                              'Password',
                              style: TextStyle(fontSize: 20,color: Colors.black),
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(200, 255, 187, 119),
                            suffixIcon: Visibility(
                              visible: crossVisible2,
                              child: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  passwordController.clear();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: MyButton(
                          text: 'Login',
                          onTap: signUserIn,
                        ),


                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: widget.ontap,
                        child: Text( 'New User? Create an account' ,style: TextStyle(color: Colors.orange, fontSize: 15),),
                      )
                    ]
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

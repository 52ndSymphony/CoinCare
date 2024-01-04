import 'package:coincare/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';

class RegisterPage extends StatefulWidget {

  final Function()? ontap;
  const RegisterPage({super.key, required this.ontap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> {
  var userController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var confirmPassController = TextEditingController();
  bool crossVisible1 = false;
  bool crossVisible2 = false;
  bool crossVisible3 = false;
  bool crossVisible4 = false;
  bool _isHidden=true;
  final formKey = GlobalKey<FormState>();

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff26b051)),
        );
      },
    );

    try {
      if (passwordController.text == confirmPassController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userController.text,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: PreferredSize(

          preferredSize: const Size.fromHeight(120.0), // here the desired height
          child: AppBar(
            toolbarHeight: 220,
            title: const Text(
                'SIGN UP ',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500)
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
              padding: const EdgeInsets.only(top: 30.0),
            ),
            Container(
              height: 350,
              // flex: 2,
              child: Form(
                key: formKey,
                child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(

                          controller: nameController,
                          onTap: () {
                            setState(() {
                              crossVisible1 = true;
                              crossVisible2 = false;
                              crossVisible3 = false;
                              crossVisible4 = false;
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
                              return 'Please enter your name !';
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
                              'Enter Your name',
                              style: TextStyle(fontSize: 20,color: Colors.black),
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(200, 255, 187, 119),
                            suffixIcon: Visibility(
                              visible: crossVisible1,
                              child: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  nameController.clear();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ///For Username///
                      Expanded(
                        flex: 5,
                        child: TextFormField(

                          controller: userController,
                          onTap: () {
                            setState(() {
                              crossVisible2 = true;
                              crossVisible1 = false;
                              crossVisible3 = false;
                              crossVisible4 = false;
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
                              return 'Please enter your username !';
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
                              'Enter Username',
                              style: TextStyle(fontSize: 20,color: Colors.black),
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(200, 255, 187, 119),
                            suffixIcon: Visibility(
                              visible: crossVisible2,
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
                      SizedBox(height: 16.0),

                      ///For password ///
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          obscureText: _isHidden,
                          controller: passwordController,
                          onTap: () {
                            setState(() {
                              crossVisible3 = true;
                              crossVisible2 = false;
                              crossVisible1 = false;
                              crossVisible4 = false;
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
                              visible: crossVisible3,
                              child: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  passwordController.clear();
                                },
                              ),
                            ),
                          ),


                        ),),
                      SizedBox(height: 20.0),
                      ///for confirm password///
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          obscureText: _isHidden,
                          controller: confirmPassController,
                          onTap: () {
                            setState(() {
                              crossVisible4 = true;
                              crossVisible2 = false;
                              crossVisible3 = false;
                              crossVisible1 = false;
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
                              crossVisible4 = false;
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
                            icon: Icon(Icons.key_off_rounded),
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
                              'Confirm Your Password',
                              style: TextStyle(fontSize: 20,color: Colors.black),
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(200, 255, 187, 119),
                            suffixIcon: Visibility(
                              visible: crossVisible4,
                              child: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  confirmPassController.clear();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50,),
                      Expanded(

                        child: MyButton(
                          text: 'Sign Up',
                          onTap: signUserUp,
                        ),

                        ),

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


import 'package:flutter/material.dart';


class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();

}

class _SecondPageState extends State<SecondPage> {

  var userController = TextEditingController();
  var passwordController = TextEditingController();
  bool crossVisible1 = false;
  bool crossVisible2 = false;
  bool _isHidden=true;

  final formKey = GlobalKey<FormState>();
  //List<Book> bookList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(

          preferredSize: const Size.fromHeight(120.0), // here the desired height
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
              padding: const EdgeInsets.only(top: 200.0),

            ),

            // Expanded(
            //   flex: 2,
            //   child: ListView(
            //     children: [Column(
            //       crossAxisAlignment: CrossAxisAlignment.stretch,
            //       children: bookList.map((book) => BookCard(book: book)).toList(),
            //     ),]
            //   ),
            // ),

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
                        flex: 1,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                /*
                                 Navigator.push(
                                    context, MaterialPageRoute(builder: (_) => fourthPage()));
                                 */

                                //bookList.insert(0, Book(bookName: bookController.text, bookAuthor: authorController.text));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Color.fromARGB(200, 255, 187, 119),
                                      duration: Duration(seconds: 2),
                                      content: Column(
                                        children: [
                                          Text('Hello User!!',style: TextStyle(color: Colors.black),),
                                          Text('I am your Personal Financial Manager!',style: TextStyle(color: Colors.black),),

                                        ],
                                      ),

                                    )

                                );

                              });
                            }


                          },
                          icon: Icon(Icons.key,size: 15.0,color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            onPrimary: Colors.amber,
                            elevation: 20,  // Elevation

                          ),
                          label: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 15),

                          ),

                        ),


                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (_) => ThirdPage()));   },


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
class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();

}

class _ThirdPageState extends State<ThirdPage> {
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
                              borderRadius:  BorderRadius.circular(20.0),
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
                      SizedBox(height: 20.0),
                      Expanded(
                        flex: 4,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (_) => SecondPage()));
                                //bookList.insert(0, Book(bookName: bookController.text, bookAuthor: authorController.text));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Color.fromARGB(200, 255, 187, 119),
                                      duration: Duration(seconds: 2),
                                      content: Column(
                                        children: [
                                          Text('Welcome!!',style: TextStyle(color: Colors.black),),
                                          Text('I am your Personal Financial Manager!',style: TextStyle(color: Colors.black),),

                                        ],
                                      ),

                                    )

                                );

                              });
                            }


                          },
                          icon: Icon(Icons.key,size: 15.0,color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            onPrimary: Colors.amber,
                            elevation: 20,  // Elevation

                          ),

                          label: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 15),

                          ),

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

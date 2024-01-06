import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Statistics page/statistics.dart';
import 'Statistics page/bottomnavigationbar.dart';

class HomePage extends StatelessWidget {
  var height, width;

  List imgData = [
    "assets/chat 2.jpg",
    "assets/stat 2.jpg",
    "assets/transaction 2.jpg",
    "assets/woman.png"
  ];

  List titles = [
    "Inbox",
    "Statistics",
    "Transaction",
    "Profile",
  ];

  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out
  void signUserOut() {
    try {
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(

      floatingActionButton: FloatingActionButton(

        onPressed: signUserOut,
        child: Icon(Icons.account_circle_outlined,color: Colors.white),
        backgroundColor: Colors.deepOrange,

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: Container(
        color: Colors.amber,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(),
              height: height * 0.25,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 36,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.sort,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Home",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              height: height * 0.75,
              width: width,
              padding: EdgeInsets.symmetric(vertical: 60),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 25,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: imgData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 1) {
                        // Check if the Statistics container is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bottom(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            imgData[index],
                            width: 100,
                          ),
                          Text(
                            titles[index],
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

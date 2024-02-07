import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coincare/Firestore/firestore_data.dart';

import '../data/Get Transaction Data.dart';
import '../model/addDAta.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var history;
  List<Add_data> dataList = [];

  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  List<String>DataIds= [];

  Future getDataIds()  async {
      await FirebaseFirestore.instance.collection('Users').doc(uid).collection('data').get().then(
              (snapshot) =>snapshot.docs.forEach((document) {
                print(document.reference);
                DataIds.add(document.reference.id);
              }));
      
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 340, child: _head()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transactions History',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: Colors.black,
                      ),
                    ),
                    // Uncomment this section if you want to add a "See all" option
                    // Text(
                    //   'See all',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 15,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
              ),

              Expanded(
                child: FutureBuilder(
                  future: getDataIds(),
                  builder: (context,snapshot){
                    return ListView.builder(
                      itemCount: DataIds.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              title: GetTransactionData(DocumentId: DataIds[index]), // Assuming GetTransactionData returns a widget
                              tileColor: Colors.amberAccent,
                              contentPadding: EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        );

                      },
                    );
                  },
                )
              ),

            ],
          ),
        )

    );



  }

}



/*
Widget getList(Add_data history, int index) {
  return Dismissible(
    key: UniqueKey(),
    onDismissed: (direction) {
      deleteFirestoreData(history); // Call method to delete Firestore data
    },
    child: get(index, history),
  );
}

 */

void deleteFirestoreData(Add_data history) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('data')
          .doc(history.IN)
          .delete();
    }
  } catch (e) {
    print('Error deleting data: $e');
  }
}




Widget _head() {
  return Stack(
    children: [
      Column(
        children: [
          Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 35,
                  left: 340,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Color.fromRGBO(250, 250, 250, 0.1),
                      child: Icon(
                        Icons.notification_add_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good afternoon',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),

                      FutureBuilder<String>(
                        future: FirestoreService.getUsername(),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            else
                              return Text(
                                snapshot.data as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 36,
                                  color: Colors.white,
                                ),
                              );
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      Positioned(
        top: 140,
        left: 37,
        child: Container(
          height: 170,
          width: 320,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 6),
                blurRadius: 12,
                spreadRadius: 6,
              ),
            ],
            color: Colors.amberAccent[700],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Balance',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),

              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: Color.fromARGB(255, 120, 189, 209),
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Income',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: Color.fromARGB(255, 120, 189, 209),
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                        SizedBox(width: 7),
                        Text(
                          'Expenses',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
             /* Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${income()}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '\$ ${expenses()}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )

              */
            ],
          ),
        ),
      )
    ],
  );
}
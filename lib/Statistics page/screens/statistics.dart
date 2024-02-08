import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/Get Transaction Data.dart';
import '../model/addDAta.dart';
import '../widgets/bottomnavigationbar.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

ValueNotifier kj = ValueNotifier(0);

class _StatisticsState extends State<Statistics> {
  List day = ['Day', 'Week', 'Month', 'Year'];
  List f = [];
  List<Add_data> a = [];
  int index_color = 0;
  String? uid = FirebaseAuth.instance.currentUser?.uid;

  Future<DocumentSnapshot?> findDocumentWithHighestAmount() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Users').doc(uid).collection('data').get();

    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot? highestDocument;
      int highestAmount = 0;

      for (var doc in snapshot.docs) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
        if (data != null && data.containsKey('amount')) {
          var amount = data['amount'];
          if (amount is int) {
            if (amount > highestAmount) {
              highestAmount = amount;
              highestDocument = doc;
            }
          } else if (amount is String) {
            var parsedAmount = int.tryParse(amount);
            if (parsedAmount != null && parsedAmount > highestAmount) {
              highestAmount = parsedAmount;
              highestDocument = doc;
            }
          }
        }
      }

      return highestDocument;
    } else {
      // Handle the case where no documents are found
      return null;
    }
  }
  Future<DocumentSnapshot?> findDocumentWithLowestAmount() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('data')
        .get();

    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot? lowestDocument;
      int lowestAmount = 10000000;
      for (var doc in snapshot.docs) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
        if (data != null && data.containsKey('amount')) {
          var amount = data['amount'];
          if (amount is int) {
            if (amount < lowestAmount) {
              lowestAmount = amount;
              lowestDocument = doc;
            }
          } else if (amount is String) {
            var parsedAmount = int.tryParse(amount);
            if (parsedAmount != null && parsedAmount < lowestAmount) {
              lowestAmount = parsedAmount;
              lowestDocument = doc;
            }
          }
        }
      }

      return lowestDocument;
    } else {
      // Handle the case where no documents are found
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0), // here the desired height
        child: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context); // Fix the navigation pop here
            },
          ),
          toolbarHeight: 220,
          title: const Text(
            'Statistics',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'signika'),
          ),
          centerTitle: true,
          backgroundColor:  Color.fromARGB(200, 221, 201, 166),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/statpage2.jpg'), // Provide your image path here
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<DocumentSnapshot?>(
          future: findDocumentWithHighestAmount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              String uidHighest = snapshot.data!.id; // Accessing the ID of the document with highest amount
              return Column(
                children: [
                  Text(
                    'Your highest spending:',
                    style: TextStyle(fontSize: 26.0),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage('assets/card.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: ListTile(
                              title: GetStatData(DocumentId: uidHighest),
                              tileColor: Colors.transparent,
                              contentPadding: EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),




                  SizedBox(height: 20), // Add spacing between highest and lowest spending cards
                  Text(
                    'Your lowest spending:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Expanded(
                    child: FutureBuilder<DocumentSnapshot?>(
                      future: findDocumentWithLowestAmount(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData && snapshot.data != null) {
                          String uidLowest = snapshot.data!.id;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage('assets/card.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Center(
                                  child: ListTile(
                                    title: GetStatData(DocumentId: uidLowest),
                                    tileColor: Colors.transparent,
                                    contentPadding: EdgeInsets.all(16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Center(
                            child: Text('No data'),
                          );
                        }
                      },
                    ),
                  ),



                ],
              );
            } else {
              return Center(
                child: Text('No data'),
              );
            }
          },
        ),
      ),


    );

  }
}

CustomScrollView custom() {
  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Statistics',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    4,
                        (index) {
                      return GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          /*decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index_color == index
                                ? Color.fromARGB(255, 47, 125, 121)
                                : Colors.white,
                          ),*/
                          alignment: Alignment.center,
                          /*child: Text(
                            day[index],
                            style: TextStyle(
                              color: index_color == index
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),*/
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            //SizedBox(height: 20),

            //SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Spending',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.swap_vert,
                    size: 25,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              /*return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset('images/${a[index].name}.png', height: 40),
                ),
                title: Text(
                  a[index].name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  ' ${a[index].datetime.year}-${a[index].datetime.day}-${a[index].datetime.month}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  a[index].amount,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: a[index].IN == 'Income' ? Colors.green : Colors.red,
                  ),
                ),
              );*/
            },
            //childCount: a.length,
          ))
    ],
  );
}

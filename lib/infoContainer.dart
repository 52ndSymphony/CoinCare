import 'package:coincare/money_send.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Firestore/firestore_data.dart';

class InfoContainer extends StatelessWidget {
  InfoContainer({Key? key}) : super(key: key);
  String? uid = FirebaseAuth.instance.currentUser?.uid;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 15),
      height: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(211, 246, 178, 3),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [
            const Color(0xFFE0AE0C),
            const Color(0xFFE7A910).withOpacity(0.55),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 22,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

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
                                  fontSize: 35.0,
                                  color: Colors.white,
                                ),
                              );
                          }
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    width: 250,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 56,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'your total balance',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const Icon(
                Icons.remove_red_eye_rounded,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          FutureBuilder<String>(
            future: FirestoreService.getbalance(),
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
                      fontSize: 26.0,
                      color: Colors.white,
                    ),
                  );
              }
            },
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              /*Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to a new page when "send" button is pressed
                    Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => MoneySend()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                    const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      'send',
                      style: TextStyle(fontSize: 12, color: Colors.amber),
                    ),
                  ),
                ),
              ),*/
              const SizedBox(
                width: 8,
              ),

            ],
          )
        ],
      ),
    );
  }
}


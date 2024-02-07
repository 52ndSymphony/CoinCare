import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coincare/infoContainer.dart';
import 'package:coincare/quick_send.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'Statistics page/statistics.dart';
//import 'Statistics page/bottomnavigationbar.dart';
import 'chat/welcome_page.dart';

class Transaction extends StatelessWidget {
  Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InfoContainer(),
                const SizedBox(
                  height: 32,
                ),
                QuickSend(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'History',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GridView.builder(
                        itemCount: 10,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (ctx, index) {
                          return Container(
                            padding: EdgeInsets.all(6),
                            width: 100,
                            height: 100,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width : 30,
                                        height: 30,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?cs=srgb&dl=pexels-italo-melo-2379004.jpg&fm=jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        children: const [
                                          Text(
                                              'Ahnaf',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              )
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text('14/01/2024',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

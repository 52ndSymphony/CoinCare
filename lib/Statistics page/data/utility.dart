

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/addDAta.dart';

int totals = 0;




Future<int> total() async {
  int totals = 0;

  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('data')
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      List<int> amounts = [];
      docs.forEach((doc) {
        Add_data data = Add_data.fromMap(doc.data() as Map<String, dynamic>);
        int amount = 0;

        try {
          if (data.IN == 'Income') {
            amount = int.tryParse(data.amount) ?? 0;
          } else {
            amount = -(int.tryParse(data.amount) ?? 0);
          }
        } catch (e) {
          print('Error parsing amount: $e');
        }

        amounts.add(amount);
      });

      totals = amounts.reduce((value, element) => value + element);
    } else {
      // Handle the case where the user is not authenticated or the user object is null
    }
  } catch (e) {
    print('Error calculating total: $e');
  }
  return totals;
}



Future<int> income() async {
  int totals = 0;

  try {
    // Get the current user after successful authentication
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      // Use 'uid' to query Firestore for the user's income data
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('data')
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      List<int> amounts = [];
      docs.forEach((doc) {
        Add_data data = Add_data.fromMap(doc.data() as Map<String, dynamic>);
        int amount = data.IN == 'Income' ? int.tryParse(data.amount) ?? 0 : 0;
        amounts.add(amount);
      });

      totals = amounts.reduce((value, element) => value + element);
    } else {
      // Handle the case where the user is not authenticated or the user object is null
    }
  } catch (e) {
    print('Error calculating income: $e');
  }
  return totals;
}
Future<int> expenses() async {
  int totals = 0;

  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('data')
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      List<int> amounts = [];
      docs.forEach((doc) {
        Add_data data = Add_data.fromMap(doc.data() as Map<String, dynamic>);
        int amount = data.IN != 'Income' ? int.tryParse(data.amount) ?? 0 : 0;
        amounts.add(amount);
      });

      totals = amounts.reduce((value, element) => value + element);
    } else {
      // Handle the case where the user is not authenticated or the user object is null
    }
  } catch (e) {
    print('Error calculating expenses: $e');
  }
  return totals;
}

Future<List<Add_data>> today() async {
  List<Add_data> todayData = [];
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('data')
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      DateTime date = DateTime.now();
      docs.forEach((doc) {
        Add_data data = Add_data.fromMap(doc.data() as Map<String, dynamic>);
        if (data.datetime != null && data.datetime!.day == date.day) {
          todayData.add(data);
        }
      });
    } else {
      // Handle the case where the user is not authenticated or the user object is null
    }
  } catch (e) {
    print('Error fetching today\'s data: $e');
  }
  return todayData;
}

Future<List<Add_data>> week() async {
  List<Add_data> a = [];
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('data')
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      DateTime date = DateTime.now();
      DateTime weekAgo = date.subtract(Duration(days: 7));

      docs.forEach((doc) {
        Add_data data = Add_data.fromMap(doc.data() as Map<String, dynamic>);
        if (data.datetime != null &&
            data.datetime!.isAfter(weekAgo) &&
            data.datetime!.isBefore(date)) {
          a.add(data);
        }
      });
    } else {
      // Handle the case where the user is not authenticated or the user object is null
    }
  } catch (e) {
    print('Error fetching data for the week: $e');
  }
  return a;
}

Future<List<Add_data>> month() async {
  List<Add_data> a = [];
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('data')
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      DateTime date = DateTime.now();

      docs.forEach((doc) {
        Add_data data = Add_data.fromMap(doc.data() as Map<String, dynamic>);
        if (data.datetime != null && data.datetime!.month == date.month) {
          a.add(data);
        }
      });
    } else {
      // Handle the case where the user is not authenticated or the user object is null
    }
  } catch (e) {
    print('Error fetching data for the month: $e');
  }
  return a;
}

Future<List<Add_data>> year() async {
  List<Add_data> a = [];
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('data')
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      DateTime date = DateTime.now();

      docs.forEach((doc) {
        Add_data data = Add_data.fromMap(doc.data() as Map<String, dynamic>);
        if (data.datetime != null && data.datetime!.year == date.year) {
          a.add(data);
        }
      });
    } else {
      // Handle the case where the user is not authenticated or the user object is null
    }
  } catch (e) {
    print('Error fetching data for the year: $e');
  }
  return a;
}

Future<int> total_chart(List<QueryDocumentSnapshot> history2) async {
  int totals = 0;

  try {
    List<int> amounts = [];

    history2.forEach((doc) {
      // Assuming 'amount' is a field in your Firestore document stored as a string
      String amountAsString = doc.get('amount') as String;
      int amount = int.parse(amountAsString);
      amounts.add(amount);
    });

    totals = amounts.reduce((value, element) => value + element);
  } catch (e) {
    print('Error calculating total chart: $e');
  }

  return totals;
}



Future<List<int>> time(List<Add_data> history2, bool hour) async {
  List<int> total = [];
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('data')
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      int counter = 0;

      for (var c = 0; c < history2.length; c++) {
        List<Add_data> a = [];
        for (var i = c; i < history2.length; i++) {
          if (hour) {
            if (history2[i].datetime?.hour == history2[c].datetime?.hour) {
              a.add(history2[i]);
              counter = i;
            }
          } else {
            if (history2[i].datetime?.day == history2[c].datetime?.day) {
              a.add(history2[i]);
              counter = i;
            }
          }
        }
        total.add(await total_chart(docs));
        c = counter;
      }
    } else {
      // Handle the case where the user is not authenticated or the user object is null
    }
  } catch (e) {
    print('Error in time calculation: $e');
  }
  return total;
}

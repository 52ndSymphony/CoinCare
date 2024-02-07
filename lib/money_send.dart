import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoneySend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String usernameError = '';
  String amountError = '';

  // Variables to store entered username and amount
  String enteredUsername = '';
  double amount = 0.0;

  void _sendMoney() {
    setState(() {
      usernameError = usernameController.text.trim().isEmpty
          ? 'Please enter your username'
          : '';

      amountError = amountController.text.trim().isEmpty
          ? 'Please enter the amount'
          : '';

      if (usernameError.isEmpty && amountError.isEmpty) {
        // Store entered values in variables
        enteredUsername = usernameController.text.trim();
        amount = double.parse(amountController.text.trim());

        // Upload data to Firebase
        _uploadToFirebase(enteredUsername, amount);

        // Perform actions when the username and amount are not empty
        // For simplicity, let's just show a success snackbar.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Money sent successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.amberAccent,
          ),
        );
      }
    });
  }

  Future<void> _uploadToFirebase(String username, double amount) async {
    try {
      // Get a reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add a new document with a generated ID
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance.collection('Users').doc(uid).collection('transactions').add({
        'username': username,
        'amount': amount,
        'timestamp': FieldValue.serverTimestamp(), // Optional: Include a timestamp
      });

      print('Data uploaded to Firebase successfully');
    } catch (e) {
      print('Error uploading data to Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        toolbarHeight: 130,
        title: Text(' Transfer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: usernameError,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                errorText: amountError,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _sendMoney,
              child: Text('Send Money'),
            ),
          ],
        ),
      ),
    );
  }
}

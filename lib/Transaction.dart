import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coincare/infoContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Transaction extends StatefulWidget {
  Transaction({Key? key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String usernameError = '';
  String amountError = '';

  void _sendMoney() {
    setState(() {
      usernameError = usernameController.text.trim().isEmpty
          ? 'Please enter your username'
          : '';
      amountError = amountController.text.trim().isEmpty
          ? 'Please enter the amount'
          : '';

      if (usernameError.isEmpty && amountError.isEmpty) {
        // Process sending money here
        String enteredUsername = usernameController.text.trim();
        double amount = double.parse(amountController.text.trim());
        _uploadToFirebase(enteredUsername, amount);

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
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('transactions')
          .add({
        'username': username,
        'amount': amount,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('Data uploaded to Firebase successfully');
    } catch (e) {
      print('Error uploading data to Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InfoContainer(),
                const SizedBox(
                  height: 32,
                ),
                Padding(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

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

  void _sendMoney() {
    setState(() {
      usernameError = usernameController.text.trim().isEmpty
          ? 'Please enter your username'
          : '';

      amountError = amountController.text.trim().isEmpty
          ? 'Please enter the amount'
          : '';

      if (usernameError.isEmpty && amountError.isEmpty) {
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


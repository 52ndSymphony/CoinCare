import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final Timestamp timestamp;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser? Color.fromARGB(255, 239, 187, 143):Colors.red[300],
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      child: Column(
      children: [
        Text(message,
        style: TextStyle(fontFamily: 'signika',color: Colors.white,fontSize: 25),),
        const SizedBox(height: 5,),
        Text(
          _formatDateTime(timestamp.toDate()),
          style: TextStyle(fontFamily: 'signika', color: Colors.white, fontSize: 14),
        ),

      ],
    )
    );
  }
  String _formatDateTime(DateTime dateTime) {
    String formattedDateTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return formattedDateTime;
  }
}

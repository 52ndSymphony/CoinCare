import 'package:flutter/material.dart';
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser? Colors.orange:Colors.deepOrangeAccent,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
      child: Text(message,
      style: TextStyle(fontFamily: 'signika',color: Colors.white,fontSize: 25),),
    );
  }
}

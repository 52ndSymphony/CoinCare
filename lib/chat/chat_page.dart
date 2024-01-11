import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coincare/auth_service.dart';
import 'package:coincare/chat/chat_bubble.dart';
import 'package:coincare/chat/start_chatting.dart';
import 'package:coincare/my_text.dart';
import 'package:flutter/material.dart';
class ChatPage extends StatelessWidget {

  final String username;
  final String receiverID;


  ChatPage({
    super.key,
    required this.username,
    required this.receiverID,
  });
  final TextEditingController messageController=TextEditingController();
  final Hello chatService=Hello();
  final AuthService authService=AuthService();
  void sendMessage() async{
    if(messageController.text.isNotEmpty){
      await chatService.sendMessage(receiverID, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text(username),
      ),
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
          buildUserInput(),
        ],
      ),
    );
  }
  Widget buildMessageList(){
    String senderID=authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chatService.getMessages(receiverID, senderID),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Text("Error");
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Text("Loading...");
          }
          return ListView(
            children: snapshot.data!.docs.map((doc)=>buildMessageItem(doc)).toList(),

          );
        },
    );
  }
  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String,dynamic>;
   bool isCurrentUser=data['senderID']==authService.getCurrentUser()!.uid;
   var alignment=isCurrentUser? Alignment.centerRight:Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
          ],
        ));

  }
  Widget buildUserInput(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [

          Expanded(
            child: TextFormField(

            controller: messageController,
              decoration: InputDecoration(
                enabledBorder:  OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(15.0),
                  borderSide:  BorderSide(color: Colors.white,width: 2
                  ),

                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,width: 2),
                ),
                errorStyle:TextStyle(color: Colors.white),
                label: Text(
                  'Type your text',
                  style: TextStyle(fontSize: 20,color: Colors.black),
                ),
                filled: true,
                fillColor: Color.fromARGB(200, 255, 187, 119),

              ),

          ),),
          SizedBox(width: 12,),
          Container(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle
            ),
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward,color: Colors.white,))),

        ],
      ),
    );
  }
  }


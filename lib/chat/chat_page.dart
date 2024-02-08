import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coincare/auth_service.dart';
import 'package:coincare/chat/chat_bubble.dart';
import 'package:coincare/chat/start_chatting.dart';
import 'package:coincare/chat_notification_service.dart';
import 'package:coincare/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ChatPage extends StatefulWidget {

  final String username;
  final String receiverID;


  ChatPage({
    super.key,
    required this.username,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController=TextEditingController();
  final notificationsService=Chat_Notification_Services();

  final Hello chatService=Hello();

  final AuthService authService=AuthService();
  FocusNode myFocusNode=FocusNode();
  @override
  void initState(){
    notificationsService.getRecieverToken(widget.receiverID);
    super.initState();
    myFocusNode.addListener(() {
      if(myFocusNode.hasFocus){
        Future.delayed(const Duration(milliseconds: 500),
            ()=>scrollDown(),
        );
      }
    });
    Future.delayed(const Duration(milliseconds: 500),()=>scrollDown());
    notificationsService.firebaseNotification(context);
  }
  @override
  void dispose(){
    myFocusNode.dispose();
    messageController.dispose();
    super.dispose();
  }
  final ScrollController scrollController=ScrollController();
  void scrollDown(){
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn,);
  }

  void sendMessage() async{
    if(messageController.text.isNotEmpty){
      await chatService.sendMessage(widget.receiverID, messageController.text);
      await notificationsService.sendNotification(body: messageController.text, senderID: FirebaseAuth.instance.currentUser!.uid);
      messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus=FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
          appBar: AppBar(

            leading: BackButton(
              color: Colors.white,
            ),
            toolbarHeight: 120,
            title: Text(
                widget.username,
                style: TextStyle(fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'signika')
            ),

            backgroundColor:  Color.fromARGB(200, 221, 201, 166),
          ),

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/chatting.jpg'), // Provide your image path here
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(child: buildMessageList()),
              buildUserInput(),
            ],
          ),
        )

      ),
    );
  }

  Widget buildMessageList(){
    String senderID=authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chatService.getMessages(widget.receiverID, senderID),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Text("Error");
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Text("Loading...");
          }
          return ListView(
            controller: scrollController,
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
              focusNode: myFocusNode,
              decoration: InputDecoration(
                enabledBorder:  OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(15.0),
                  borderSide:  BorderSide(color: Colors.grey,width: 3
                  ),

                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange,width: 3),
                ),
                errorStyle:TextStyle(color: Colors.white),
                label: Text(
                  'Type your text',
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                filled: true,
                fillColor: Color.fromARGB(200, 186, 197, 192),

              ),

          ),),
          SizedBox(width: 12,),
          Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle
            ),
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward,color: Colors.white,))),

        ],
      ),
    );
  }
}


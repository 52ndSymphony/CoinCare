import 'package:coincare/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:coincare/user_tile.dart';
import 'chat_page.dart';
import 'start_chatting.dart';
import 'package:coincare/auth_page.dart';
class Home extends StatelessWidget {
  Home({super.key});

  final Hello chatService = Hello();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,

      appBar: PreferredSize(


          preferredSize: const Size.fromHeight(110.0),
          // here the desired height

          child: AppBar(

            leading: BackButton(
              color: Colors.white,
            ),
            toolbarHeight: 220,
            title: const Text(
                'USERS',
                style: TextStyle(fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'signika')
            ),

            centerTitle: true,

            backgroundColor:  Theme.of(context).colorScheme.primary,
          )
      ),

      body: buildUserList(),


    );
  }

  Widget buildUserList() {
    return StreamBuilder(stream: chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading.....');
          }
          return ListView(
            children: snapshot.data!.map<Widget>((userData) =>
                buildUserListItem(
                    userData, context)).toList(),
          );
        }
    );
  }

  Widget buildUserListItem(Map<String, dynamic>userData, BuildContext context) {
    if (userData["email"] != authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["username"]==null?'set your name':userData["username"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                ChatPage(
                    username: userData["username"]==null?'set your name':userData["username"],
                    receiverID: userData["uid"],)
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
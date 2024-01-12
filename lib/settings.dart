import 'package:coincare/chat/users_page.dart';
import 'package:coincare/home.dart';
import 'package:coincare/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: PreferredSize(


          preferredSize: const Size.fromHeight(110.0), // here the desired height
          child: AppBar(
            leading: BackButton(
              color: Colors.white,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
            ),

            toolbarHeight: 220,
            title: const Text(
                'Settings',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'signika')
            ),
            centerTitle: true,
            backgroundColor: Colors.orange,
          )
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [



      Text("Dark Mode",style: TextStyle(color: Colors.white,fontFamily: 'signika',fontSize: 26,fontWeight: FontWeight.bold),),
      CupertinoSwitch(value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode, onChanged: (value)=>Provider.of<ThemeProvider>(context,listen: false).toggleTheme()),
      ],

    ),
    );
  }
}

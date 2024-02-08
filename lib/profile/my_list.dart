import 'package:flutter/material.dart';
class MylistTile extends StatelessWidget {
  final String text;
  final String sectionName;


  const MylistTile({super.key,required this.text,required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.only(
        left: 15,
        right: 15
      ),
      margin: EdgeInsets.only(left:20,right: 20,top: 20 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName),
              IconButton(onPressed:(){},icon:Icon(Icons.settings)),
            ],
          ),
          Text(text,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)

        ],
      ),
    );
  }
}

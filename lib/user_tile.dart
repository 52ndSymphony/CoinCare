import 'package:flutter/material.dart';
class UserTile extends StatelessWidget{
  final String text;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.text,
   required this.onTap,

});
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 8, 0),
        child: SingleChildScrollView(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(5),
          
            ),
            child: Row(
              children: [
                Icon(Icons.person_2_outlined,color: Colors.white,),
                SizedBox(width: 12,),
                Text(text,style: TextStyle(color: Colors.white,fontFamily: 'signika',fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;
  final String text;

  const MyButton({super.key,required this.onTap,required this.text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 200,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 100),
        decoration: BoxDecoration(
            color:  Colors.orange,
            borderRadius: BorderRadius.circular(20),
            boxShadow:[
              BoxShadow(
                color: Colors.orange,
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(4,4),
              ),
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(-4,-4),
              )
            ]

        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                //fontWeight: FontWeight.bold,
                fontSize: 20,

            ),

          ),
        ),
      ),
    );
  }
}

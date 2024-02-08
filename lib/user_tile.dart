import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 13, 0),
        child: SingleChildScrollView(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/chathead.jpg'), // Provide your image path here
                fit: BoxFit.cover,
              ),
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                SizedBox(width: 12),
                Icon(Icons.person_outline, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'signika',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class QuickSend extends StatelessWidget {
  QuickSend({super.key});

  final profiles = [
    null,
    'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?cs=srgb&dl=pexels-italo-melo-2379004.jpg&fm=jpg',
    'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
    'https://img.freepik.com/free-photo/expressive-bearded-man-wearing-shirt_273609-5894.jpg?size=626&ext=jpg&ga=GA1.1.2116175301.1701475200&semt=ais',
    'https://img.freepik.com/premium-photo/confident-man-wear-casual-shirt-keeping-arms-crossed-grey-background-informal-clothing-copy-space_545934-3224.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'quick send',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),

            ],
          ),
          const SizedBox(
            height: 26,
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
                itemCount: profiles.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index){
                  return Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(25)),
                      child: index == 0
                          ? Icon(
                        Icons.add,
                        color: Colors.white.withOpacity(1.0),
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(profiles[index]!,
                          fit: BoxFit.cover,
                        ),
                      )


                  );

                }
            ),
          )
        ],
      ),
    );
  }
}


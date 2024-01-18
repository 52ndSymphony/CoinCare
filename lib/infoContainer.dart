import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget{
  const InfoContainer({super.key});

  @override
  Widget build(BuildContext){
    return Container(
      padding: const EdgeInsets.only(
          left: 16, right: 16, bottom: 16, top: 15
      ),
      height: 270,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(211, 246, 178, 3),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                const Color(0xFFE0AE0C),
                const Color(0xFFE7A910).withOpacity(0.55),
              ]
          )

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 22,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(1.0),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Ahnaf',
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white.withOpacity(1.0),
                        ),
                      ),
                    ],


                  ),
                  SizedBox(
                    width: 250,
                  ),
                  /*Column(
                    children: [
                      const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 22,
                      ),
                    ],
                  )*/
                ],

              ),
            ],
          ),
          const SizedBox(
            height: 56,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(
                'your total balance',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const Icon(Icons.remove_red_eye_rounded,
                color: Colors.white,),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '\৳ 12000',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.white),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Expanded(child:
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    vertical: 16),
                decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius: BorderRadius.circular(25)),

                child: const Text(
                  'request',
                  style: TextStyle(
                      fontSize: 12, color: Colors.amber),
                ),

              ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16),
                    decoration: BoxDecoration(
                        color:  Colors.black,
                        borderRadius: BorderRadius.circular(25)),
                    //color: Colors.deepOrange,
                    child: const Text(
                      'send',
                      style: TextStyle(
                          fontSize: 12, color: Colors.amber
                      ),
                    ),
                  )
              )

            ],
          )
        ],
      ),
    );
  }
}

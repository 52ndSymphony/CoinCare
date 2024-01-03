import 'package:flutter/material.dart';


class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

ValueNotifier kj = ValueNotifier(0);

class _StatisticsState extends State<Statistics> {
  List day = ['Day', 'Week', 'Month', 'Year'];

  int index_color = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}

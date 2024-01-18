
import '../data/utility.dart';
import '../model/addDAta.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  int indexx;
  Chart({Key? key, required this.indexx}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Add_data>? a;
  bool b = true;
  bool j = true;
  late Future<List<int>> timeFuture;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /*
  void fetchData() async {
    List<Add_data> data = []; // Fetch data from Firestore here
    // You can replace this with your Firestore data fetching logic
    // For example:
    // data = await fetchDataFromFirestore();

    setState(() {
      a = data;
      timeFuture = time(a!, b ? true : false);
    });
  }

   */



    void fetchData() async {
      switch (widget.indexx) {
        case 0:
          a = await today();
          b = true;
          j = true;
          break;
        case 1:
          a = await week();
          b = false;
          j = true;
          break;
        case 2:
          a = await month();
          b = false;
          j = true;
          break;
        case 3:
          a = await year();
          j = false;
          break;
        default:
      }
      setState(() {
        timeFuture = time(a!, b ? true : false);
      });
    }
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      fetchData();
    }

    return FutureBuilder<List<int>>(
      future: timeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loader while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Container(
            width: double.infinity,
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <SplineSeries<SalesData, String>>[
                SplineSeries<SalesData, String>(
                  color: Color.fromARGB(255, 47, 125, 121),
                  width: 3,
                  dataSource: <SalesData>[
                    ...List.generate(snapshot.data!.length, (index) {
                      return SalesData(
                        j
                            ? b
                            ? a![index].datetime!.hour.toString()
                            : a![index].datetime!.day.toString()
                            : a![index].datetime!.month.toString(),
                        b
                            ? index > 0
                            ? snapshot.data![index] +
                            snapshot.data![index - 1]
                            : snapshot.data![index]
                            : index > 0
                            ? snapshot.data![index] +
                            snapshot.data![index - 1]
                            : snapshot.data![index],
                      );
                    })
                  ],
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                )
              ],
            ),
          );
        }
      },
    );
  }
}



class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final int sales;
}

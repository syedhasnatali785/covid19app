import 'package:covid19app/views/world_stats_screen.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name, image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailsScreen({
    required this.totalCases,
    required this.critical,
    required this.todayRecovered,
    required this.active,
    required this.test,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.name,
    required this.image,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name.toString()), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    top: MediaQuery.of(context).size.height * .06,
                  ),
                  child: Card(
                    elevation: 2.5,
                    color: Colors.white,
                    child: Column(
                      children: [
                        ReusableRow(
                          title: 'Total Cases',
                          value: widget.totalCases.toString(),
                        ),
                        ReusableRow(
                          title: 'Total Cases',
                          value: widget.totalCases.toString(),
                        ),
                        ReusableRow(
                          title: 'Critical Cases',
                          value: widget.critical.toString(),
                        ),
                        ReusableRow(
                          title: 'Tests',
                          value: widget.test.toString(),
                        ),
                        ReusableRow(
                          title: 'Active Cases',
                          value: widget.active.toString(),
                        ),
                        ReusableRow(
                          title: 'Today Recoveries',
                          value: widget.todayRecovered.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.image),
                  radius: 60,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Go Back", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(

                backgroundColor: Color(0xfff14B8A6),
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: MediaQuery.of(context).size.height * .19,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

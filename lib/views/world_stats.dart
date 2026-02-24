import 'package:covid19app/Model/world_stats_model.dart';
import 'package:covid19app/Services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

// color code
final List<Color> colorList = [
  Color(0xff4285F4),
  Color(0xff1aa260),
  Color(0xffde5246),
];
late Future<WorldStatsModel> worldstatistics;

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..repeat();
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    worldstatistics = StatsServices().fetchWorldStatsRecords();
  }

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .07),
                FutureBuilder(
                  future: worldstatistics,
                  builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SpinKitFadingCube(color: Colors.white),
                      );
                    } else {
                      final data = snapshot.data!;

                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(data.cases.toString()),
                              "Recovered": double.parse(
                                data.recovered.toString(),
                              ),
                              "Deaths": double.parse(data.deaths.toString()),
                            },
                            animationDuration: Duration(milliseconds: 1200),
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .04,
                          ),

                          Card(
                            color: Colors.blueGrey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .002,
                                ),
                                ReusableRow(title: 'Total', value: '23K'),
                                ReusableRow(title: 'Afg', value: '23K'),
                                ReusableRow(title: 'US', value: '23K'),
                                ReusableRow(title: 'PK', value: '23k'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .04,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.height * .4,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Track Countries",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: Colors.white)),
              Text(value, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}

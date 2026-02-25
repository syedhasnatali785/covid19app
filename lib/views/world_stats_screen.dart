import 'package:covid19app/Model/world_stats_model.dart';
import 'package:covid19app/Services/stats_services.dart';
import 'package:covid19app/views/countries_list_screen.dart';
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
      appBar: AppBar(
        title: Text(
          'Statistics',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff1E3A8A),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: worldstatistics,
                  builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: SpinKitFadingCube(color: Colors.white),
                        ),
                      );
                    } else {
                      final data = snapshot.data!;

                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Card(
                            color: Color(0xfffFFFFF),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: PieChart(
                                dataMap: {
                                  "Total": double.parse(data.cases.toString()),
                                  "Recovered": double.parse(
                                    data.recovered.toString(),
                                  ),
                                  "Deaths": double.parse(
                                    data.deaths.toString(),
                                  ),
                                },

                                baseChartColor: Colors.red,
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                  showChartValueBackground: true,
                                ),
                                animationDuration: Duration(milliseconds: 1200),
                                legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left,
                                ),
                                chartType: ChartType.ring,
                                colorList: colorList,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .04,
                          ),

                          Card(
                            color: Color(0xfffFFFFFF),
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .002,
                                ),
                                ReusableRow(
                                  title: 'Total Cases',
                                  value: data!.cases.toString(),
                                ),
                                Divider(color: Colors.grey.shade300),

                                ReusableRow(
                                  title: 'Deaths',
                                  value: data!.deaths.toString(),
                                ),
                                ReusableRow(
                                  title: 'Active',
                                  value: data!.active.toString(),
                                ),
                                ReusableRow(
                                  title: 'Recovered',
                                  value: data!.recovered.toString(),
                                ),
                                ReusableRow(
                                  title: 'Critical',
                                  value: data!.critical.toString(),
                                ),
                                ReusableRow(
                                  title: 'Today Deaths',
                                  value: data!.todayDeaths.toString(),
                                ),
                                ReusableRow(
                                  title: 'Today Recovered',
                                  value: data!.todayRecovered.toString(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .04,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountriesListScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.height * .4,
                                decoration: BoxDecoration(
                                  color: Color(0xfff14B8A6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Track Countries",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
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
              Text(title, style: TextStyle(color: Colors.black)),
              Text(value, style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ],
    );
  }
}

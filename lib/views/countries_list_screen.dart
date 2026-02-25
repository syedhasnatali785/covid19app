import 'package:covid19app/Services/stats_services.dart';
import 'package:covid19app/views/details_screen.dart';
import 'package:covid19app/views/world_stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  StatsServices statsServices = StatsServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Search Countries",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statsServices.fetchCountriesList(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return Shimmer.fromColors(
                      baseColor: Color(0xffF3F4F6),
                      highlightColor: Color(0xff374151),
                      child: ListView.builder(
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Container(
                              height: 10,
                              width: 70,
                              color: Colors.white,
                            ),
                            leading: Container(
                              height: 40,
                              width: 65,
                              color: Colors.white,
                            ),
                            subtitle: Container(
                              height: 10,
                              width: 30,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];

                        if (searchController.text.isEmpty) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(

                                    totalCases:
                                        snapshot.data![index]['cases'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered:
                                        snapshot.data![index]['todayRecovered'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    totalDeaths:
                                        snapshot.data![index]['deaths'],
                                    totalRecovered:
                                        snapshot.data![index]['recovered'],
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              leading: Image(
                                image: NetworkImage(
                                  snapshot.data![index]['countryInfo']['flag']
                                      .toString(),
                                ),
                                fit: BoxFit.cover,
                                height: 40,
                                width: 65,
                              ),
                              subtitle: Text(
                                snapshot.data![index]['cases'].toString(),
                              ),
                            ),
                          );
                        } else if (name.toLowerCase().contains(
                          searchController.text.toLowerCase(),
                        )) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(

                                    totalCases:
                                    snapshot.data![index]['cases'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered:
                                    snapshot.data![index]['todayRecovered'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    totalDeaths:
                                    snapshot.data![index]['deaths'],
                                    totalRecovered:
                                    snapshot.data![index]['recovered'],
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                  ),
                                ),
                              );
                            },child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              leading: Image.network(
                                snapshot.data![index]['countryInfo']['flag']
                                    .toString(),
                                fit: BoxFit.cover,
                                height: 40,
                                width: 65,
                              ),

                              subtitle: Text(
                                snapshot.data![index]['cases'].toString(),
                              ),
                            ),
                          );
                        } else {
                          return Center(child: Container());
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

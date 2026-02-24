import 'dart:convert';

import 'package:covid19app/Model/world_stats_model.dart';
import 'package:covid19app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  Future<WorldStatsModel> fetchWorldStatsRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatsApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
}

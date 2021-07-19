import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spacex/Models/flight_model.dart';

class FlightRepo {
  Future getFlightData() async {
    Uri link = Uri.parse('https://api.spacexdata.com/v4/launches/latest');
    var res = await http.get(link).timeout(const Duration(seconds: 60));
    var content = res.body;

    if (res.statusCode == 200) {
      try {
        FlightModel _flightModel = FlightModel.fromJson(jsonDecode(content));
        return _flightModel;
      } catch (error) {
        print(error);
      }
    } else {
      //Return null if something goes wrong.
      return null;
    }
  }
}

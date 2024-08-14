import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newtok_tech/components/utils/constants.dart';

class WeatherService {
  final String _baseUrl = "https://api.weatherapi.com/v1/current.json";

  Future<List<Map<String, dynamic>>> fetchWeatherReports(
      {required List<String> locations}) async {
    List<Map<String, dynamic>> weatherReports = [];

    for (var location in locations) {
      try {
        var response = await http.get(
          Uri.parse(_baseUrl).replace(
            queryParameters: {
              'key': AppConstants.apiKey,
              'q': location,
            },
          ),
        );

        if (response.statusCode == 200) {
          weatherReports.add(jsonDecode(response.body));
        } else {
          weatherReports.add({'error': 'Failed to fetch data for $location'});
        }
      } catch (e) {
        weatherReports.add({'error': 'Failed to fetch data for $location'});
      }
    }
    return weatherReports;
  }
}

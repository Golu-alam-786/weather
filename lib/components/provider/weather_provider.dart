import 'package:flutter/material.dart';
import 'package:newtok_tech/modules/user/screens/weather_report_screen.dart';
import 'package:newtok_tech/modules/user/services/excel_service.dart';
import 'package:newtok_tech/modules/user/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  List<String> _locations = [];
  List<Map<String, dynamic>> _weatherReports = [];
  String _errorMessage = '';

  List<String> get locations => _locations;
  List<Map<String, dynamic>> get weatherReports => _weatherReports;
  String get errorMessage => _errorMessage;

  final ExcelService _excelService = ExcelService();
  final WeatherService _weatherService = WeatherService();

  Future<void> uploadFile(BuildContext context) async {
    var file = await _excelService.pickFile();

    if (file != null) {
      try {
        var parsedLocations = await _excelService.parseFile(file);
        _locations = parsedLocations.map((row) => row.join(', ')).toList();
        _errorMessage = '';
        notifyListeners();

        await fetchWeatherReports().then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const WeatherReportScreen(),));
        },);
      } catch (e) {
        _errorMessage = 'Failed to process the file: $e';
        notifyListeners();
      }
    } else {
      _errorMessage = 'No file selected';
      notifyListeners();
    }
  }

  Future<void> fetchWeatherReports() async {
    try {
      var reports = await _weatherService.fetchWeatherReports(locations: _locations);
      _weatherReports = reports;
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to fetch weather data: $e';
      notifyListeners();
    }
  }
}
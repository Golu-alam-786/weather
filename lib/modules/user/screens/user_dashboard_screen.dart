import 'package:flutter/material.dart';
import 'package:newtok_tech/components/services/auth_service.dart';
import 'package:newtok_tech/components/widgets/footer_widget.dart';
import 'package:newtok_tech/components/widgets/navbar_widget.dart';
import 'package:newtok_tech/modules/user/services/excel_service.dart';
import 'package:newtok_tech/modules/user/services/weather_service.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  List<String> _locations = [];
  List<Map<String, dynamic>> _weatherReports = [];
  String _errorMessage = '';

 AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavbarWidget(title: "User Dashboard",actions: [IconButton(onPressed: (){
          authService.signOut(context);
        }, icon: const Icon(Icons.logout,color: Colors.white,))],),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _uploadFile,
                  child: const Text('Upload Excel File'),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 10,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _locations.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_locations[index]),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                _errorMessage.isNotEmpty
                    ? Text(_errorMessage,
                        style: const TextStyle(color: Colors.red),
                )
                    : _weatherReports.isNotEmpty
                        ? _buildWeatherReports()
                        : const Text("No weather data available."),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const FooterWidget(),
    );
  }

  Future<void> _uploadFile() async {
    ExcelService excelService = ExcelService();
    var file = await excelService.pickFile();

    if (file != null) {
      try {
        var locations = await excelService.parseFile(file);
        setState(() {
          _locations = locations.map((row) => row.join(', ')).toList();
          _errorMessage = '';
        });

        await _fetchWeatherReports();
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to process the file: $e';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'No file selected';
      });
    }
  }

  Future<void> _fetchWeatherReports() async {
    WeatherService weatherService = WeatherService();
    try {
      var reports = await weatherService.fetchWeatherReports(locations: _locations);
      setState(() {
        _weatherReports = reports;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch weather data: $e';
      });
    }
  }

  Widget _buildWeatherReports() {
    return Column(
      children: [
        _buildWeatherReportLayout1(),
        _buildWeatherReportLayout2(),
        _buildWeatherReportLayout3(),
        _buildWeatherReportLayout4(),
        _buildWeatherReportLayout5(),
      ],
    );
  }

  Widget _buildWeatherReportLayout1() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[200],
      child: Column(
        children: _weatherReports.map((report) {
          return ListTile(
            title: Text(report['location']['name'] ?? 'Unknown'),
            subtitle: Text('Temperature: ${report['current']['temp_c']}°C'),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWeatherReportLayout2() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[300],
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: _weatherReports.map((report) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(report['location']['name'] ?? 'Unknown'),
                Text('Temperature: ${report['current']['temp_c']}°C'),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWeatherReportLayout3() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[400],
      child: Column(
        children: _weatherReports.map((report) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(report['location']['name'] ?? 'Unknown'),
              Text('Temperature: ${report['current']['temp_c']}°C'),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWeatherReportLayout4() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[500],
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _weatherReports.length,
        itemBuilder: (context, index) {
          var report = _weatherReports[index];
          return Card(
            child: ListTile(
              title: Text(report['location']['name'] ?? 'Unknown'),
              subtitle: Text('Temperature: ${report['current']['temp_c']}°C'),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWeatherReportLayout5() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[600],
      child: Column(
        children: _weatherReports.map((report) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                '${report['location']['name']} - Temperature: ${report['current']['temp_c']}°C'),
          );
        }).toList(),
      ),
    );
  }
}



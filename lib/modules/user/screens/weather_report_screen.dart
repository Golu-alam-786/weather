import 'package:flutter/material.dart';
import 'package:newtok_tech/components/provider/weather_provider.dart';
import 'package:newtok_tech/components/services/auth_service.dart';
import 'package:newtok_tech/components/widgets/footer_widget.dart';
import 'package:newtok_tech/components/widgets/navbar_widget.dart';
import 'package:provider/provider.dart';

class WeatherReportScreen extends StatelessWidget {
  const WeatherReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    return Scaffold(
      appBar: NavbarWidget(title: 'Weather Report',actions: [
        Consumer<AuthService>(builder: (BuildContext context, authService, Widget? child) {
          return IconButton(onPressed: (){
            authService.signOut(context);
          }, icon: const Icon(Icons.logout));
        },)

      ],),
      body: Consumer<WeatherProvider>(
        builder: (BuildContext context, weatherProvider, Widget? child) {
          if (weatherProvider.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                weatherProvider.errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }

          if (weatherProvider.weatherReports.isEmpty) {
            return const Center(child: Text("No weather reports available", style: TextStyle(fontSize: 18)));
          }

          return ListView.builder(
            itemCount: weatherProvider.weatherReports.length,
            itemBuilder: (context, index) {
              var report = weatherProvider.weatherReports[index];
              var iconCondition = report['current']['condition']['icon'] ?? "Unknown";
              IconData iconData = _getWeatherIcon(iconCondition);
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              report['location']['name'] ?? 'Unknown',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                             // Icon(iconData,color: Colors.orange,),
                            const Icon(Icons.wb_sunny,color: Colors.orange,),

                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Temperature: ${report['current']['temp_c']}°C',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Condition: ${report['current']['condition']['text'] ?? 'Unknown'}',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        // Add additional details if available
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const FooterWidget(),
    );
  }

  IconData _getWeatherIcon(String iconCondition) {
    switch (iconCondition) {
      case 'clear':
        return Icons.wb_sunny;
      case 'partly_cloudy':
        return Icons.cloud;
      case 'cloudy':
        return Icons.cloud;
      case 'rain':
        return Icons.beach_access;
      default:
        return Icons.help_outline;
    }
  }
}


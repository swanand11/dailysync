import 'package:flutter/material.dart';
import 'weather_service.dart';

class WeatherWidget extends StatefulWidget {
  final String city;

  WeatherWidget({required this.city});

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late Future<Map<String, dynamic>> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = WeatherService().fetchWeather(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: weatherData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          var temp = data['current']['temp_c']; 
          var condition = data['current']['condition']['text']; 
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.city}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 255, 255, 255)),
              ),
              Text(
                'Temperature: $temp°C',
                style: TextStyle(fontSize: 20,color: const Color.fromARGB(255, 255, 255, 255)),
              ),
              Text(
                'Condition: $condition',
                style: TextStyle(fontSize: 20,color: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ],
          );
        } else {
          return Text('No data');
        }
      },
    );
  }
}

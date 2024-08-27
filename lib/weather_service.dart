import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '81d3151817e64fc3a57165724242008';
  final String apiUrl = 'http://api.weatherapi.com/v1/current.json';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse('$apiUrl?key=$apiKey&q=$city'),

    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
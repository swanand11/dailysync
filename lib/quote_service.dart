import 'dart:convert';
import "package:http/http.dart" as http;
class QuoteService {
  final String apiUrl = 'https://api.quotable.io/random';

  Future<Map<String, dynamic>> fetchQuote() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load quote');
    }
  }
}

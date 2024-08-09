import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrl {
  final baseUrl = dotenv.env['BASE_URL'];
  final apiKey = dotenv.env['API_KEY'];
}


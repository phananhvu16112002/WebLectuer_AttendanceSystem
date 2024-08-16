import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants{
  static String? baseURL = dotenv.env['BASE_URL'];
}
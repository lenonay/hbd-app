import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final String apiURL = dotenv.env["API_URL"]!;
  static final String version = dotenv.env["APP_VERSION"] ?? '0.0.0';
}
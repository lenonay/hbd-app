import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final String apiURL = dotenv.env["API_URL"]!;
}
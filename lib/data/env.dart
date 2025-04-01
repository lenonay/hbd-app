import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final String baseApi = dotenv.env['BASE_API']!;
}
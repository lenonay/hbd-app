import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final String apiToken = dotenv.env['API_TOKEN']!;
  static final String apiURL = dotenv.env["API_URL"]!;
  static final String baseApi = dotenv.env['BASE_API']!;
  static final String dfImgFull = dotenv.env["DF_IMG_FULL"]!;
  static final String dfImgLarge = dotenv.env["DF_IMG_LARGE"]!;
  static final String dfImgMedium = dotenv.env["DF_IMG_MEDIUM"]!;
  static final String dfImgThumbnail = dotenv.env["DF_IMG_THUMBNAIL"]!;
  static final String noticiasID = dotenv.env["NOTICIAS"]!;
  static final String infoID = dotenv.env["INFO"]!;
}
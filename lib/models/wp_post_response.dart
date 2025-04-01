import 'dart:convert';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import 'package:wp_integration/data/env.dart';

class MediaDetails {
  final String thumbnail;
  final String? medium;
  final String? large;
  final String full;

  MediaDetails({
    required this.thumbnail,
    required this.medium,
    required this.large,
    required this.full,
  });
}

class WpPostResponse {
  final int id;
  final String title;
  final String content;
  final MediaDetails media;

  WpPostResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.media,
  });

  static Future<WpPostResponse> fromJsonAsync(Map<String, dynamic> json) async {
    final document = parse(json["content"]["rendered"]);
    final int postId = json["id"];
    final MediaDetails mediaDetails = await fetchPostImages(postId);

    return WpPostResponse(
      id: postId,
      title: json["title"]["rendered"],
      content: document.body?.text ?? "",
      media: mediaDetails,
    );
  }

  static Future<MediaDetails> fetchPostImages(postId) async {
    // hacemos la peticion de los archivos adjutnos
    final response = await http.get(
      Uri.parse('${Env.baseApi}/media?parent=$postId'),
    );

    if (response.statusCode == 200) {
      // Incializamos las variables
      final List<dynamic> mediaList = jsonDecode(response.body);
      if (mediaList.isNotEmpty) {
        final media = mediaList.first;
        final sizes = media['media_details']['sizes'] as Map<String, dynamic>?;

        final thumbnail = sizes?['thumbnail']?['source_url'] ?? '';
        final medium = sizes?['medium']?['source_url'];
        final large = sizes?['large']?['source_url'];
        final full = media['source_url'];

        return MediaDetails(
          thumbnail: thumbnail,
          medium: medium,
          large: large,
          full: full,
        );
      }
    }
    return MediaDetails(thumbnail: "", medium: null, large: null, full: "");
  }
}

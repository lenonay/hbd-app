import 'dart:convert';

import 'package:wp_integration/models/wp_all_posts_response.dart';
import 'package:wp_integration/models/wp_post_response.dart';
import 'package:http/http.dart' as http;

import 'package:wp_integration/data/env.dart';

class Repository {
  Future<WpPostResponse?> fetchWpPostInfo(String id) async {
    final response = await http.get(
      Uri.parse("${Env.baseApi}/posts/$id"),
    );

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);

      // Si es una lista, toma el primer elemento
      if (decodedJson is List) {
        decodedJson = decodedJson.isNotEmpty ? decodedJson[0] : null;
      }

      if (decodedJson != null) {
        return await WpPostResponse.fromJsonAsync(decodedJson);
      }
    }
    return null;
  }

  Future<WpAllPostsResponse?> fetchAllPosts() async {
    final response = await http.get(
      Uri.parse("${Env.baseApi}/posts"),
    );

    if(response.statusCode == 200){
      var decodedJson = jsonDecode(response.body);

      return await WpAllPostsResponse.fromJsonAsync(decodedJson);
    }else {
      return null;
    }
  }
}

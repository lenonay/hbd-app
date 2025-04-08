import 'dart:convert';
import 'dart:io';

import 'package:wp_integration/models/wp_category_response.dart';
import 'package:wp_integration/models/wp_posts.dart';
import 'package:http/http.dart' as http;

import 'package:wp_integration/data/env.dart';

class Repository {
  Future<WpPostResponse?> fetchWpPostInfo(String id) async {
    final response = await http.get(
      Uri.parse("${Env.baseApi}/posts/$id"),
      headers: {HttpHeaders.authorizationHeader: Env.apiToken},
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
      headers: {HttpHeaders.authorizationHeader: Env.apiToken},
    );

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);

      return await WpAllPostsResponse.fromJsonAsync(decodedJson);
    } else {
      return null;
    }
  }

  Future<WpAllPostsResponse?> fetchAllCategoryPosts(String categorySlug) async {
    // Hacemos la petición para recuperar el id de la categoría
    final categoryResponse = await http.get(
      Uri.parse("${Env.baseApi}/categories?slug=$categorySlug"),
      headers: {HttpHeaders.authorizationHeader: Env.apiToken},
    );

    // Si hubo un fallo salimos con error
    if (categoryResponse.statusCode != 200) {
      return null;
    }

    // Decodificamos el json de la respuesta de la categoría
    var decodedCategoryJson = jsonDecode(categoryResponse.body);

    // Recuperamos los datos
    WpCategoryResponse categoryInfo = WpCategoryResponse.fromJson(
      decodedCategoryJson,
    );

    // Hacemos la petición a la API con el ID de la categoría que estabamos buscando
    final postFilteredResponse = await http.get(
      Uri.parse("${Env.baseApi}/posts?categories=${categoryInfo.id}"),
      headers: {HttpHeaders.authorizationHeader: Env.apiToken},
    );

    // Si salio mal la petición devolvemos null
    if (postFilteredResponse.statusCode != 200) {
      return null;
    }

    // Decodificamos el cuerpo del mensaje
    var decodedPostsJson = jsonDecode(postFilteredResponse.body);

    // Devolvemos toda la información y sus adjuntos.
    return await WpAllPostsResponse.fromJsonAsync(decodedPostsJson);
  }
}

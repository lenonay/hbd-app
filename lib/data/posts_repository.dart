import 'package:wp_integration/core/network/dio_client.dart';
import 'package:wp_integration/data/env.dart';
import 'package:wp_integration/models/wp_posts.dart';

class PostsRepository {
  final DioClient dioClient = DioClient();

  Future<WpAllPostsResponse?> fetchAllPosts() async {
    final response = await dioClient.request("GET", "${Env.apiURL}/v1/posts");

    // Si la peticon es correcta entonces devolvemos todo
    if (response.statusCode == 200) {
      return await WpAllPostsResponse.fromJsonAsync(response.data as List);
    }

    return null;
  }

  Future<WpAllPostsResponse?> fetchAllCategoryPosts(String categoryID) async {
    // Hacemos la petición a la API con el ID de la categoría que estabamos buscando
    final response = await dioClient.request(
      "GET",
      "${Env.baseApi}/posts?categories=$categoryID",
    );

    // Si salio mal la petición devolvemos null
    if (response.statusCode != 200) {
      return null;
    }

    // Devolvemos toda la información y sus adjuntos.
    return await WpAllPostsResponse.fromJsonAsync(response.data as List);
  }
}

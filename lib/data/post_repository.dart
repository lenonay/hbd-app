import 'package:hbd_app/models/post.dart';

import '/core/network/dio_client.dart';
import 'package:hbd_app/core/network/api_routes.dart';

class PostRepository {
  final DioClient dioClient = DioClient();

  Future<List<Post>> getAll() async {
    // Hacemos la peticion
    final response = await dioClient.request("GET", ApiRoutes.posts);

    // Extraemos el array
    final array = List.from(response.data);

    // Creamos una lista de posts
    final List<Post> postsList = List.from(
      array.map((element) => Post.fromJson(element)),
    );

    return postsList;
  }

  Future<List<Post>> getNews() async {
    final response = await dioClient.request("GET", ApiRoutes.news);

    if (response.statusCode == 401) {
      throw Exception("No autenticado");
    }

    // Si no es 200 o data no es lista, error genérico
    if (response.statusCode != 200 || response.data is! List) {
      throw Exception("Error al cargar datos");
    }

    final array = List.from(response.data);

    final List<Post> postList = List.from(
      array.map((element) => Post.fromJson(element))
    );

    return postList;
  }

  Future<List<Post>> getInfo() async {
    final response = await dioClient.request("GET", ApiRoutes.info);

    if (response.statusCode == 401) {
      throw Exception("No autenticado");
    }

    // Si no es 200 o data no es lista, error genérico
    if (response.statusCode != 200 || response.data is! List) {
      throw Exception("Error al cargar datos");
    }

    final array = List.from(response.data);

    final List<Post> postList = List.from(
      array.map((element) => Post.fromJson(element))
    );

    return postList;
  }
}

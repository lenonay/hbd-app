import 'package:wp_integration/models/wp_post_response.dart';

class WpAllPostsResponse {
  final List<WpPostResponse> postsList;
  final int postsCount;

  WpAllPostsResponse({required this.postsList, required this.postsCount});

  static Future<WpAllPostsResponse> fromJsonAsync(List<dynamic> json) async {
    List<WpPostResponse> allPosts = await Future.wait(
      json.map((post) => WpPostResponse.fromJsonAsync(post)),
    );

    return WpAllPostsResponse(postsList: allPosts, postsCount: allPosts.length);
  }
}

import 'package:flutter/material.dart';
import 'package:hbd_app/models/post.dart';
import 'package:hbd_app/widgets/posts/featured_post.dart';
import 'package:hbd_app/widgets/posts/regular_post.dart';

class PostViewer extends StatefulWidget {
  const PostViewer({
    super.key,
    required this.posts,
  });

  final List<Post> posts;

  @override
  State<PostViewer> createState() => _PostViewerState();
}

class _PostViewerState extends State<PostViewer> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Primer post destacado
        SliverToBoxAdapter(child: FeaturedPostItem(post: widget.posts.first)),
    
        // Grid de 2 columnas para los demás posts
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.8,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            // Saltar el primer post que ya mostramos
            final post = widget.posts[index + 1];
            return RegularPostItem(post: post);
          }, childCount: widget.posts.length - 1),
        ),
      ],
    );
  }
}

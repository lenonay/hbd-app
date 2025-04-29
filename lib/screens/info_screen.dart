import 'package:flutter/material.dart';
import 'package:hbd_app/core/mixins/auth_mixin.dart';
import 'package:hbd_app/data/post_repository.dart';
import 'package:hbd_app/models/post.dart';
import 'package:hbd_app/routes.dart';
import 'package:hbd_app/widgets/posts/post_viewer.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> with AuthMixin {
  Future<List<Post>>? _posts;

  final PostRepository repository = PostRepository();

  @override
  void initState() {
    // Hacemos la petición del repositorio
    _fetchPosts();

    super.initState();
  }

  void _fetchPosts() {
    _posts = repository.getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Redirigir si es error de autenticación
            if (snapshot.error.toString().contains("No autenticado")) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, Routes.unauth);
              });
              return const SizedBox.shrink();
            }
            return Text("Error: ${snapshot.error}");
          }

          final posts = snapshot.data!;

          return PostViewer(posts: posts);
        },
      ),
    );
  }
}

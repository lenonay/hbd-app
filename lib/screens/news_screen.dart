import 'package:flutter/material.dart';
import 'package:hbd_app/core/mixins/auth_mixin.dart';
import 'package:hbd_app/data/post_repository.dart';
import 'package:hbd_app/models/post.dart';
import 'package:hbd_app/routes.dart';
import 'package:hbd_app/widgets/auth/auth_wrapper.dart';
import 'package:hbd_app/screens/auth/unauth_screen.dart';
import 'package:hbd_app/widgets/posts/post_viewer.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with AuthMixin {
  Future<List<Post>>? _posts;

  final PostRepository repository = PostRepository();

  @override
  void initState() {
    // Hacemos la petición del repositorio
    _fetchPosts();

    super.initState();
  }

  void _fetchPosts() {
    _posts = repository.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      authFuture: checkAuth(),
      authBuilder: (context) => Screen(posts: _posts),
      unAuthBuilder: (context) => UnAuthScreen(),
    );
  }
}

class Screen extends StatelessWidget {
  const Screen({super.key, required Future<List<Post>>? posts})
    : _posts = posts;

  final Future<List<Post>>? _posts;

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

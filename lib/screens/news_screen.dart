import 'package:flutter/material.dart';
import 'package:hbd_app/core/mixins/auth_mixin.dart';
import 'package:hbd_app/data/post_repository.dart';
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
  final PostRepository repository = PostRepository();

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      authFuture: checkAuth(),
      authBuilder: (context) => Screen(repository: repository),
      unAuthBuilder: (context) => UnAuthScreen(),
    );
  }
}

class Screen extends StatelessWidget {
  const Screen({super.key, required this.repository});

  final PostRepository repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: repository.getNews(),
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

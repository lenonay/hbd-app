import 'package:flutter/material.dart';
import 'package:hbd_app/core/mixins/auth_mixin.dart';
import 'package:hbd_app/data/post_repository.dart';
import 'package:hbd_app/models/post.dart';
import 'package:hbd_app/routes.dart';
import 'package:hbd_app/screens/auth/unauth_screen.dart';
import 'package:hbd_app/widgets/auth/auth_wrapper.dart';
import 'package:hbd_app/widgets/empty_viewer.dart';
import 'package:hbd_app/widgets/posts/post_viewer.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> with AuthMixin {
  final PostRepository repository = PostRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthWrapper(
        authFuture: checkAuth(),
        authBuilder: (context) => screen(),
        unAuthBuilder: (context) => UnAuthScreen(),
      ),
    );
  }

  FutureBuilder<List<Post>> screen() {
    return FutureBuilder(
      future: repository.getInfo(),
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

        // Si no tenemos posts en la lista
        if (posts.isEmpty) {
          return EmptyViewer(item: "información");
        }

        return PostViewer(posts: posts);
      },
    );
  }
}

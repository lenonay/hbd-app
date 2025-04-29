import 'package:flutter/material.dart';
import 'package:hbd_app/models/post.dart';

class PostViewerScreen extends StatelessWidget {
  final Post post;

  const PostViewerScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    // var image =
    //     (post.bannerURL == null)
    //         ? Image.asset("assets/images/bahia-logo.png")
    //         : Image.network(post.bannerURL!);
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              imagesCorrousel(post),
              SizedBox(height: 20),
              Text(post.content, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget imagesCorrousel(Post post) {
    if (post.media.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset("assets/images/bahia-logo.png"),
        ),
      );
    }

    // Nueva lógica para centrar si hay 1 imagen
    if (post.media.length == 1) {
      return Center(
        child: Container(
          height: 200,
          width: 300, // Ancho fijo para consistencia
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(post.media.first["url"], fit: BoxFit.cover),
          ),
        ),
      );
    }

    // ListView para múltiples imágenes
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(), // Mejor feedback de scroll
        itemCount: post.media.length,
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            margin: EdgeInsets.only(
              right: 8,
              // Añadir margen izquierdo al primer elemento para centrado
              left:
                  index == 0
                      ? (MediaQuery.of(context).size.width - 300) / 2
                      : 0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(post.media[index]["url"], fit: BoxFit.contain),
            ),
          );
        },
      ),
    );
  }
}

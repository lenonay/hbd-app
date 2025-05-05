import 'package:flutter/material.dart';
import 'package:hbd_app/models/post.dart';
import 'package:hbd_app/routes.dart';
import 'package:hbd_app/theme.dart';

class FeaturedPostItem extends StatefulWidget {
  final Post post;

  const FeaturedPostItem({super.key, required this.post});

  @override
  State<FeaturedPostItem> createState() => _FeaturedPostItemState();
}

class _FeaturedPostItemState extends State<FeaturedPostItem> {
  @override
  Widget build(BuildContext context) {
    // Ajustamos la imagen de fondo para mostrar una por defecto
    final ImageProvider bgImage =
        (widget.post.bannerURL == null)
            ? AssetImage("assets/images/bahia-logo.png")
            : NetworkImage(widget.post.bannerURL!);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.viewer, arguments: widget.post);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.primaryTint40,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(image: bgImage, fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              spreadRadius: 5,
              blurRadius: 8,
              color: Colors.black38,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // ignore: deprecated_member_use
                    colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                  ),
                ),
                child: Text(
                  widget.post.title,
                  style: const TextStyle(
                    color: AppColors.neutral100,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black87,
                        offset: Offset(0, 0),
                        blurRadius: 15,
                      )
                    ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

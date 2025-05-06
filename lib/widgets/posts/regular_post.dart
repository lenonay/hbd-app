import 'package:flutter/material.dart';
import 'package:hbd_app/models/post.dart';
import 'package:hbd_app/routes.dart';

class RegularPostItem extends StatefulWidget {
  final Post post;

  const RegularPostItem({super.key, required this.post});

  @override
  State<RegularPostItem> createState() => _RegularPostItemState();
}

class _RegularPostItemState extends State<RegularPostItem> {
  @override
  Widget build(BuildContext context) {
    final ImageProvider bgImage =
        (widget.post.bannerURL == null)
            ? AssetImage("assets/images/bahia-logo.png")
            : NetworkImage(widget.post.bannerURL!);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.viewer, arguments: widget.post);
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image(
                  image: bgImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.post.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wp_integration/models/wp_posts.dart';
import 'package:wp_integration/routes/app_routes.dart';

class PostsGrid extends StatefulWidget {
  const PostsGrid({
    super.key,
    required this.count,
    required this.list,
    required this.crossAxisCount,
  });

  final int count;
  final List<WpPostResponse> list;
  final int crossAxisCount;

  @override
  State<PostsGrid> createState() => _PostsGridState();
}

class _PostsGridState extends State<PostsGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: widget.crossAxisCount,
      padding: EdgeInsets.all(8),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 5 / 3,
      children: List.generate(widget.count, (index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.postDetail,
              arguments: widget.list[index],
            );
          },
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(widget.list[index].media.full),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 3,
                  blurRadius: 5
                )
              ]
            ),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.brown,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  widget.list[index].title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

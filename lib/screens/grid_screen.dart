import 'package:flutter/material.dart';
import 'package:wp_integration/data/repository.dart';
import 'package:wp_integration/models/wp_all_posts_response.dart';
import 'package:wp_integration/models/wp_post_response.dart';
import 'package:wp_integration/routes/app_routes.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  Future<WpAllPostsResponse?>? _wpAllPosts;

  Repository repository = Repository();

  int _crossAxisCount = 2;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  void _fetchPosts() {
    setState(() {
      _wpAllPosts = repository.fetchAllPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Wordpress integration v2"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                // Cambiamos el valor entre 1 y 2
                _crossAxisCount = (_crossAxisCount == 2) ? 1 : 2;
              });
            },
            icon: Icon(Icons.grid_on),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Todos los posts de Wordpress", style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Expanded(
            child: PostsLists(
              wpAllPosts: _wpAllPosts,
              crossAxisCount: _crossAxisCount,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchPosts,
        backgroundColor: Colors.teal,
        child: Icon(Icons.refresh, color: Colors.black),
      ),
    );
  }
}

class PostsLists extends StatelessWidget {
  const PostsLists({
    super.key,
    required Future<WpAllPostsResponse?>? wpAllPosts,
    required this.crossAxisCount,
  }) : _wpAllPosts = wpAllPosts;

  final Future<WpAllPostsResponse?>? _wpAllPosts;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _wpAllPosts,
      builder: (context, snapshot) {
        var count = snapshot.data?.postsCount ?? 0;
        var list = snapshot.data?.postsList ?? [];

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.tealAccent),
          );
        } else if (snapshot.hasError) {
          return Text("Hubo un error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          return PostsGrid(
            count: count,
            list: list,
            crossAxisCount: crossAxisCount,
          );
        } else {
          return Text("Hubo un error");
        }
      },
    );
  }
}

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
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(widget.list[index].media.full),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(left: 4, right: 4),
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

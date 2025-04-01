import 'package:flutter/material.dart';
import 'package:wp_integration/data/repository.dart';
import 'package:wp_integration/models/wp_posts.dart';
import 'package:wp_integration/widgets/post_grid.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  Future<WpAllPostsResponse?>? _wpAllPosts;

  Repository repository = Repository();

  int _crossAxisCount = 2;
  Icon gridIcon = Icon(Icons.grid_on);

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
      backgroundColor: Color(0xFFE0E0E0),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        actions: [
          IconButton(onPressed: _fetchPosts, icon: Icon(Icons.refresh)),

          IconButton(
            onPressed: () {
              setState(() {
                // Cambiamos el valor entre 1 y 2
                _crossAxisCount = (_crossAxisCount == 2) ? 1 : 2;
                gridIcon =
                    (_crossAxisCount == 2)
                        ? Icon(Icons.grid_on)
                        : Icon(Icons.list);
              });
            },
            icon: gridIcon,
          ),
        ],
      ),
      body: Expanded(
        child: PostsLists(
          wpAllPosts: _wpAllPosts,
          crossAxisCount: _crossAxisCount,
        ),
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
            child: CircularProgressIndicator(),
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

import 'package:flutter/material.dart';
import 'package:wp_integration/data/repository.dart';
import 'package:wp_integration/models/wp_all_posts_response.dart';
import 'package:wp_integration/models/wp_post_response.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  Future<WpAllPostsResponse?>? _wpAllPosts;

  Repository repository = Repository();

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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Todos los posts de Wordpress", style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Expanded(child: PostsLists(wpAllPosts: _wpAllPosts)),
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
  }) : _wpAllPosts = wpAllPosts;

  final Future<WpAllPostsResponse?>? _wpAllPosts;

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
          return PostsGrid(count: count, list: list);
        } else {
          return Text("Hubo un error");
        }
      },
    );
  }
}

class PostsGrid extends StatelessWidget {
  const PostsGrid({super.key, required this.count, required this.list});

  final int count;
  final List<WpPostResponse> list;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(count, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              print("Presion");
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(list[index].media.full),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(list[index].title, style: TextStyle(fontSize: 18)),
                  Text(list[index].id.toString()),
                  Text(list[index].media.full),
                  
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wp_integration/data/repository.dart';
import 'package:wp_integration/models/wp_posts.dart';
import 'package:wp_integration/routes/app_routes.dart';

class DividedScreen extends StatefulWidget {
  const DividedScreen({super.key});

  @override
  State<DividedScreen> createState() => _DividedScreenState();
}

class _DividedScreenState extends State<DividedScreen> {
  Future<WpAllPostsResponse?>? _wpNewsPosts;
  Future<WpAllPostsResponse?>? _wpInfoPosts;

  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  void _fetchPosts() {
    setState(() {
      _wpInfoPosts = repository.fetchAllCategoryPosts("informacion");
      _wpNewsPosts = repository.fetchAllCategoryPosts("noticias");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        actions: [
          IconButton(onPressed: _fetchPosts, icon: Icon(Icons.refresh)),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            postBuilder(_wpNewsPosts, "Noticias"),
            postBuilder(_wpInfoPosts, "Información"),
          ],
        ),
      ),
    );
  }

  Expanded postBuilder(Future<WpAllPostsResponse?>? wpPostsData, String title) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              color: Colors.brown,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: wpPostsData,
              builder: (context, snapshot) {
                var count = snapshot.data?.postsCount ?? 0;
                var list = snapshot.data?.postsList ?? [];
            
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Hubo un error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return PostsViewer(count: count, list: list);
                } else {
                  return Text("Error al contectar");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PostsViewer extends StatelessWidget {
  const PostsViewer({super.key, required this.count, required this.list});

  final int count;
  final List<WpPostResponse> list;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(8),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 5 / 3,
      children: List.generate(count, (index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.postDetail,
              arguments: list[index],
            );
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
                  list[index].title,
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

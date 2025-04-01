import 'package:flutter/material.dart';
import 'package:wp_integration/data/repository.dart';
import 'package:wp_integration/models/wp_posts.dart';
import 'package:wp_integration/widgets/post_grid.dart';

class DividedScreen extends StatefulWidget {
  const DividedScreen({super.key});

  @override
  State<DividedScreen> createState() => _DividedScreenState();
}

class _DividedScreenState extends State<DividedScreen> {
  Future<WpAllPostsResponse?>? _wpNewsPosts;
  Future<WpAllPostsResponse?>? _wpInfoPosts;

  Repository repository = Repository();

  int crossAxisCount = 2;
  Icon gridIcon = Icon(Icons.grid_on);

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
      backgroundColor: Color(0xFFE0E0E0),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        actions: [
          IconButton(onPressed: _fetchPosts, icon: Icon(Icons.refresh)),
          IconButton(
            onPressed: () {
              setState(() {
                // Intercambiamos entre 1 y 2
                crossAxisCount = (crossAxisCount == 2) ? 1 : 2;
                gridIcon =
                    (crossAxisCount == 2)
                        ? Icon(Icons.grid_on)
                        : Icon(Icons.list);
              });
            },
            icon: gridIcon,
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            postBuilder(_wpNewsPosts, "Noticias"),
            SizedBox(height: 20),
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
                  return PostsGrid(
                    count: count,
                    list: list,
                    crossAxisCount: crossAxisCount,
                  );
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

import 'package:flutter/material.dart';

import 'package:wp_integration/data/repository.dart';
import 'package:wp_integration/models/wp_posts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var postID = "";
  var isEmpty = true;

  Future<WpPostResponse?>? _wpResponse;

  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wordpress Integration"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Coloque un ID",
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (text) {
                    postID = text.toString();
                    isEmpty = text.isEmpty;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _wpResponse = repository.fetchWpPostInfo(postID);
                    });
                  },
                  child: Text("Buscar"),
                ),
              ],
            ),
          ),
          postViewer(),
        ],
      ),
    );
  }

  FutureBuilder<WpPostResponse?> postViewer() {
    return FutureBuilder(
      future: _wpResponse,
      builder: (context, snapshot) {
        if (isEmpty) {
          return Text("Busca algo chati");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(color: Colors.lightBlue);
        } else if (_wpResponse == null) {
          return Text("Escribe un ID y presiona Buscar");
        } else if (snapshot.hasError) {
          return Text("Hubo un error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          var postInfo = snapshot.data!;

          return Expanded(
            child: Column(
              children: [
                Text(postInfo.title, style: TextStyle(fontSize: 24)),
                Text(postInfo.content, style: TextStyle(fontFamily: "Arial")),
              ],
            ),
          );
        } else {
          return Text("Error al hacer la petición");
        }
      },
    );
  }
}

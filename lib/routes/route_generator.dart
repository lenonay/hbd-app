import 'package:flutter/material.dart';
import 'package:wp_integration/models/wp_posts.dart';
import 'package:wp_integration/routes/app_routes.dart';
import 'package:wp_integration/screens/divided_screen.dart';

import 'package:wp_integration/screens/grid_screen.dart';
import 'package:wp_integration/screens/home_screen.dart';
import 'package:wp_integration/screens/post_detail_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case AppRoutes.gridScreen:
        return MaterialPageRoute(builder: (_) => GridScreen());

      case AppRoutes.dividedScreen:
        return MaterialPageRoute(builder: (_) => DividedScreen());

      case AppRoutes.postDetail:
        if (args is WpPostResponse) {
          return MaterialPageRoute(
            builder: (_) => PostDetailScreen(post: args),
          );
        } else {
          return _errorRoute();
        }
        
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: Text("Error")),
            body: Center(child: Text("Ruta no encontrada")),
          ),
    );
  }
}

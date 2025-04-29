import 'package:flutter/material.dart';
import 'package:hbd_app/models/post.dart';
import 'package:hbd_app/screens/auth/unauth_screen.dart';
import 'package:hbd_app/screens/post_viewer_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/news_screen.dart';
import 'screens/info_screen.dart';
import 'screens/coupons_screen.dart';
import 'screens/profile_screen.dart';

class Routes {
  static const login = '/login';
  static const home = '/home';
  static const news = '/news';
  static const info = '/info';
  static const coupons = '/coupons';
  static const profile = '/profile';
  static const viewer = '/viewer';
  static const unauth = "/unauth";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => LoginScreen(),
      home: (context) => HomeScreen(),
      news: (context) => NewsScreen(),
      info: (context) => InfoScreen(),
      coupons: (context) => CouponsScreen(),
      profile: (context) => ProfileScreen(),
      viewer: (context) {
        final post = ModalRoute.of(context)!.settings.arguments as Post;

        return PostViewerScreen(post: post);
      },
      unauth: (context) => UnAuthScreen(),
    };
  }
}

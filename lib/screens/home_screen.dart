import 'package:flutter/material.dart';
import 'package:hbd_app/core/mixins/auth_mixin.dart';
import 'package:hbd_app/widgets/auth/auth_wrapper.dart';
import 'package:hbd_app/screens/auth/unauth_screen.dart';
import 'news_screen.dart';
import 'info_screen.dart';
import 'coupons_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AuthMixin {
  late Future<bool> _authFuture;

  @override
  void initState() {
    _authFuture = checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      authFuture: _authFuture,
      authBuilder: (context) => HomeView(),
      unAuthBuilder: (context) => UnAuthScreen(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.newspaper)),
              Tab(icon: Icon(Icons.info)),
              Tab(icon: Icon(Icons.card_giftcard)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NewsScreen(),
            InfoScreen(),
            CouponsScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}

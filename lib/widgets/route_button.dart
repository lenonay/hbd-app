import 'package:flutter/material.dart';

class RouteButton extends StatelessWidget {
  const RouteButton({
    super.key,
    required this.context,
    this.route,
    required this.title,
    this.onTap,
  });

  final BuildContext context;
  final String? route;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap ?? () => Navigator.pushNamed(context, route!),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.teal,
            boxShadow: [
              BoxShadow(color: Colors.white30, spreadRadius: 2, blurRadius: 7),
            ],
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

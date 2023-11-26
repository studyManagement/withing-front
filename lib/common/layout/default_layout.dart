import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final BottomNavigationBar? bottomNavigationBar;
  const DefaultLayout({
    this.backgroundColor,
    required this.child,
    this.title,
    this.bottomNavigationBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: SafeArea(child: child),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: const TextStyle(
            color: Color(0xFF22262B),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        foregroundColor: Colors.black,
      );
    }
  }
}

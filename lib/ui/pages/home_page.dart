import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    login();
  }

  void login() {
    Future.delayed(
      Duration(seconds: 1),
    ).then((value) => navigateToMainScreen());
  }

  void navigateToMainScreen() {
    if (context.mounted) {
      context.replace("/page1");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

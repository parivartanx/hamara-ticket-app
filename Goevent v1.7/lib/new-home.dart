import 'package:flutter/material.dart';

class NewHome extends StatelessWidget {
  static const String routePath= "/";
  static const String routeName="New Home";
  const NewHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text("New Home")
      ],),
    );
  }
}
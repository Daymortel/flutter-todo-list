import 'package:exo3/widgets/my_home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    const String title = 'To-Do List';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MyHomePage(title: title)
    );
  }
}
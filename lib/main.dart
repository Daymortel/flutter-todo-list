import 'package:exo3/models/tasks_model.dart';
import 'package:exo3/widgets/my_form_page.dart';
import 'package:exo3/widgets/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'To-Do List';
    return ChangeNotifierProvider(
        create: (_) => TasksModel(),
        child: Consumer<TasksModel>(
            builder: (_, model, __) => MaterialApp(
                  title: title,
                  theme: ThemeData(primarySwatch: Colors.blue),
                  home: MyHomePage(title: title),
                  // home: MyFormPage(title: 'Mon premier formulaire')
                )));
  }
}

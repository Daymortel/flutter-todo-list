import 'package:exo3/classes/todo_list.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  String title;
  MyHomePage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> taskList = [];

  @override
  void initState() {
    taskList.add(Shopping("Kinder Bueno"));
    taskList.add(Sport("Triathlon"));
    taskList.add(Shopping("KitKat"));
    taskList.add(Sport("Trail"));
    taskList.add(Shopping("Nesquik"));
    taskList.add(Shopping("Mars"));
    taskList.add(Shopping("Twix"));
    taskList.add(Sport("Marathon"));
    taskList.add(Shopping("Bounty"));
    super.initState();
  }

  List<Widget> _drawTasks(CategoryEnum category) {
    List<Widget> result = [];
    for (Task task in taskList.where((el) => el.category == category).toList()) {
      result.add(ListTile(title: Text(task.name)));
    }
    return result;
  }

  List<Widget> _drawTodoList() {
    List<Widget> result = [];
    for (CategoryEnum category in CategoryEnum.values) {
      List<Widget> internalContainerListView = [];
      internalContainerListView.add(Text(category.name));
      internalContainerListView.addAll(_drawTasks(category));
      result.add(Container(
          child: Column(
        children: internalContainerListView,
      )));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: _drawTodoList(),
        ));
  }
}

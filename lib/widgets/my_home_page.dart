import 'package:exo3/classes/todo_list.dart';
import 'package:exo3/models/tasks_model.dart';
import 'package:exo3/widgets/add_or_update_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TasksModel model;

  @override
  void initState() {
    model = context.read<TasksModel>();
    super.initState();
  }

  List<Widget> _drawTasks(CategoryEnum category) {
    return model.tasksList
        .where((el) => el.category == category)
        .map((task) => ListTile(
              leading: Checkbox(
                value: task.done,
                onChanged: (bool? value) {
                  task.done = value!;
                },
              ),
              title: Text(task.name),
              trailing: Wrap(spacing: 12, children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _addOrUpdateTask(task),
                ),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      model.delete(task);
                    })
              ]),
            ))
        .toList();
  }

  List<Widget> _drawTodoList() {
    List<Widget> result = [];
    for (CategoryEnum category in CategoryEnum.values) {
      List<Widget> internalContainerListView = [];
      internalContainerListView.addAll(_drawTasks(category));
      result.add(Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5),
              ]),
          child: ExpansionTile(
              title: Text(category.name.toUpperCase()),
              children: internalContainerListView)));
    }
    return result;
  }

  void _addOrUpdateTask([Task? task]) async {
    Task? newTask = await showDialog(
        context: context, builder: (_) => AddOrUpdateTaskPage(task: task));
    if (newTask != null) {
      if (task != null) {
        model.update(task, newTask);
      } else {
        model.add(newTask);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    {
      model = model;
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.title),
          ),
          body: ListView(
            children: _drawTodoList(),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _addOrUpdateTask(),
          ));
    }
  }
}

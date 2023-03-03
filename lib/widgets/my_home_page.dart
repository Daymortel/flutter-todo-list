import 'package:exo3/classes/todo_list.dart';
import 'package:exo3/widgets/add_or_update_task.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

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
    // List<Widget> result = [];
    // for (Task task in taskList.where((el) => el.category == category).toList()) {
    //   result.add(ListTile(title: Text(task.name)));
    // }
    // return result;

    return taskList
        .where((el) => el.category == category)
        .map((task) => ListTile(
              leading: Checkbox(
                value: task.done,
                onChanged: (bool? value) {
                  setState(() {
                    task.done = value!;
                  });
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
                      setState(() {
                        taskList.remove(task);
                      });
                    })
              ]),
            ))
        .toList();
  }

  List<Widget> _drawTodoList() {
    List<Widget> result = [];
    for (CategoryEnum category in CategoryEnum.values) {
      List<Widget> internalContainerListView = [];
      // internalContainerListView.add(Container(
      //     margin: const EdgeInsets.all(12),
      //     child: Text(
      //       category.name.toUpperCase(),
      //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //     )));
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
    Task newTask = await showDialog(
        context: context, builder: (_) => AddOrUpdateTaskPage(task: task));
    setState(() {
      if (task != null) {
        task.fromTask(newTask);
      } else {
        taskList.add(newTask);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}

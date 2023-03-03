import 'package:exo3/classes/todo_list.dart';
import 'package:flutter/material.dart';

class TasksModel with ChangeNotifier {
  final List<Task> _tasksList = [];

  List<Task> get tasksList => _tasksList;

  set tasksList(List<Task> tasks) {
    if (tasks != _tasksList) {
      _tasksList.clear();
      _tasksList.addAll(tasks);
      notifyListeners();
    }
  }

  void add(Task task) {
    _tasksList.add(task);
    notifyListeners();
  }

  void delete(Task task) {
    _tasksList.remove(task);
    notifyListeners();
  }

  void update(Task task, Task newTask) {
    int index = _tasksList.indexOf(task);
    _tasksList[index] = newTask;
    notifyListeners();
  }
}
import 'package:exo3/classes/todo_list.dart';
import 'package:flutter/material.dart';

class AddOrUpdateTaskPage extends StatefulWidget {
  final Task? task;
  AddOrUpdateTaskPage({ super.key, this.task });

  @override
  State<StatefulWidget> createState() => _AddOrUpdateTaskPageState();
}

class _AddOrUpdateTaskPageState extends State<AddOrUpdateTaskPage> {
  final formKey = GlobalKey<FormState>();
  final taskNameCtrl = TextEditingController();
  final List<DropdownMenuItem> categoryItem = [];
  CategoryEnum selectedCategory = CategoryEnum.values.first;

  @override
  void initState() {
    categoryItem.addAll(
      List.generate(
        CategoryEnum.values.length,
        (index) => DropdownMenuItem(
          value: CategoryEnum.values[index],
          child: Text(CategoryEnum.values[index].name)
        )
      )
    );
    taskNameCtrl.text = widget.task?.name ?? "";
    if (widget.task != null) {
      selectedCategory = widget.task!.category;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add or update Task'),
      content: Form(
        key: formKey,
        child: Column(children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Task Name',
            hintText: 'Enter Task name'
          ),
          controller: taskNameCtrl,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        DropdownButtonFormField(
          value: selectedCategory,
          items: categoryItem, 
          onChanged: (newValue) {
            selectedCategory = newValue!;
          },
          validator: (value) => null,
        ),
        ElevatedButton(onPressed: () {
          if (formKey.currentState!.validate()) {
            Task? newTask = widget.task;
            switch (selectedCategory) {
              case CategoryEnum.shopping:
                newTask = Shopping(taskNameCtrl.text);
                break;
              case CategoryEnum.sport:
                newTask = Sport(taskNameCtrl.text);
                break;
              case CategoryEnum.work:
                newTask = Work(taskNameCtrl.text);
                break;
            }
            Navigator.pop(context, newTask);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('New task created')));
          }
        }, child: Text('Submit'))
      ]),
    ));
  }
}
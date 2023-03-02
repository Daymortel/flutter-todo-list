import 'package:flutter/material.dart';

class MyFormPage extends StatefulWidget {
  final String title;
  const MyFormPage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final myNameCtrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter your name',
              labelText: 'Name'
            ),
            controller: myNameCtrl,
            validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name !';
            }
            return null;
          }),
          ElevatedButton(onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Hello, ${myNameCtrl.text}'))
              );
            }
          }, child: const Text('Submit'))
        ])
      )
    );
  }
}
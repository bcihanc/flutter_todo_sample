import 'package:flutter/material.dart';
import 'package:flutter_todo_sample/models/TodoModel.dart';
import 'package:flutter_todo_sample/todo_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await _hiveSetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: TodoApp(),
    );
  }
}

Future<void> _hiveSetup() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TodoCategoryAdapter());
  Hive.registerAdapter(MyColorAdapter());
  Hive.registerAdapter(TodoModelAdapter());

  final settingsBox = await Hive.openBox<bool>('settings');
  final initialized = settingsBox.get('initialized', defaultValue: false);

  final todosBox = await Hive.openBox<TodoModel>('todos');

  if (!initialized) {
    final todos = <TodoModel>[
      TodoModel(
          category: TodoCategory.personal,
          color: MyColor.purple,
          content: 'go for a walk',
          done: false,
          time: DateTime.now().subtract(Duration(days: 1))),
      TodoModel(
          category: TodoCategory.shopping,
          color: MyColor.orange,
          content: 'curly pasta',
          done: false,
          time: DateTime.now().subtract(Duration(days: 2))),
      TodoModel(
          category: TodoCategory.work,
          color: MyColor.blueGrey,
          content: 'renew passport',
          done: true,
          time: DateTime.now().subtract(Duration(days: 3)))
    ];

    await todosBox.addAll(todos);
    await settingsBox.put('initialized', true);
  }
}

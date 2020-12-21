import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_sample/models/TodoModel.dart';
import 'package:flutter_todo_sample/todo_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        heroTag: 'add_todo_button',
        onPressed: () => showTodoEditorDialog(context),
        child: Icon(MdiIcons.rocketLaunch),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            pinned: true,
            floating: true,
            centerTitle: true,
            backgroundColor: Colors.teal,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: SizedBox(
                  width: 250.0,
                  child: TypewriterAnimatedTextKit(
                    isRepeatingAnimation: false,
                    speed: Duration(milliseconds: 50),
                    text: ['Tasky'],
                    textStyle: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                background: Image.asset(
                  'assets/images/background.jpg',
                  fit: BoxFit.fill,
                  height: 100,
                  colorBlendMode: BlendMode.color,
                  color: Colors.red,
                )),
          ),
          ValueListenableBuilder<Box<TodoModel>>(
              valueListenable: Hive.box<TodoModel>('todos').listenable(),
              builder: (context, box, _) {
                final todos = box.values.toList();
                return TodoList(todos: todos);
              }),
        ],
      ),
    );
  }
}

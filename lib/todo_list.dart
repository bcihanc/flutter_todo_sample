import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo_sample/models/TodoModel.dart';
import 'package:flutter_todo_sample/todo_editor_dialog.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key key, this.todos}) : super(key: key);
  final List<TodoModel> todos;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      SizedBox(height: 10),
      ...todos.map((todo) => InkWell(
            onTap: () {
              showTodoEditorDialog(context, todo: todo);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: [
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.transparent,
                    icon: Icons.delete,
                    onTap: () {
                      todo.delete();
                    },
                  )
                ],
                actions: [
                  IconSlideAction(
                    caption: todo.done ? 'Uncomplete' : 'Complete',
                    color: Colors.transparent,
                    icon: todo.done
                        ? Icons.radio_button_unchecked
                        : MdiIcons.check,
                    onTap: () async {
                      todo.done = !todo.done;
                      await todo.save();
                    },
                  )
                ],
                child: Card(
                  elevation: 0,
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: todo.done
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      MdiIcons.check,
                                      color: todo.color.toColor(),
                                      size: 18,
                                    ),
                                    Icon(MdiIcons.circleOutline,
                                        color: todo.color.toColor()),
                                  ],
                                )
                              : Icon(MdiIcons.circleOutline,
                                  color: todo.color.toColor()),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Opacity(
                                opacity: todo.done ? 0.4 : 1,
                                child: Text(
                                  '${todo.content}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: todo.done
                                          ? FontWeight.w100
                                          : FontWeight.normal,
                                      decoration: todo.done
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                                ),
                              ),
                              SizedBox(height: 6),
                              Opacity(
                                opacity: 0.4,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.date_range,
                                      size: 12,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                        '${DateFormat('MM-dd-yyyy HH:mm').format(todo.time)}',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0) +
                              const EdgeInsets.symmetric(horizontal: 8),
                          child: _categoryIcon(todo.category),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ))
    ].toList()));
  }
}

void showTodoEditorDialog(BuildContext context, {TodoModel todo}) {
  final _todo = todo ??
      TodoModel(
          color: MyColor.red,
          category: TodoCategory.personal,
          content: '',
          time: DateTime.now(),
          done: false);

  Navigator.push(
      context,
      PageRouteBuilder(
          fullscreenDialog: true,
          opaque: false,
          barrierDismissible: true,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (animation.status == AnimationStatus.reverse) {
              return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child);
            } else {
              return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child);
            }
          },
          pageBuilder: (context, _, __) => TodoEditorDialog(todo: _todo)));
}

Widget _categoryIcon(TodoCategory category) {
  if (category == TodoCategory.personal) {
    return Icon(Icons.person, color: Colors.red);
  } else if (category == TodoCategory.shopping) {
    return Icon(MdiIcons.shopping, color: Colors.yellow);
  } else {
    return Icon(Icons.work, color: Colors.blue);
  }
}

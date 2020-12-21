import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_todo_sample/models/TodoModel.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TodoEditorDialog extends StatefulWidget {
  TodoEditorDialog({this.todo});
  final TodoModel todo;

  @override
  _TodoEditorDialogState createState() => _TodoEditorDialogState();
}

class _TodoEditorDialogState extends State<TodoEditorDialog> {
  final TodoModel _todo = TodoModel();

  @override
  void initState() {
    super.initState();
    _todo..content = widget.todo.content;
    _todo..category = widget.todo.category;
    _todo..time = widget.todo.time;
    _todo..color = widget.todo.color;
    _todo..done = widget.todo.done;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'add new task... ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  if (widget.todo.isInBox)
                    FloatingActionButton(
                        heroTag: 'remove_todo_button',
                        child: Icon(MdiIcons.delete),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        mini: true,
                        onPressed: () => _deleteHandle(context)),
                  FloatingActionButton(
                      heroTag: 'add_todo_button',
                      child: Icon(MdiIcons.contentSave),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      onPressed: () => _saveHandle(context)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: TextEditingController(text: _todo.content),
              autofocus: true,
              cursorColor: Colors.deepOrange,
              onChanged: (value) {
                _todo.content = value;
              },
              onEditingComplete: () async {
                // todo : save()
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange)),
                  prefixIcon: Icon(
                    MdiIcons.rocketLaunch,
                    color: Colors.deepOrange,
                  ),
                  hintText: 'do...'),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: MaterialColorPicker(
                  shrinkWrap: true,
                  allowShades: false,
                  circleSize: 32,
                  colors: [
                    Colors.red,
                    Colors.orange,
                    Colors.teal,
                    Colors.pink,
                    Colors.blueGrey,
                    Colors.blue,
                    Colors.purple,
                  ],
                  onMainColorChange: (color) {
                    _todo.color = color.toMyColor();
                  },
                  selectedColor: _todo.color.toColor()),
            ),
            CategoryPicker(
              initialCategory: _todo.category ?? TodoCategory.personal,
              categoryOnChanged: (category) {
                _todo.category = category;
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveHandle(BuildContext context) async {
    _todo.time = DateTime.now();

    if (widget.todo.isInBox) {
      final key = widget.todo.key;
      Hive.box<TodoModel>('todos').put(key, _todo);
    } else {
      await Hive.box<TodoModel>('todos').add(_todo);
    }

    Navigator.pop(context);
  }

  Future<void> _deleteHandle(BuildContext context) async {
    if (widget.todo.isInBox) await widget.todo.delete();
    Navigator.pop(context);
  }
}

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({Key key, this.categoryOnChanged, this.initialCategory})
      : super(key: key);
  final ValueChanged<TodoCategory> categoryOnChanged;
  final TodoCategory initialCategory;

  @override
  _CategoryPickerState createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  var _isSelected = List.generate(3, (index) => false);

  @override
  void initState() {
    super.initState();
    final index = TodoCategory.values.indexOf(widget.initialCategory);
    _isSelected[index] = true;
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        fillColor: Colors.white.withOpacity(0.1),
        onPressed: (index) {
          setState(() {
            _isSelected = _isSelected.map((e) => e = false).toList();
            _isSelected[index] = true;
          });
          final category = TodoCategory.values[index];
          widget.categoryOnChanged(category);
        },
        children: [
          _ToggleButtonContainer(
              icon: Icon(Icons.person), color: Colors.red, label: 'Personal'),
          _ToggleButtonContainer(
              icon: Icon(Icons.work), color: Colors.blue, label: 'Work'),
          _ToggleButtonContainer(
              icon: Icon(MdiIcons.shopping),
              color: Colors.yellow,
              label: 'Shoppping')
        ],
        isSelected: _isSelected);
  }
}

class _ToggleButtonContainer extends StatelessWidget {
  const _ToggleButtonContainer({Key key, this.color, this.icon, this.label})
      : super(key: key);
  final Color color;
  final Icon icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTheme(data: IconThemeData(color: color), child: icon),
          const SizedBox(width: 4),
          Text(
            '$label',
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}

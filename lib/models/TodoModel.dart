import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'TodoModel.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  String content;
  @HiveField(1)
  bool done = false;
  @HiveField(2)
  DateTime time;
  @HiveField(3)
  TodoCategory category;
  @HiveField(4)
  MyColor color;

  TodoModel({this.content, this.done, this.time, this.category, this.color});
}

@HiveType(typeId: 1)
enum TodoCategory {
  @HiveField(0)
  personal,
  @HiveField(1)
  work,
  @HiveField(2)
  shopping
}

@HiveType(typeId: 2)
enum MyColor {
  @HiveField(0)
  red,
  @HiveField(1)
  orange,
  @HiveField(2)
  teal,
  @HiveField(3)
  pink,
  @HiveField(4)
  blueGrey,
  @HiveField(5)
  blue,
  @HiveField(6)
  purple
}

extension MyColorX on MyColor {
  Color toColor() {
    if (this == MyColor.red) {
      return Colors.red;
    } else if (this == MyColor.orange) {
      return Colors.orange;
    } else if (this == MyColor.teal) {
      return Colors.teal;
    } else if (this == MyColor.pink) {
      return Colors.pink;
    } else if (this == MyColor.blueGrey) {
      return Colors.blueGrey;
    } else if (this == MyColor.blue) {
      return Colors.blue;
    } else if (this == MyColor.purple) {
      return Colors.purple;
    } else {
      return Colors.red;
    }
  }
}

extension MaterialColorX on Color {
  MyColor toMyColor() {
    if (this == Colors.red) {
      return MyColor.red;
    } else if (this == Colors.orange) {
      return MyColor.orange;
    } else if (this == Colors.teal) {
      return MyColor.teal;
    } else if (this == Colors.pink) {
      return MyColor.pink;
    } else if (this == Colors.blueGrey) {
      return MyColor.blueGrey;
    } else if (this == Colors.blue) {
      return MyColor.blue;
    } else if (this == Colors.purple) {
      return MyColor.purple;
    } else {
      return MyColor.red;
    }
  }
}

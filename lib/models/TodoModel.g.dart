// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TodoModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoCategoryAdapter extends TypeAdapter<TodoCategory> {
  @override
  final int typeId = 1;

  @override
  TodoCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TodoCategory.personal;
      case 1:
        return TodoCategory.work;
      case 2:
        return TodoCategory.shopping;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, TodoCategory obj) {
    switch (obj) {
      case TodoCategory.personal:
        writer.writeByte(0);
        break;
      case TodoCategory.work:
        writer.writeByte(1);
        break;
      case TodoCategory.shopping:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MyColorAdapter extends TypeAdapter<MyColor> {
  @override
  final int typeId = 2;

  @override
  MyColor read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MyColor.red;
      case 1:
        return MyColor.orange;
      case 2:
        return MyColor.teal;
      case 3:
        return MyColor.pink;
      case 4:
        return MyColor.blueGrey;
      case 5:
        return MyColor.blue;
      case 6:
        return MyColor.purple;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, MyColor obj) {
    switch (obj) {
      case MyColor.red:
        writer.writeByte(0);
        break;
      case MyColor.orange:
        writer.writeByte(1);
        break;
      case MyColor.teal:
        writer.writeByte(2);
        break;
      case MyColor.pink:
        writer.writeByte(3);
        break;
      case MyColor.blueGrey:
        writer.writeByte(4);
        break;
      case MyColor.blue:
        writer.writeByte(5);
        break;
      case MyColor.purple:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TodoModelAdapter extends TypeAdapter<TodoModel> {
  @override
  final int typeId = 0;

  @override
  TodoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoModel(
      content: fields[0] as String,
      done: fields[1] as bool,
      time: fields[2] as DateTime,
      category: fields[3] as TodoCategory,
      color: fields[4] as MyColor,
    );
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.done)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

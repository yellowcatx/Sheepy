import 'package:hive_flutter/hive_flutter.dart';

class toDoDataBase {
  List toDoList = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [
      ['code my app', false],
      ['study', false],
    ];
  }

  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  void updateDataBase() {
    _myBox.put('TODOLIST', toDoList);
  }
}

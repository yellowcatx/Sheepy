import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sheep/data/database.dart';
import 'package:sheep/util/todo_title.dart';
import 'package:sheep/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  toDoDataBase db = toDoDataBase();

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }
// save a new task

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 235),
        appBar: AppBar(
          titleTextStyle: TextStyle(fontFamily: 'SpaceMono', fontSize: 30),
          toolbarHeight: 80,
          title: const Text(
            'TO DO',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 2,
          leading: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Image.asset('assets/logo.png')),
          actions: [
            IconButton(
              onPressed: createNewTask,
              icon: Icon(Icons.note_alt_outlined),
              color: Color.fromRGBO(126, 149, 113, 20),
            )
          ],
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 235),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}

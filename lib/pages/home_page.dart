import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:sheep/data/database.dart';
import 'package:sheep/util/todo_title.dart';
import 'package:sheep/util/dialog_box.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  final _controller = TextEditingController();
  final db = toDoDataBase();

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void openCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Crcalendar(
              selectedDayColor: Colors.blue, // Cor do dia selecionado
              todayColor: Colors.green, // Cor do dia atual
              onDateChanged: (DateTime date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () {
            saveNewTask();
            _controller.clear();
          },
          onCancel: () {
            Navigator.of(context).pop();
            _controller.clear();
          },
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
        toolbarHeight: 50,
        title: const Text(
          'TO DO',
          style: TextStyle(color: Colors.black),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(IconlyLight.profile),
          ),
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/cat.png',
            width: 150,
            scale: 6,
          )
        ],
        backgroundColor: Color.fromARGB(255, 255, 255, 235),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color.fromARGB(255, 237, 238, 213),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        margin: EdgeInsets.symmetric(
            horizontal: 92, vertical: 12), // margem barra de navegação
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7), // Ajuste a largura conforme necessário
          child: GNav(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            activeColor: Color.fromRGBO(126, 149, 113, 20),
            tabBorderRadius: 23,
            tabBackgroundColor: Color.fromRGBO(126, 149, 113, 0.171),
            gap: 4,
            tabs: [
              GButton(
                icon: IconlyBroken.paper_plus,
                text: 'Criar tarefa',
                onPressed: createNewTask,
              ),
              GButton(
                icon: IconlyBroken.calendar,
                text: 'Calendário',
              ),
              GButton(
                icon: IconlyBroken.activity,
                text: 'Atividade',
              )
            ],
            selectedIndex: 0,
            onTabChange: (index) {},
          ),
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ),
      ),
    );
  }
}

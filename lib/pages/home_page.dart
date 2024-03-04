import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:sheep/data/database.dart';
import 'package:sheep/pages/setting.dart';
import 'package:sheep/util/calendar.dart';
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
  bool _showImage = true;

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

  void calendar() {
    showDialog(
      context: context,
      builder: (context) {
        return Calendar();
      },
    );
  }

  void settings() {
    showDialog(
        context: context,
        builder: (context) {
          return Settings();
        });
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
      appBar: AppBar(
        titleTextStyle: TextStyle(fontFamily: 'SpaceMono', fontSize: 30),
        backgroundColor: Theme.of(context).colorScheme.background,
        toolbarHeight: 40,
        elevation: 1,
        shadowColor: Colors.black,
        title: const Text(
          'TO DO',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ), //final do app bar
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Imagem
            AnimatedOpacity(
              opacity: _showImage ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Image.asset(
                'assets/ovelha2.png',
                height: 200, // Substitua pelo caminho da sua imagem
                scale: 4,
              ),
            ),
            // Lista de tarefas
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
          ],
        ),
      ),
      // meu nav bar
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        margin: EdgeInsets.symmetric(
            horizontal: 100, vertical: 10), // margem barra de navegação
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 7), // largura
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
                onPressed: calendar,
              ),
              GButton(
                icon: IconlyBroken.setting,
                text: 'Configurações',
                onPressed: settings,
              )
            ],
            selectedIndex: 0,
            onTabChange: (index) {},
          ),
        ),
      ),
    );
  }
}

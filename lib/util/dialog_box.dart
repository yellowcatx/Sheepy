import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        icon: Image.asset(
          'assets/sheep.png',
          width: 50,
          height: 50,
        ),
        title: Text(
          'Hello! lets create a new task...',
          style: TextStyle(
              color: Colors.grey, fontFamily: 'SpaceMono', fontSize: 14),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        content: Container(
          height: 150,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(120, 113, 160, 115)),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'New Task...'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'SpaceMono'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: widget.onSave,
                      child: Text(
                        'Salvar',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SpaceMono',
                            fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(100, 40),
                          backgroundColor: Color.fromRGBO(164, 190, 148, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    const SizedBox(
                      width: 20,
                      height: 69, //126, 149, 113
                    ),
                    ElevatedButton(
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontFamily: 'SpaceMono'),
                      ),
                      onPressed: widget.onCancel,
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(110, 40),
                          backgroundColor: Color.fromRGBO(164, 190, 148, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ],
                )
              ]),
        ));
  }
}

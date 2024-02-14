// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sheep/util/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

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
        backgroundColor: const Color.fromARGB(255, 255, 252, 225),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        content: Container(
          height: 125,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'New Task...'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'SpaceMono'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: onSave,
                      child: Text(
                        'Salvar',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'SpaceMono'),
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(100, 43),
                          backgroundColor: Color.fromRGBO(126, 149, 113, 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    const SizedBox(
                      width: 20,
                      height: 65, //126, 149, 113
                    ),
                    ElevatedButton(
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontFamily: 'SpaceMono'),
                      ),
                      onPressed: onCancel,
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(100, 43),
                          backgroundColor: Color.fromRGBO(126, 149, 113, 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ],
                )
              ]),
        ));
  }
}

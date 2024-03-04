import 'package:flutter/material.dart';

//light mode
ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Color.fromARGB(255, 255, 255, 235),
      primary: Color.fromARGB(226, 255, 255, 235),
      secondary: Color.fromRGBO(126, 149, 113, 0.397),
      inversePrimary: Color.fromRGBO(126, 149, 113, 0.397),
    ));

//dark mode
ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Color.fromARGB(255, 48, 48, 48),
      primary: Color.fromARGB(206, 61, 61, 61),
      secondary: Color.fromARGB(255, 66, 66, 66),
      inversePrimary: Colors.grey.shade300,
    ));

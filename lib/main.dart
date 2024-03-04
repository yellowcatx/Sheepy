import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sheep/pages/home_page.dart';
import 'package:sheep/pages/welcome_page.dart';
import 'package:sheep/theme/theme_provinder.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('mybox');

  runApp(
    MultiProvider(
      providers: [
        // Theme Provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(key: UniqueKey()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => WelcomePage(),
            '/home_page': (context) => HomePage(),
          },
          theme: themeProvider.themeData,
        );
      },
    );
  }
}

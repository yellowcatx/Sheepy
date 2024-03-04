import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sheep/pages/home_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/3.png',
            width: 250,
          ),
          Column(
            children: [
              Center(
                child: SizedBox(
                  height: 30,
                ),
              ),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(184, 207, 170, 0.984),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
              onPressed: () {
                ;
                {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType
                          .leftToRight, // Escolha o tipo de transição desejado
                      duration: Duration(milliseconds: 500),
                      child: HomePage(),
                    ),
                  );
                }
                ;
              },
              child: Text(
                'Entrar',
                style: TextStyle(fontFamily: 'SpaceMono', color: Colors.white),
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              'Developed by yellowcat',
              style: TextStyle(
                fontFamily: 'SpaceMono',
                color: Color.fromARGB(255, 165, 157, 157),
              ),
            ),
          )
        ],
      ),
    );
  }
}

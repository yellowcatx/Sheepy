import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
      backgroundColor: Color.fromARGB(255, 255, 255, 235),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/sheep2.png',
            height: 100,
            width: 200,
          ),
          Column(
            children: [
              Center(
                child: SizedBox(
                  height: 20,
                ),
              ),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(126, 149, 113, 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
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
                'Login',
                style: TextStyle(fontFamily: 'SpaceMono'),
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
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}

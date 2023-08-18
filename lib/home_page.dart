import 'package:flutter/material.dart';
import 'package:math_quiz/quiz_page.dart';
import 'enums.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          // Wrap the content in SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Image.asset(
                'lib/assets/text.png',
                width: 300,
                height: 200,
              ),
              SizedBox(height: 20),
              Image.asset(
                'lib/assets/maths.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 35),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizPage(mode: GameMode.easy)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Easy',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Chewy'), // Apply the font family
                ),
              ),
              SizedBox(height: 20), // Add space between buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizPage(mode: GameMode.medium)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Medium ',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Chewy'), // Apply the font family
                ),
              ),
              SizedBox(height: 20), // Add space between buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizPage(mode: GameMode.hard)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Hard ',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Chewy'), // Apply the font family
                ),
              ),
              SizedBox(height: 50), // Add space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}

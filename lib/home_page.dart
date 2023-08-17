import 'package:flutter/material.dart';
import 'package:math_quiz/quiz_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40), // Add top padding
            Image.asset(
              'lib/assets/text.png', // Replace with your image filename
              width: 300, // Adjust the width as needed
              height: 200, // Adjust the height as needed
            ),
            SizedBox(height: 10), // Add space between images
            Image.asset(
              'lib/assets/maths.png', // Replace with your image filename
              width: 150, // Adjust the width as needed
              height: 150, // Adjust the height as needed
            ),
            SizedBox(height: 35), // Add space between images and button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15), // Adjust button size
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30), // Adjust button shape
                ),
              ),
              child: Text(
                'Play',
                style: TextStyle(fontSize: 18), // Adjust button text size
              ),
            ),
          ],
        ),
      ),
    );
  }
}

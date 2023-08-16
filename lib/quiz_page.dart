import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentScore = 0;
  int currentQuestionIndex = 0;
  int remainingTime = 15;
  TextEditingController answerController = TextEditingController();
  Timer? timer; // Declare a Timer variable
  Random random = Random(DateTime.now()
      .millisecondsSinceEpoch); // Set seed for random number generator

  List<MathProblem> problems = [];

  List<String> operators = ['+', '-', '*', '/'];

  bool showCorrectAnswer = false; // Flag to show correct answer

  void generateProblems() {
    problems.clear(); // Clear the existing problems

    for (int i = 0; i < 5; i++) {
      int operatorIndex = random.nextInt(operators.length);
      String operator = operators[operatorIndex];
      int firstNumber = random.nextInt(21); // Generate numbers between 0 and 20
      int secondNumber = random.nextInt(21);

      if (operator == '-') {
        firstNumber = max(firstNumber, secondNumber); // Ensure positive result
      }

      // Ensure division conditions are met
      if (operator == '/') {
        secondNumber = _generateDivisor(secondNumber);
        firstNumber = secondNumber * random.nextInt(21 ~/ secondNumber);
      }

      problems.add(MathProblem(operator, firstNumber, secondNumber));
    }
  }

  int _generateDivisor(int secondNumber) {
    List<int> divisors = [];
    for (int i = 1; i <= secondNumber; i++) {
      if (secondNumber % i == 0) {
        divisors.add(i);
      }
    }

    if (divisors.isEmpty) {
      return 1; // Handle the case when no divisors are found
    }

    return divisors[random.nextInt(divisors.length)];
  }

  void startTimer() {
    timer?.cancel(); // Cancel the previous timer if it exists

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (remainingTime > 0) {
            remainingTime--;
          } else {
            timer.cancel();
            if (!showCorrectAnswer) {
              _showResultDialog();
            }
          }
        });
      } else {
        timer.cancel(); // Cancel the timer if the widget is not mounted
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            ModalBarrier(dismissible: false, color: Colors.black54),
            AlertDialog(
              title: Text('Incorrect Answer'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total Score:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$currentScore',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      Navigator.pop(context); // Close the quiz page
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    child: Text('Play Again'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    generateProblems();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MathProblem? currentProblem;

    if (currentQuestionIndex < problems.length) {
      currentProblem = problems[currentQuestionIndex];
    } else {
      currentProblem = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Math Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$remainingTime seconds',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              currentProblem != null
                  ? '${currentProblem.firstNumber} ${currentProblem.operator} ${currentProblem.secondNumber} ='
                  : '',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            TextField(
              controller: answerController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Your Answer',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (currentProblem != null) {
                  int userAnswer = int.tryParse(answerController.text) ?? 0;
                  if (userAnswer == currentProblem.result) {
                    setState(() {
                      currentScore++;
                      currentQuestionIndex++;
                      answerController.clear();

                      if (currentQuestionIndex >= problems.length) {
                        currentQuestionIndex = 0; // Reset question index
                        generateProblems(); // Generate new problems
                      }

                      remainingTime = 15;
                      startTimer();

                      showCorrectAnswer = false; // Reset the flag
                    });
                  } else {
                    setState(() {
                      answerController.clear(); // Clear the answer field
                      showCorrectAnswer =
                          true; // Set the flag to show correct answer
                      _showResultDialog(); // Show the incorrect answer dialog
                    });
                  }
                }
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            Text('Score: $currentScore'),
          ],
        ),
      ),
    );
  }
}

class MathProblem {
  final String operator;
  final int firstNumber;
  final int secondNumber;
  late int
      result; // Mark as 'late' since it will be initialized in the constructor

  MathProblem(this.operator, this.firstNumber, this.secondNumber) {
    switch (operator) {
      case '+':
        result = firstNumber + secondNumber;
        break;
      case '-':
        result = firstNumber - secondNumber;
        break;
      case '*':
        result = firstNumber * secondNumber;
        break;
      case '/':
        result = firstNumber ~/ secondNumber;
        break;
    }
  }
}

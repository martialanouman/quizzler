import 'package:flutter/material.dart';
import 'package:quizzler/quiz_engine.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizEngine quizEngine = QuizEngine();

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
        ),
      ),
      home: const Quizzler(),
    );
  }
}

class Quizzler extends StatefulWidget {
  const Quizzler({super.key});

  @override
  State<Quizzler> createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  final _textStyle = const TextStyle(color: Colors.white, fontSize: 16.0);
  List<Icon> _scoreKeeper = [];

  Icon _getIcon(bool isCorrectAnswer) {
    return isCorrectAnswer
        ? const Icon(
            Icons.check,
            color: Colors.green,
          )
        : const Icon(
            Icons.close,
            color: Colors.red,
          );
  }

  void _checkAnswer(bool guess) {
    setState(
      () {
        final isCorrectAnswer = quizEngine.checkAnswer(guess);
        _scoreKeeper.add(_getIcon(isCorrectAnswer));

        if (quizEngine.hasMoreQuestions()) {
          quizEngine.nextQuestion();
          return;
        }

        Alert(
          context: context,
          type: AlertType.success,
          title: 'Finished',
          desc: 'You reached the end of the game. Press OK to restart.',
          buttons: [
            DialogButton(
              onPressed: _reset,
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
          style: const AlertStyle(
            descStyle: TextStyle(color: Colors.white),
            titleStyle: TextStyle(color: Colors.white),
          ),
        ).show();
      },
    );
  }

  void _reset() {
    setState(() {
      Navigator.pop(context);
      quizEngine.restart();
      _scoreKeeper = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    quizEngine.getQuestionText(),
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    _checkAnswer(true);
                  },
                  child: Text(
                    'True',
                    style: _textStyle,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    _checkAnswer(false);
                  },
                  child: Text(
                    'False',
                    style: _textStyle,
                  ),
                ),
              ),
            ),
            Row(
              children: _scoreKeeper,
            )
          ],
        ),
      ),
    );
  }
}

/*
Q1: You can lead a cow down but not up stairs, false
Q2: Approximately one quarter of human bones are in the feet, true
Q3: A slug's blood is green, true
*/
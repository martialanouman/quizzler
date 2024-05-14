import 'package:quizzler/question.dart';

class QuizEngine {
  final _questions = [
    const Question('Some cats are actually allergic to humans', true),
    const Question('You can lead a cow down stairs but not up stairs.', false),
    const Question(
        'Approximately one quarter of human bones are in the feet.', true),
    const Question('A slug\'s blood is green.', true),
    const Question('Buzz Aldrin\'s mother\'s maiden name was "Moon".', true),
    const Question('It is illegal to pee in the Ocean in Portugal.', true),
    const Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    const Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    const Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    const Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    const Question('Google was originally called "Backrub".', true),
    const Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    const Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];

  int _questionIndex = 0;

  String getQuestionText() {
    return _questions[_questionIndex].questionText;
  }

  bool checkAnswer(bool guess) {
    return _questions[_questionIndex].answer == guess;
  }

  void nextQuestion() {
    if (hasMoreQuestions()) {
      ++_questionIndex;
    }
  }

  bool hasMoreQuestions() {
    return _questionIndex + 1 < _questions.length;
  }

  void restart() {
    _questionIndex = 0;
  }
}

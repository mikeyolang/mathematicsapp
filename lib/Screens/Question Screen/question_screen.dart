import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathematicsapp/Customs/questio_icon_button.dart';
import 'package:mathematicsapp/utilities/constants.dart';

import 'answer_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.duration,
    this.operator = "sum",
    this.rangeOne = "5",
    this.rangeTwo = "5",
    this.numberOfQuestions = "5",
  });
  final String operator;
  final String numberOfQuestions;
  final String rangeOne;
  final int duration;
  final String rangeTwo;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<dynamic> questions = [];
  List<dynamic> answers = [];
  bool isMarked = false;
  List<List<dynamic>> multipleChoiceQuestion = [];
  List<dynamic> userAnswer = [];
  List<dynamic> answerData = [];
  List<dynamic> ans = [];
  var j = 0;
  final CountDownController _controller = CountDownController();
  @override
  void initState() {
    for (var i = 1; i < int.parse(widget.numberOfQuestions) + 1; i++) {
      ans = [];
      final valueOne = Random().nextInt(int.parse(widget.rangeOne)) + 1;
      final valueTwo = Random().nextInt(int.parse(widget.rangeTwo)) + 1;
      if (widget.operator == "sum") {
        questions.add("$valueOne + $valueTwo = ?");
        answers.add(valueOne + valueTwo);
        answerData = [
          valueOne + valueTwo,
          valueOne + valueTwo + Random().nextInt(10) + 1,
          valueOne + valueTwo - Random().nextInt(10) - 1,
          valueOne + valueTwo + Random().nextInt(16) + 1,
        ];
      } else if (widget.operator == "minus") {
        questions.add("$valueOne - $valueTwo = ?");
        answers.add(valueOne - valueTwo);
        answerData = [
          valueOne - valueTwo,
          valueOne - valueTwo + Random().nextInt(10) + 1,
          valueOne - valueTwo - Random().nextInt(10) - 1,
          valueOne - valueTwo + Random().nextInt(16) + 1,
        ];
      } else if (widget.operator == "multiplication") {
        questions.add("$valueOne x $valueTwo = ?");
        answers.add(valueOne * valueTwo);
        answerData = [
          valueOne * valueTwo,
          valueOne * valueTwo + Random().nextInt(10) + 1,
          valueOne * valueTwo - Random().nextInt(10) - 1,
          valueOne * valueTwo + Random().nextInt(16) + 1,
        ];
      } else {
        questions.add("$valueOne / $valueTwo = ?");
        answers.add(
          (valueOne / valueTwo).toStringAsFixed(2),
        );
        answerData = [
          valueOne / valueTwo,
          valueOne / valueTwo + Random().nextInt(10) + 1,
          valueOne / valueTwo - Random().nextInt(10) - 1,
          valueOne / valueTwo + Random().nextInt(16) + 1,
        ];
      }
      for (var j = 0; j < 4; j++) {
        final roundNumber = Random().nextInt(answerData.length).round();
        ans.add(roundNumber);
        answerData.removeAt(roundNumber);
      }
      multipleChoiceQuestion.add(ans);
    }

    super.initState();
  }

  void _changeQuestion(ans) {
    userAnswer.add(ans);
    if (j + 1 >= answers.length) {
      int score = 0;
      for (var i = 0; i < answers.length; i++) {
        if (userAnswer[i].toString() == answers[i].toString()) {
          score++;
        }
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AnswerScreen(
            maximumScore: int.parse(widget.numberOfQuestions),
            score: score,
            answers: answers,
            questions: questions,
            userAnswers: userAnswer,
          ),
        ),
      );
    } else {
      setState(() {
        ++j;
        isMarked = false;
      });
      _controller.restart(duration: widget.duration);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularCountDownTimer(
                      width: mediaQueryWidth > 500
                          ? mediaQueryWidth / 10
                          : mediaQueryWidth / 6,
                      height: mediaQueryHeight / 2,
                      duration: widget.duration,
                      fillColor: baseColor,
                      ringColor: Colors.grey[400] ?? Colors.grey,
                      backgroundColor: Colors.white,
                      strokeWidth: 20,
                      textStyle: const TextStyle(
                        fontSize: 30,
                        color: baseColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textFormat: CountdownTextFormat.SS,
                      isReverse: true,
                      onStart: () {},
                      onComplete: () {
                        if (!isMarked) {
                          _changeQuestion("Time Out");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      questions[j].toString(),
                      style: TextStyle(
                        color: baseColor,
                        fontSize: mediaQueryWidth > 500 ? 45 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _changeQuestion(
                                multipleChoiceQuestion[j][0].toString());
                          },
                          child: QuestionIconButton(
                            option: multipleChoiceQuestion[j][0].toString(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            _changeQuestion(
                                multipleChoiceQuestion[j][1].toString());
                          },
                          child: QuestionIconButton(
                            option: multipleChoiceQuestion[j][1].toString(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _changeQuestion(
                                multipleChoiceQuestion[j][2].toString());
                          },
                          child: QuestionIconButton(
                            option: multipleChoiceQuestion[j][2].toString(),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _changeQuestion(
                                multipleChoiceQuestion[j][3].toString());
                          },
                          child: QuestionIconButton(
                            option: multipleChoiceQuestion[j][3].toString(),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

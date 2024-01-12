import 'package:flutter/material.dart';
import 'package:mathematicsapp/Customs/custom_app_bar.dart';
import 'package:mathematicsapp/Screens/homepage.dart';

import '../../utilities/constants.dart';
import 'users_answer.dart';

class AnswerScreen extends StatelessWidget {
  const AnswerScreen({
    super.key,
    required this.score,
    required this.maximumScore,
    required this.questions,
    required this.answers,
    required this.userAnswers,
  });
  final int score;
  final int maximumScore;
  final List<dynamic> questions;
  final List<dynamic> answers;
  final List<dynamic> userAnswers;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const CustomAppBar(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (score * 100 / maximumScore > 75 == true)
              Image.asset('assets/congratulation.gif')
            else if (score * 100 / maximumScore > 40 == true)
              Image.asset('assets/nice-try.gif')
            else
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
                child: Image.asset(
                  'assets/betterluck.png',
                  width: 300,
                ),
              ),
            const SizedBox(
              height: 30,
            ),
            Text('YOUR SCORE IS ${score.toString()}',
                style: const TextStyle(
                  fontSize: 25,
                  color: baseColorLight,
                )),
            const SizedBox(
              height: 30,
            ),
            Text('OUT OF ${maximumScore.toString()}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage())),
              child: const Text('Go To Home ->',
                  style: TextStyle(color: Colors.blueAccent)),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserAnswerScreen(
                    answers: answers,
                    questions: questions,
                    userAnswer: userAnswers,
                  ),
                ),
              ),
              child: const Text('Check Your Answer',
                  style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        ),
      ),
    );
  }
}

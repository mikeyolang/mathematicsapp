import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mathematicsapp/Customs/custom_app_bar.dart';
import 'package:mathematicsapp/Customs/custom_icon.dart';
import 'package:mathematicsapp/Screens/pdf_generation_screen.dart';
import 'package:mathematicsapp/Screens/quiz_question_screen.dart';

class Operation extends StatelessWidget {
  const Operation({super.key, required this.isQuiz});
  final bool isQuiz;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(
                parent: ScrollPhysics(),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonIcon(
                        icon: FontAwesomeIcons.plus,
                        function: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return isQuiz
                                  ? const QuestionScreen(
                                      icon: FontAwesomeIcons.plus,)
                                  : const PDFGenerationScreen(
                                      icon: FontAwesomeIcons.plus,
                                      operation: "plus",
                                    );
                            },
                          ),
                        ),
                      ),
                      CustomButtonIcon(
                        icon: FontAwesomeIcons.minus,
                        function: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return isQuiz
                                  ? const QuestionScreen(
                                      icon: FontAwesomeIcons.minus,
                                      operator: "minus",
                                    )
                                  : const PDFGenerationScreen(
                                      icon: FontAwesomeIcons.minus,
                                      operation: "minus",
                                    );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonIcon(
                        icon: FontAwesomeIcons.xmark,
                        function: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return isQuiz
                                  ? const QuestionScreen(
                                      icon: FontAwesomeIcons.xmark,
                                      operator: "multiplication",
                                    )
                                  : const PDFGenerationScreen(
                                      icon: FontAwesomeIcons.xmark,
                                      operation: "multiplication",
                                    );
                            },
                          ),
                        ),
                      ),
                      CustomButtonIcon(
                        icon: FontAwesomeIcons.divide,
                        function: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return isQuiz
                                  ? const QuestionScreen(
                                      icon: FontAwesomeIcons.divide,
                                      operator: "division",
                                    )
                                  : const PDFGenerationScreen(
                                      icon: FontAwesomeIcons.divide,
                                      operation: "division",
                                    );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

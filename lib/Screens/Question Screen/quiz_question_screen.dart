import 'package:flutter/material.dart';
import 'package:mathematicsapp/Customs/custom_app_bar.dart';
import 'package:mathematicsapp/Customs/main_screen_card.dart';
import 'package:mathematicsapp/Screens/Question%20Screen/question_screen.dart';
import 'package:mathematicsapp/utilities/constants.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.icon, this.operator = "sum"});

  final IconData icon;
  final String operator;
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _question;
  late final TextEditingController _firstRange;
  late final TextEditingController _secondRange;
  var time = 10;

  @override
  void initState() {
    super.initState();
    _question = TextEditingController();
    _firstRange = TextEditingController();
    _secondRange = TextEditingController();
  }

  @override
  void dispose() {
    _question.dispose();
    _firstRange.dispose();
    _secondRange.dispose();
    super.dispose();
  }

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
      body: Center(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(
              parent: ScrollPhysics(),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Hero(
                  tag: widget.icon,
                  child: Icon(
                    widget.icon,
                    size: 60,
                    color: baseColor,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MainScreenCard(
                        question: _question,
                        icon: widget.icon,
                        label: "How Many Questions",
                        hint: "eg. 15",
                        max: 3,
                        maximumValue: 100,
                      ),
                      MainScreenCard(
                        question: _firstRange,
                        icon: widget.icon,
                        label: "Start Value",
                        hint: "ex. 10 ",
                        max: 5,
                      ),
                      MainScreenCard(
                        question: _secondRange,
                        icon: widget.icon,
                        label: "End Value",
                        hint: "ex. 20 ",
                        max: 5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ExpansionTile(
                    title: const Text("Time"),
                    childrenPadding: const EdgeInsets.fromLTRB(30, 2, 30, 10),
                    leading: const Icon(Icons.watch_later_rounded),
                    trailing: Text("${time.toString()}s"),
                    children: [
                      ListTile(
                        title: const Text("5s"),
                        onTap: () {
                          setState(() {
                            time = 5;
                          });
                        },
                      ),
                      ListTile(
                        title: const Text("10s"),
                        onTap: () {
                          setState(() {
                            time = 10;
                          });
                        },
                      ),
                      ListTile(
                        title: const Text("15s"),
                        onTap: () {
                          setState(() {
                            time = 15;
                          });
                        },
                      ),
                      ListTile(
                        title: const Text("20s"),
                        onTap: () {
                          setState(() {
                            time = 20;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(
                              duration: time,
                              operator: widget.operator,
                              numberOfQuestions: _question.text,
                              rangeOne: _firstRange.text,
                              rangeTwo: _secondRange.text,
                            ),
                          ),
                        );
                      }
                    },
                    elevation: 20,
                    color: baseColor,
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Generate Questions",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

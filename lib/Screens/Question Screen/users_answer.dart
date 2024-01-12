import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mathematicsapp/Customs/custom_app_bar.dart';
import 'package:mathematicsapp/utilities/constants.dart';

class UserAnswerScreen extends StatefulWidget {
  const UserAnswerScreen({
    super.key,
    required this.questions,
    required this.answers,
    required this.userAnswer,
  });
  final List<dynamic> questions;
  final List<dynamic> answers;
  final List<dynamic> userAnswer;

  @override
  State<UserAnswerScreen> createState() => _UserAnswerScreenState();
}

class _UserAnswerScreenState extends State<UserAnswerScreen> {
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width > 700
                    ? 600
                    : double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                      color: baseColor,
                      elevation: 10,
                      child: ListTile(
                        leading: widget.userAnswer[index].toString() ==
                                widget.answers[index].toString()
                            ? const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.check,
                                  color: baseColor,
                                ),
                              )
                            : const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.xmark,
                                  color: redColorLight,
                                ),
                              ),
                        title: Text(
                          widget.questions[index].toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Answer = ${widget.answers[index].toString()}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        trailing: Text(
                          widget.userAnswer[index].toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: widget.answers.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

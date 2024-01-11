import 'package:flutter/material.dart';
import 'package:mathematicsapp/utilities/constants.dart';

class QuestionIconButton extends StatelessWidget {
  const QuestionIconButton({
    super.key,
    required this.option,
  });
  final String option;
  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: baseColor, width: 2),
        borderRadius: BorderRadius.circular(30),
      ),
      width: mediaQueryWidth > 500 ? 200 : mediaQueryWidth / 4,
      height: mediaQueryWidth > 550 ? 50 : mediaQueryWidth / 7,
      child: Center(
        child: Text(
          option,
          style: const TextStyle(
            color: baseColor,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}

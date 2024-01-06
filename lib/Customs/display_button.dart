import 'package:flutter/material.dart';
import 'package:mathematicsapp/utilities/colors.dart';

class CustomDisplayButton extends StatelessWidget {
  const CustomDisplayButton(
      {super.key, required this.text, required this.function});
  final String text;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
        onTap: function,
        child: Container(
          height: (MediaQuery.of(context).size.height * 50) / 810,
          width:
              MediaQuery.of(context).size.width > 550 ? 300 : double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40), color: baseColor),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  fontSize: (MediaQuery.of(context).size.height * 30) / 810),
            ),
          ),
        ),
      ),
    );
  }
}

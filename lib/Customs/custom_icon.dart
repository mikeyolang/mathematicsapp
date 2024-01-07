import 'package:flutter/material.dart';
import 'package:mathematicsapp/utilities/constants.dart';

class CustomButtonIcon extends StatelessWidget {
  const CustomButtonIcon(
      {super.key, required this.icon, required this.function});
  final IconData icon;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    late final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Flexible(
      child: MaterialButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(20),
          ),
          width: mediaQueryWidth > 550 ? 200 : mediaQueryWidth / 2,
          height: mediaQueryWidth > 550 ? 200 : mediaQueryWidth / 3,
          child: Hero(
            tag: icon,
            child: Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

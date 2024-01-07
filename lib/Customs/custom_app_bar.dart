import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mathematicsapp/Screens/homepage.dart';

import '../utilities/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.calculate_outlined,
          size: 50,
          color: Colors.white,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          if (kIsWeb) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false);
          }
        },
      ),
      title: const Text(
        "Mathematics Practice",
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.w500,
          letterSpacing: 2,
        ),
      ),
      backgroundColor: baseColor,
      elevation: 2,
    );
  }
}

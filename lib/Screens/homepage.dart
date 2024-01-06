import 'package:flutter/material.dart';
import 'package:mathematicsapp/Customs/display_button.dart';
import 'package:mathematicsapp/operation.dart';

import '../Customs/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: const CustomAppBar(),
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(
            parent: ScrollPhysics(),
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset("assets/home.jpeg"),
                ),
                CustomDisplayButton(
                  text: "Generate PDF",
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Operation(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height * 20) / 810,
                ),
                CustomDisplayButton(
                  text: "Question",
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Operation(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

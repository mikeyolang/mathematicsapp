import 'package:flutter/material.dart';
import 'package:mathematicsapp/utilities/constants.dart';

class MainScreenCard extends StatelessWidget {
  const MainScreenCard({
    super.key,
    required this.question,
    required this.icon,
    required this.label,
    required this.hint,
    required this.max,
    this.maximumValue = 999999,
  });
  final TextEditingController question;
  final IconData icon;
  final String label;
  final String hint;
  final int max;
  final int maximumValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width > 700 ? 500 : double.infinity,
      child: TextFormField(
        maxLength: max,
        controller: question,
        keyboardType: TextInputType.number,
        validator: (val) {
          if (val!.isEmpty) {
            return "Please Insert Something";
          } else if (int.parse(val) < 2) {
            return "Value Must me Greate than 3";
          } else if (int.parse(val) > maximumValue) {
            return "100 Questions only";
          }
          return null;
        },
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.red),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: redColorLight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          labelText: label,
          prefixIcon: Icon(icon),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: baseColorLight, width: 3),
            borderRadius: BorderRadius.circular(16),
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: hint,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

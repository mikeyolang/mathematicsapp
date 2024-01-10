import 'package:flutter/material.dart';

class PDFGenerationScreen extends StatefulWidget {
  const PDFGenerationScreen(
      {super.key, required this.icon, required this.operation});
  final IconData icon;
  final String operation;

  @override
  State<PDFGenerationScreen> createState() => _PDFGenerationScreenState();
}

class _PDFGenerationScreenState extends State<PDFGenerationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

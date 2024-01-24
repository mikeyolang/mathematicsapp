import 'dart:html';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mathematicsapp/Customs/custom_app_bar.dart';
import 'package:mathematicsapp/Customs/main_screen_card.dart';
import 'package:mathematicsapp/Screens/PDF%20Screen/pdf_viewer.dart';
import 'package:mathematicsapp/utilities/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class PDFGenerationScreen extends StatefulWidget {
  const PDFGenerationScreen(
      {super.key, required this.icon, required this.operation});
  final IconData icon;
  final String operation;

  @override
  State<PDFGenerationScreen> createState() => _PDFGenerationScreenState();
}

Uint8List? bytes;

class _PDFGenerationScreenState extends State<PDFGenerationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _question = TextEditingController();
  final TextEditingController _rangeOne = TextEditingController();
  final TextEditingController _rangeTwo = TextEditingController();
  Uint8List? bytes;

  bool isLoading = false;
  List<dynamic> totalQuestion = [];
  List<List<dynamic>> answerBank = [];
  List<List<dynamic>> questionBank = [];
  List<dynamic> totalQuestionAswer = [];
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
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
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Center(
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
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
                      size: 70,
                      color: baseColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MainScreenCard(
                          question: _question,
                          icon: widget.icon,
                          label: "How many Question",
                          hint: "10",
                          max: 3,
                          maximumValue: 100,
                        ),
                        MainScreenCard(
                          question: _rangeOne,
                          icon: widget.icon,
                          label: "Start Value",
                          hint: "20",
                          max: 5,
                        ),
                        MainScreenCard(
                          question: _rangeTwo,
                          icon: widget.icon,
                          label: "End Value",
                          hint: "100",
                          max: 5,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = !isLoading;
                        });
                        bool addInArray = false;
                        questionBank
                            .add(["Questions", "Questions", "Questions"]);
                        answerBank.add(["Answers", "Answers", "Answers"]);
                        for (var i = 1;
                            i < int.parse(_question.text) + 1;
                            i++) {
                          addInArray = false;
                          final valueOne =
                              Random().nextInt(int.parse(_rangeOne.text)) + 1;
                          final valueTwo =
                              Random().nextInt(int.parse(_rangeTwo.text)) + 1;

                          if (widget.operation == "addition") {
                            totalQuestion
                                .add(" $i) $valueOne + $valueTwo = ______");
                            totalQuestionAswer.add(
                                " $i) $valueOne + $valueTwo = ${valueOne + valueTwo}");
                          } else if (widget.operation == "subtraction") {
                            totalQuestion
                                .add(" $i) $valueOne - $valueTwo = ______");
                            totalQuestionAswer.add(
                                " $i) $valueOne - $valueTwo = ${valueOne - valueTwo}");
                          } else if (widget.operation == "multiplication") {
                            totalQuestion
                                .add(" $i) $valueOne x $valueTwo = ______");
                            totalQuestionAswer.add(
                                " $i) $valueOne x $valueTwo = ${valueOne * valueTwo}");
                          } else if (widget.operation == "division") {
                            totalQuestion
                                .add(" $i) $valueOne / $valueTwo = ______");
                            totalQuestionAswer.add(
                                " $i) $valueOne / $valueTwo = ${(valueOne / valueTwo).toStringAsFixed(2)}");
                          }
                          if (i % 3 == 0) {
                            addInArray = true;
                            questionBank.add(totalQuestion);
                            answerBank.add(totalQuestionAswer);
                            totalQuestion = [];
                            totalQuestionAswer = [];
                          }
                        }
                        if (!addInArray) {
                          addInArray = true;
                          questionBank.add(totalQuestion);
                          answerBank.add(totalQuestionAswer);
                          totalQuestion = [];
                          totalQuestionAswer = [];
                        }
                        final pdf = pw.Document();
                        pdf.addPage(
                          pw.MultiPage(
                            build: (pw.Context context) => <pw.Widget>[
                              pw.Header(level: 0, text: "Questions"),
                              // ignore: deprecated_member_use
                              pw.Table.fromTextArray(
                                  context: context, data: questionBank),
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        );
                        questionBank = [];
                        answerBank = [];
                        if (kIsWeb) {
                          pdf.save().then((value) {
                            setState(() {
                              bytes = value;
                            });
                          });
                          await Future.delayed(const Duration(seconds: 1));
                          final blob = html.Blob([
                            bytes
                          ], 'application${DateTime.now().millisecondsSinceEpoch}/pdf');
                          final url = html.Url.createObjectUrlFromBlob(blob);
                          final anchor = html.document.createElement("a")
                              as html.AnchorElement
                            ..href = url
                            ..style.display = "none"
                            ..download =
                                "NoMcq_${DateTime.now().millisecondsSinceEpoch}.pdf";
                          html.document.body!.children.add(anchor);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewer(
                                pdfName:
                                    "NoMcq__${DateTime.now().microsecondsSinceEpoch}.ppdf",
                                anchor: anchor,
                                savePdf: bytes,
                              ),
                            ),
                          );
                        }
                      } else{
                        // Implement else statement
                      }
                    },
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

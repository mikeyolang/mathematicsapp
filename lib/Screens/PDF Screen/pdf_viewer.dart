// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;

import "dart:developer";

class PdfViewer extends StatefulWidget {
  const PdfViewer({
    super.key,
    this.path,
    this.savePdf,
    this.anchor,
    required this.pdfName,
  });
  final String pdfName;
  final path;
  final savePdf;
  final anchor;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 1,
        title: Text(
          widget.pdfName,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            letterSpacing: 2,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (kIsWeb) {
                  try {
                    Printing.layoutPdf(
                        onLayout: (PdfPageFormat format) async =>
                            await widget.savePdf.save() as Future<Uint8List>);
                  } catch (e) {
                    log(e.toString());
                  }
                } else {
                  widget.anchor.click();
                  html.document.body!.append(widget.anchor);
                }
              },
              icon: const Icon(Icons.download_sharp))
        ],
      ),
      body: kIsWeb
          ? PdfPreview(
              build: (format) => widget.savePdf.save(),
            )
          : Center(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: PdfPreview(
                  build: (format) => widget.savePdf.save(),
                ),
              ),
            ),
    );
  }
}

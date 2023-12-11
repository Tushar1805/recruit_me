import 'dart:io';

import 'package:avestan_test/UI/widgets/normal_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;
  const PDFViewerPage({Key? key, required this.file}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  @override
  Widget build(BuildContext context) {
    // final name = basename(widget.file.path);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: normalAppBar(context, name),
      body: Stack(children: [
        Container(
          child: PDFView(
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            fitPolicy: FitPolicy.BOTH,
            filePath: widget.file.path,
          ),
        ),
        Container(),
      ]),
    );
  }
}

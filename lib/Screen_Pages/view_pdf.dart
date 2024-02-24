import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfview extends StatefulWidget {
  final String pdfUrl;

  const Pdfview({super.key, required this.pdfUrl});

  @override
  State<Pdfview> createState() => _PdfviewState();
}

class _PdfviewState extends State<Pdfview> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleSpacing: -10,

        title: Padding(
          padding: EdgeInsets.only(left: screenWidth(context, dividedBy: 30)),
          child: custom_header(text: "Document"),
        ),
      ),
      body: SfPdfViewer.network(
        widget.pdfUrl,
        key: _pdfViewerKey,
      ),
    );
  }
}

class pdfviewshow extends StatefulWidget {
  final String pdfUrl;

  const pdfviewshow({super.key, required this.pdfUrl});

  @override
  State<pdfviewshow> createState() => _pdfviewshowState();
}

class _pdfviewshowState extends State<pdfviewshow> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          titleSpacing: -10,

          title: Padding(
            padding: EdgeInsets.only(left: screenWidth(context, dividedBy: 30)),
            child: custom_header(text: "Document"),
          ),
        ),
        body: SfPdfViewer.file(File(widget.pdfUrl)));

  }
}

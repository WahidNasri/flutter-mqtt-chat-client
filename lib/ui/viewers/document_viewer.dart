import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class DocumentViewer extends StatefulWidget {
  final String docUrl;
  final String? title;

  DocumentViewer({Key? key, required this.docUrl, this.title})
      : super(key: key);

  @override
  _DocumentViewerState createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  PDFDocument? document;

  @override
  void initState() {
    PDFDocument.fromURL(
      widget.docUrl,
    ).then((value) {
      setState(() {
        document = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "Document Viewer"),
      ),
      body: document == null
          ? Text("Loading...")
          : PDFViewer(
              document: document!,
              zoomSteps: 1,
              scrollDirection: Axis.vertical),
    );
  }
}

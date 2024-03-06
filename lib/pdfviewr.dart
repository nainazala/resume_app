import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:resume_app/ModelResume.dart';

class PDFViewrs extends StatefulWidget {
  ModelResume model;
  PDFViewrs({required this.model});


  @override
  State<PDFViewrs> createState() => _PDFViewrsState();
}

class _PDFViewrsState extends State<PDFViewrs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    // final ByteData bytes = await rootBundle.load('assets/phone.png');
    // final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Header(text: widget.model.name.toString()+" Resume", level: 1),
                      // pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.fitHeight, height: 100, width: 100)
                    ]),
                pw.Divider(borderStyle: pw.BorderStyle.dashed),
                pw.Paragraph(text:  widget.model.name.toString()),
                pw.Paragraph(text:  widget.model.email.toString()),
                pw.Paragraph(text:  widget.model.address.toString()),
                pw.Paragraph(text:  widget.model.phone.toString()),
                pw.Paragraph(text:  widget.model.education.toString()),
              ]);
        }));
    return pdf.save();
  }
}

import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
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
    print(widget.model.toString());
    print(widget.model.phone);

    final File? file = File(widget.model.photo.toString());
    print(file);
    Uint8List bytes = file!.readAsBytesSync() as Uint8List;

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
                      pw.Header(
                          text: widget.model.name.toString() + " Resume",
                          level: 1),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [

                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Divider(borderStyle: pw.BorderStyle.dashed),
                        pw.Paragraph(text: widget.model.name.toString(),
                            style: pw.TextStyle(fontSize: 30,color: PdfColors.black)),
                        pw.Paragraph(text: "Prsonal Detail",
                            style: pw.TextStyle(fontSize: 22,color: PdfColors.blue)),

                        pw.Paragraph(text: widget.model.email.toString()),
                        pw.Paragraph(text: widget.model.address.toString()),
                        pw.Paragraph(text: widget.model.phone.toString()),
                        pw.Paragraph(text: "Education Detail",
                            style: pw.TextStyle(fontSize: 22,color: PdfColors.blue)),
                        pw.Paragraph(text: widget.model.education.toString()),
                      ]),
                  pw.Expanded(child: pw.Container()),
                  pw.Image(pw.MemoryImage(bytes!),
                      fit: pw.BoxFit.fitHeight, height: 100, width: 100),
                ]),
              ]);
        }));
    return pdf.save();
  }
}

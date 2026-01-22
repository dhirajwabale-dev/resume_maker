import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Controller/create_resume_controller.dart';
import '../Utility/asset_string.dart';
import 'PDF widget/first_pdf_widget.dart';
import 'PDF widget/initial_pdf_widget.dart';
import 'PDF widget/third_pdf_widget.dart';

Future<Uint8List> createBiodataPdf(
  CreateResumeController controller,
  int flag,
) async {
  final pdf = pw.Document();

  final PdfColor pdfColor = toPdfColor(controller.selectedColor.value);
  final selectedTemp = controller.selectedTempIndex.value;

  final adaminaFont = pw.Font.ttf(
    await rootBundle.load(AssetString.adaminaFont),
  );

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(16),
      build: (context) {
        if (selectedTemp == 0) {
          return firstPDfWidget(
            context,
            controller: controller,
            flag: flag,
            pdfColor: pdfColor,
            adaminaFont: adaminaFont,
          );
        } else if (selectedTemp == 1) {
          return initialPdfWidget(
            context,
            controller: controller,
            pdfColor: pdfColor,
            flag: flag,
            adaminaFont: adaminaFont,
          );
        } else if (selectedTemp == 2) {
          return thirdPDfWidget(
            context,
            controller: controller,
            pdfColor: pdfColor,
            flag: flag,
            adaminaFont: adaminaFont,
          );
        } else {
          return initialPdfWidget(
            context,
            controller: controller,
            flag: flag,
            pdfColor: pdfColor,
            adaminaFont: adaminaFont,
          );
        }
      },
    ),
  );

  return pdf.save();
}

PdfColor toPdfColor(Color color) {
  final pdfColor = PdfColor.fromInt(color.value);

  return pdfColor;
}

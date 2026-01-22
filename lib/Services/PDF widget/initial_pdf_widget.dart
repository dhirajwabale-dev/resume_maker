import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../Controller/create_resume_controller.dart';

List<pw.Widget> initialPdfWidget(
  pw.Context context, {
  required CreateResumeController controller,
  required PdfColor pdfColor,
  required int flag,
}) {
  return [
    buildHeader(controller, pdfColor),
    sectionTitle(controller, pdfColor),
    if (flag == 0) buildExperienceWidget(controller, pdfColor),
    buildEucationWidget(controller, pdfColor),
    if (flag == 0) buildProjectWidget(controller, pdfColor),
    buildSkillData(controller, pdfColor),
    buildLangaugeData(controller, pdfColor),
    buildSocialMedia(controller, pdfColor),
  ];
}

////-------------------- HEADER --------------------////
pw.Widget buildHeader(CreateResumeController c, PdfColor pdfColor) {
  return pw.Container(
    color: pdfColor,
    padding: const pw.EdgeInsets.all(10),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(14),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.white),
          ),
          child: pw.Text(
            "${c.firstNameController.value.text.isNotEmpty ? c.firstNameController.value.text[0] : "N"}"
            "${c.lastNameController.value.text.isNotEmpty ? c.lastNameController.value.text[0] : "N"}",
            style: pw.TextStyle(
              color: PdfColors.white,
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.SizedBox(width: 10),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "${c.firstNameController.value.text} ${c.lastNameController.value.text}",
              style: pw.TextStyle(
                color: PdfColors.white,
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              c.addressController.value.text,
              style: pw.TextStyle(color: PdfColors.white),
            ),
            pw.Text(
              c.mobileController.value.text,
              style: pw.TextStyle(color: PdfColors.white),
            ),
            pw.Text(
              c.emailController.value.text,
              style: pw.TextStyle(color: PdfColors.white),
            ),
          ],
        ),
      ],
    ),
  );
}

////-------------------- SECTION TITLE --------------------////
pw.Widget sectionTitle(CreateResumeController c, PdfColor pdfColor) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.SizedBox(height: 8),
      _title("Summary", pdfColor),
      pw.SizedBox(height: 8),
      pw.Text(c.summaryController.value.text),
      pw.Divider(),
    ],
  );
}

////-------------------- EXPERIENCE --------------------////
pw.Widget buildExperienceWidget(CreateResumeController c, PdfColor pdfColor) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Experience", pdfColor),

      for (var item in c.jobList)
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 4),
          child: _bullet(
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        item["employerName"],
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Text(
                      item["city"],
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.Text(item["jobtitle"]),

                pw.Text(
                  "${DateFormat("MM/yyyy").format(item["fromDate"])} - "
                  "${DateFormat("MM/yyyy").format(item["toDate"])}",
                ),

                pw.SizedBox(height: 6),

                pw.Text(
                  "Details :  ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),

                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 30),
                  child: pw.Text(item["details"]),
                ),
              ],
            ),
          ),
        ),

      pw.Divider(),
    ],
  );
}

////-------------------- EDUCATION --------------------////
pw.Widget buildEucationWidget(CreateResumeController c, PdfColor pdfColor) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Education", pdfColor),

      for (var item in c.educationList)
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 4),
          child: _bullet(
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisSize: pw.MainAxisSize.min, // Important
                    children: [
                      pw.Text(
                        item["degree"],
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),

                      pw.Text(item["university"]),
                      pw.Text(
                        "${DateFormat("MM/yyyy").format(item["startDate"])} - "
                        "${DateFormat("MM/yyyy").format(item["endDate"])}",
                      ),
                    ],
                  ),
                ),
                pw.Text(
                  item["city"],
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      pw.Divider(),
    ],
  );
}

////-------------------- PROJECT --------------------////
pw.Widget buildProjectWidget(CreateResumeController c, PdfColor pdfColor) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Project Experience", pdfColor),

      for (var item in c.projectList)
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 4),
          child: _bullet(
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Project Name : ",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    pw.Text(
                      item["projectName"],
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),

                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Duration : ",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    pw.Text(item["duration"]),
                  ],
                ),

                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Tech : ",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    pw.Text(item["technology"]),
                  ],
                ),

                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Overview : ",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),

                    pw.Expanded(child: pw.Text(item["overview"])),
                  ],
                ),

                pw.Text(
                  "Features : ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),

                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: pw.Text(item["feature"]),
                ),

                pw.Text(
                  "Roles : ",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),

                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: pw.Text(item["rules"]),
                ),
              ],
            ),
          ),
        ),

      pw.Divider(),
    ],
  );
}

////-------------------- SKILLS --------------------////
pw.Widget buildSkillData(CreateResumeController c, PdfColor pdfColor) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Skills", pdfColor),
      pw.Column(
        children: c.skillsList.map((item) {
          int p = item["proficiency"];
          return _bullet(
            pw.Row(
              children: [
                pw.Text(item["skill"]),
                pw.Spacer(),
                pw.Row(
                  children: List.generate(5, (i) {
                    return pw.Container(
                      margin: const pw.EdgeInsets.only(left: 2),
                      width: 8,
                      height: 8,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        color: i < p ? pdfColor : PdfColors.grey300,
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        }).toList(),
      ),
      pw.Divider(),
    ],
  );
}

////-------------------- LANGUAGE --------------------////
pw.Widget buildLangaugeData(CreateResumeController c, PdfColor pdfColor) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Language", pdfColor),
      pw.Column(
        children: c.languageList.map((item) {
          int p = item["proficiency"];
          return _bullet(
            pw.Row(
              children: [
                pw.Text(item["lang"]),
                pw.Spacer(),
                pw.Row(
                  children: List.generate(5, (i) {
                    return pw.Container(
                      margin: const pw.EdgeInsets.only(left: 2),
                      width: 8,
                      height: 8,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        color: i < p ? pdfColor : PdfColors.grey300,
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        }).toList(),
      ),
      pw.Divider(),
    ],
  );
}

////-------------------- SOCIAL --------------------////
pw.Widget buildSocialMedia(CreateResumeController c, PdfColor pdfColor) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Social Media", pdfColor),
      pw.Column(
        children: c.socialDataList.map((item) {
          return _bullet(pw.Text(item, style: pw.TextStyle(color: pdfColor)));
        }).toList(),
      ),
    ],
  );
}

////-------------------- COMMON WIDGETS --------------------////
pw.Widget _title(String text, PdfColor pdfColor) {
  return pw.Container(
    width: double.infinity,
    padding: const pw.EdgeInsets.all(8),
    color: pdfColor,
    child: pw.Text(
      text,
      style: pw.TextStyle(
        color: PdfColors.white,
        fontSize: 16,
        fontWeight: pw.FontWeight.bold,
      ),
    ),
  );
}

pw.Widget _bullet(pw.Widget child) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 4),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 6,
          height: 6,
          margin: const pw.EdgeInsets.only(top: 5),
          decoration: const pw.BoxDecoration(
            color: PdfColors.black,
            shape: pw.BoxShape.circle,
          ),
        ),
        pw.SizedBox(width: 6),
        pw.Expanded(child: child),
      ],
    ),
  );
}

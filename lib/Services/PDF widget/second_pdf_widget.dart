import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../Controller/create_resume_controller.dart';

/// ==================== MAIN PDF WIDGET ====================
List<pw.Widget> secondPDfWidget(
  pw.Context context, {
  required CreateResumeController controller,
  required PdfColor pdfColor,
  required pw.Font adaminaFont,
  required int flag,
}) {
  final pageWidth = PdfPageFormat.a4.availableWidth;

  return [
    pw.Partitions(
      children: [
        pw.Partition(
          width: pageWidth * 0.4,
          child: pw.Container(
            color: PdfColors.blueGrey900,
            padding: const pw.EdgeInsets.all(10),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildTitleWidget(controller, pdfColor, adaminaFont),
                buildEucationWidget(controller, pdfColor, adaminaFont),
                buildSkillData(controller, pdfColor, adaminaFont),
                buildLangaugeData(controller, pdfColor, adaminaFont),
              ],
            ),
          ),
        ),

        pw.Partition(
          width: pageWidth * 0.6,
          child: pw.Container(
            padding: const pw.EdgeInsets.all(10),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                buildHeader(controller, pdfColor, adaminaFont),
                sectionTitle(controller, pdfColor, adaminaFont),
                buildExperienceWidget(controller, pdfColor, adaminaFont),
                buildProjectWidget(controller, pdfColor, adaminaFont),
                buildSocialMedia(controller, pdfColor, adaminaFont),
              ],
            ),
          ),
        ),
      ],
    ),
  ];
}

/// ==================== SAFE DATE FORMATTER ====================
String formatDate(dynamic date) {
  if (date == null) return "Present";
  if (date is DateTime) {
    return DateFormat("MM/yyyy").format(date);
  }
  return date.toString();
}

/// ==================== LEFT TITLE ====================
pw.Widget _buildTitleWidget(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  final firstName = c.firstNameController.value.text.trim();
  final lastName = c.lastNameController.value.text.trim();

  return pw.Container(
    width: double.infinity,
    padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(20),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.white),
          ),
          child: pw.Text(
            (firstName.isNotEmpty && lastName.isNotEmpty)
                ? "${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}"
                : "MN",
            style: pw.TextStyle(
              font: font,
              fontSize: 16,
              color: PdfColors.white,
            ),
          ),
        ),

        pw.Divider(thickness: 3, color: PdfColors.white),
        pw.SizedBox(height: 6),

        pw.Text(
          "Phone Number",
          style: pw.TextStyle(color: PdfColors.white, font: font),
        ),
        pw.Text(
          c.mobileController.value.text.isNotEmpty
              ? c.mobileController.value.text
              : "9922856963",
          style: pw.TextStyle(color: PdfColors.white, font: font),
        ),

        pw.SizedBox(height: 8),

        pw.Text(
          "Email ID",
          style: pw.TextStyle(color: PdfColors.white, font: font),
        ),
        pw.Text(
          c.emailController.value.text.isNotEmpty
              ? c.emailController.value.text
              : "dhirajwable212@gmail.com",
          style: pw.TextStyle(color: PdfColors.white, font: font),
        ),

        pw.SizedBox(height: 8),

        pw.Text(
          "Address",
          style: pw.TextStyle(color: PdfColors.white, font: font),
        ),
        pw.Text(
          "${c.addressController.value.text}, Pin Code - ${c.pincodeController.value.text}",
          style: pw.TextStyle(color: PdfColors.white, font: font),
        ),
      ],
    ),
  );
}

/// ==================== HEADER ====================
pw.Widget buildHeader(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(10),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(14),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black),
          ),
          child: pw.Text(
            "${c.firstNameController.value.text.isNotEmpty ? c.firstNameController.value.text[0] : "N"}"
            "${c.lastNameController.value.text.isNotEmpty ? c.lastNameController.value.text[0] : "N"}",
            style: pw.TextStyle(
              font: font,
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
                font: font,
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              c.addressController.value.text,
              style: pw.TextStyle(font: font),
            ),
            pw.Text(
              c.mobileController.value.text,
              style: pw.TextStyle(font: font),
            ),
            pw.Text(
              c.emailController.value.text,
              style: pw.TextStyle(font: font),
            ),
          ],
        ),
      ],
    ),
  );
}

/// ==================== SUMMARY ====================
pw.Widget sectionTitle(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Summary", pdfColor, font),
      pw.Text(c.summaryController.value.text, style: pw.TextStyle(font: font)),
    ],
  );
}

/// ==================== EXPERIENCE ====================
pw.Widget buildExperienceWidget(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Experience", pdfColor, font),
      for (var item in c.jobList)
        _bullet(
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Text(
                      item["employerName"] ?? "",
                      style: pw.TextStyle(
                        font: font,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Text(item["city"] ?? "", style: pw.TextStyle(font: font)),
                ],
              ),
              pw.Text(item["jobtitle"] ?? "", style: pw.TextStyle(font: font)),
              pw.Text(
                "${formatDate(item["fromDate"])} - ${formatDate(item["toDate"])}",
                style: pw.TextStyle(font: font),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                "Details:",
                style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(left: 20),
                child: pw.Text(
                  item["details"] ?? "",
                  style: pw.TextStyle(font: font),
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

/// ==================== EDUCATION ====================
pw.Widget buildEucationWidget(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Education", pdfColor, font),
      for (var item in c.educationList)
        _bullet(
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      item["degree"] ?? "",
                      style: pw.TextStyle(
                        font: font,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      item["university"] ?? "",
                      style: pw.TextStyle(font: font),
                    ),
                    pw.Text(
                      "${formatDate(item["startDate"])} - ${formatDate(item["endDate"])}",
                      style: pw.TextStyle(font: font),
                    ),
                  ],
                ),
              ),
              pw.Text(
                item["city"] ?? "",
                style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        ),
    ],
  );
}

/// ==================== PROJECT ====================
pw.Widget buildProjectWidget(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Project Experience", pdfColor, font),
      for (var item in c.projectList)
        _bullet(
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Project Name : ${item["projectName"]}",
                style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                "Duration : ${item["duration"]}",
                style: pw.TextStyle(font: font),
              ),
              pw.Text(
                "Tech : ${item["technology"]}",
                style: pw.TextStyle(font: font),
              ),
              pw.Text(
                "Overview : ${item["overview"]}",
                style: pw.TextStyle(font: font),
              ),
              pw.Text(
                "Features : ${item["feature"]}",
                style: pw.TextStyle(font: font),
              ),
              pw.Text(
                "Roles : ${item["rules"]}",
                style: pw.TextStyle(font: font),
              ),
            ],
          ),
        ),
    ],
  );
}

/// ==================== SKILLS ====================
pw.Widget buildSkillData(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Skills", pdfColor, font),
      for (var item in c.skillsList)
        _bullet(
          pw.Row(
            children: [
              pw.Text(item["skill"], style: pw.TextStyle(font: font)),
              pw.Spacer(),
              pw.Row(
                children: List.generate(5, (i) {
                  final int p = (item["proficiency"] ?? 0) as int;
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
        ),
    ],
  );
}

/// ==================== LANGUAGE ====================
pw.Widget buildLangaugeData(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Language", pdfColor, font),
      for (var item in c.languageList)
        _bullet(
          pw.Row(
            children: [
              pw.Text(item["lang"], style: pw.TextStyle(font: font)),
              pw.Spacer(),

              pw.Row(
                children: List.generate(5, (i) {
                  final int p = (item["proficiency"] ?? 0) as int;
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
        ),
    ],
  );
}

/// ==================== SOCIAL ====================
pw.Widget buildSocialMedia(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Social Media", pdfColor, font),
      for (var item in c.socialDataList)
        _bullet(
          pw.Text(
            item,
            style: pw.TextStyle(font: font, color: pdfColor),
          ),
        ),
    ],
  );
}

/// ==================== COMMON ====================
pw.Widget _title(String text, PdfColor pdfColor, pw.Font font) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        text,
        style: pw.TextStyle(
          font: font,
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.Divider(thickness: 3),
      pw.SizedBox(height: 4),
    ],
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

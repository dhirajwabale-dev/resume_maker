import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../Controller/create_resume_controller.dart';

List<pw.Widget> thirdPDfWidget(
  pw.Context context, {
  required CreateResumeController controller,
  required PdfColor pdfColor,
  required pw.Font adaminaFont,
}) {
  return [
    buildHeader(controller, pdfColor, adaminaFont),

    sectionTitle(controller, pdfColor, adaminaFont),
    pw.SizedBox(height: 10),
    buildSkillData(controller, pdfColor, adaminaFont),
    pw.SizedBox(height: 10),
    buildExperienceWidget(controller, pdfColor, adaminaFont),
    pw.SizedBox(height: 10),
    buildProjectWidget(controller, pdfColor, adaminaFont),

    pw.SizedBox(height: 10),
    buildEucationWidget(controller, pdfColor, adaminaFont),
    pw.SizedBox(height: 10),

    buildLangaugeData(controller, pdfColor, adaminaFont),
    pw.SizedBox(height: 10),
    buildSocialMedia(controller, pdfColor, adaminaFont),
  ];
}

////-------------------- HEADER --------------------////
pw.Widget buildHeader(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  final firstName = c.firstNameController.value.text.trim();
  final lastName = c.lastNameController.value.text.trim();
  final email = c.emailController.value.text.trim();
  final mobile = c.mobileController.value.text.trim();
  final address = c.addressController.value.text.trim();
  final pincode = c.pincodeController.value.text.trim();
  final designation = c.userDesignationController.value.text.trim();

  return pw.Container(
    padding: const pw.EdgeInsets.all(10),
    child: pw.Column(
      children: [
        pw.Text(
          (firstName.isNotEmpty && lastName.isNotEmpty)
              ? "$firstName $lastName"
              : "Nikita Nibe",
          style: pw.TextStyle(
            color: PdfColors.black,
            fontSize: 22,
            font: font,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          designation.isNotEmpty ? designation : "Software Developer",
          style: pw.TextStyle(color: PdfColors.black, font: font),
        ),

        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(
              mobile.isNotEmpty ? "📞 mobile" : "📞 9922856963",
              style: pw.TextStyle(color: PdfColors.black, font: font),
            ),
            pw.SizedBox(width: 6),

            pw.Text(
              email.isNotEmpty ? "✉️ $email" : "✉️ nikitanibe@gmail.com",
              style: pw.TextStyle(color: PdfColors.black, font: font),
            ),
          ],
        ),
        pw.Text(
          (address.isNotEmpty && pincode.isNotEmpty)
              ? "$address, Pin Code - $pincode"
              : "At Post-Kolhar, Tal-Rahata, Dist-Ahmednagar,PinCodes-410714",

          style: pw.TextStyle(color: PdfColors.black, font: font),
        ),
      ],
    ),
  );
}

////-------------------- SECTION TITLE --------------------////
pw.Widget sectionTitle(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  final summary = c.summaryController.value.text.trim();
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.SizedBox(height: 18),
      _title("Summary", pdfColor, font),
      pw.SizedBox(height: 8),
      pw.Text(
        summary.isNotEmpty
            ? summary
            : "Flutter Developer with 3 years of hands-on experience in designing, developing, and deploying high-performance mobile applications for Android and iOS. Proficient in Dart, Flutter framework, and modern app architecture with strong expertise in state management, API integration, Firebase services, and UI/UX optimization. Experienced in full app lifecycle—from requirement analysis and development to Play Store deployment and maintenance.",
        style: pw.TextStyle(font: font),
      ),
    ],
  );
}

////-------------------- EXPERIENCE --------------------////
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
                        style: pw.TextStyle(
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Text(
                      item["city"],
                      style: pw.TextStyle(
                        font: font,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.Text(item["jobtitle"]),

                pw.Text(
                  "${DateFormat("MM/yyyy").format(item["fromDate"])} - "
                  "${DateFormat("MM/yyyy").format(item["toDate"])}",
                  style: pw.TextStyle(font: font),
                ),

                pw.SizedBox(height: 6),

                pw.Text(
                  "Details :  ",
                  style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 30),
                  child: pw.Text(
                    item["details"],
                    style: pw.TextStyle(font: font),
                  ),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}

////-------------------- EDUCATION --------------------////
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
                        style: pw.TextStyle(
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),

                      pw.Text(
                        item["university"],
                        style: pw.TextStyle(font: font),
                      ),
                      pw.Text(
                        "${DateFormat("MM/yyyy").format(item["startDate"])} - "
                        "${DateFormat("MM/yyyy").format(item["endDate"])}",
                        style: pw.TextStyle(font: font),
                      ),
                    ],
                  ),
                ),
                pw.Text(
                  item["city"],
                  style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}

////-------------------- PROJECT --------------------////
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
                      style: pw.TextStyle(
                        font: font,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),

                    pw.Text(
                      item["projectName"],
                      style: pw.TextStyle(
                        font: font,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Duration : ",
                      style: pw.TextStyle(
                        font: font,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),

                    pw.Text(item["duration"], style: pw.TextStyle(font: font)),
                  ],
                ),

                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Tech : ",
                      style: pw.TextStyle(
                        font: font,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),

                    pw.Text(
                      item["technology"],
                      style: pw.TextStyle(font: font),
                    ),
                  ],
                ),

                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Overview : ",
                      style: pw.TextStyle(
                        font: font,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),

                    pw.Expanded(
                      child: pw.Text(
                        item["overview"],
                        style: pw.TextStyle(font: font),
                      ),
                    ),
                  ],
                ),

                pw.Text(
                  "Features : ",
                  style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: pw.Text(
                    item["feature"],
                    style: pw.TextStyle(font: font),
                  ),
                ),

                pw.Text(
                  "Roles : ",
                  style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 40),
                  child: pw.Text(
                    item["rules"],
                    style: pw.TextStyle(font: font),
                  ),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}

////-------------------- SKILLS --------------------////
pw.Widget buildSkillData(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Skills", pdfColor, font),
      pw.Column(
        children: c.skillsList.map((item) {
          int p = item["proficiency"];
          return _bullet(
            pw.Row(
              children: [
                pw.Text(item["skill"], style: pw.TextStyle(font: font)),
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
    ],
  );
}

////-------------------- LANGUAGE --------------------////
pw.Widget buildLangaugeData(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Language", pdfColor, font),
      pw.Column(
        children: c.languageList.map((item) {
          int p = item["proficiency"];
          return _bullet(
            pw.Row(
              children: [
                pw.Text(item["lang"], style: pw.TextStyle(font: font)),
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
    ],
  );
}

////-------------------- SOCIAL --------------------////
pw.Widget buildSocialMedia(
  CreateResumeController c,
  PdfColor pdfColor,
  pw.Font font,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _title("Social Media", pdfColor, font),
      pw.Column(
        children: c.socialDataList.map((item) {
          return _bullet(
            pw.Text(
              item,
              style: pw.TextStyle(font: font, color: pdfColor),
            ),
          );
        }).toList(),
      ),
    ],
  );
}

////-------------------- COMMON WIDGETS --------------------////
pw.Widget _title(String text, PdfColor pdfColor, pw.Font font) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        text,
        style: pw.TextStyle(
          color: PdfColors.black,
          fontSize: 16,
          font: font,
          fontWeight: pw.FontWeight.bold,
        ),
      ),

      pw.Divider(thickness: 3, color: PdfColors.black),
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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controller/create_resume_controller.dart';
import '../Services/responsive_ui.dart';
import 'app_color.dart';
import 'asset_string.dart';

//Common Text
Widget buildCommonText(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  TextAlign? textAlign,
}) {
  return SelectableText(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(
      color: color ?? AppColors.black,
      fontSize: fontSize ?? 14.sp,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
  );
}

//Common Text
Widget buildCommonTextWithFont(
  String text, {
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  TextAlign? textAlign,
}) {
  return SelectableText(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: GoogleFonts.adamina(
      //adamina
      //ebGaramond
      color: color ?? AppColors.black,
      fontSize: fontSize ?? 14.sp,
      fontWeight: fontWeight ?? FontWeight.normal,
    ),
  );
}

void commonDialog(String msg) {
  Get.dialog(
    Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: IntrinsicWidth(
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildCommonText(
                  "Info",
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 12.h),
                buildCommonText(msg),

                SizedBox(height: 20.h),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: Text("OK"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

List<String> imageList = [
  AssetString.firstTemp,
  AssetString.secondTemp,
  AssetString.thirdTemp,
];

List<String> templateList = [
  AssetString.firstTemp,
  AssetString.temp1,
  AssetString.temp2,
];

void buildTemplateDialog(
  BuildContext context, {
  required CreateResumeController c,
}) {
  final isMoblile = ResponsiveUi.isMobile(context);

  int selectedIndex = 0;

  Get.dialog(
    //barrierDismissible: false,
    Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isMoblile ? 400.w : 500.w),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Header Close Btn
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCommonText(
                    "Templates Preview",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),

                  TextButton(
                    onPressed: () {
                      Get.back();
                      c.selectedTempIndex.value = null;
                    },
                    child: Text("RESET"),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              //CarouselSlider
              SizedBox(
                height: 350.h,
                width: 380.w,
                child: CarouselSlider(
                  items: templateList.map((item) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: InteractiveViewer(
                        boundaryMargin: EdgeInsets.all(4),
                        minScale: 0.8,
                        maxScale: 3,
                        child: Image.asset(
                          item,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      selectedIndex = index;
                    },
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              buildCommonText(
                "Pinch to zoom • Swipe to change",
                fontSize: 12.sp,
                color: AppColors.grey,
              ),
              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text("CANCEL"),
                  ),
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      c.selectedTempIndex.value = selectedIndex;
                    },
                    child: Text("OK"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget title(String text, {Color? color}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      buildCommonTextWithFont(
        text,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: color ?? AppColors.black,
      ),
      Divider(thickness: 3, color: color ?? AppColors.black),
    ],
  );
}

Widget buildTitleContainer({required String title, required Color color}) {
  return Column(
    children: [
      Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(color: color),
        child: buildCommonText(
          title,
          fontSize: 16.sp,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),

      SizedBox(height: 4.h),
    ],
  );
}

List<Map<String, dynamic>> skillListData = [
  {
    "skill": "Java",
    "proficiency": 3,
    "tools": "VS code",
    "other_skills": "Node Js",
  },
  {
    "skill": "Flutter",
    "proficiency": 4,
    "tools": "VS code",
    "other_skills": "Node Js",
  },
  {
    "skill": "Mysql",
    "proficiency": 3,
    "tools": "VS code",
    "other_skills": "Node Js",
  },
];

List<Map<String, dynamic>> jobListData = [
  {
    "jobtitle": "Software Developer",
    "employerName": "Accenture",
    "city": "Pune",
    "details":
        "I am a Flutter Developer with 3 years of professional experience, currently working with Accenture, where I contribute to building scalable, high-performance mobile applications for enterprise-level clients.",
    "fromDate": DateTime(2024, 1, 7, 17, 30),
    "toDate": DateTime(2025, 12, 7, 17, 30),
  },
  {
    "jobtitle": "Software Developer",
    "employerName": "Intouch Consumer care solution",
    "city": "Pune",
    "details":
        "I am a Flutter Developer with 3 years of professional experience, currently working with Accenture, where I contribute to building scalable, high-performance mobile applications for enterprise-level clients.",
    "fromDate": DateTime(2024, 1, 7, 17, 30),
    "toDate": DateTime(2025, 12, 7, 17, 30),
  },
];

List<Map<String, dynamic>> priojectListData = [
  {
    "projectName": "Bussiness App",
    "duration": "3 Months",
    "technology": "Flutter SDK",
    "overview":
        "Flutter Developer with 3 years of experience at Accenture, specializing in cross-platform mobile application development using Flutter and Dart.",
    "feature":
        "1.mplemented complex UI designs, dashboards, and business workflows.\n2.Integrated REST APIs, Firebase services, and real-time data handling.\n3.Used GetX for efficient state management and app architecture",
    "rules":
        "1.Design, develop, and maintain cross-platform mobile applications using Flutter and Dart for Android and iOS platforms.\n2.Translate business requirements and UI/UX designs into high-quality, scalable mobile applications.\n3.Implement state management using frameworks such as GetX to ensure efficient data flow and performance.\n4.Integrate RESTful APIs, handle JSON parsing, and manage asynchronous operations.",
  },
  {
    "projectName": "Bussiness App",
    "duration": "3 Months",
    "technology": "Flutter SDK",
    "overview":
        "Flutter Developer with 3 years of experience at Accenture, specializing in cross-platform mobile application development using Flutter and Dart.",
    "feature":
        "1.mplemented complex UI designs, dashboards, and business workflows.\n2.Integrated REST APIs, Firebase services, and real-time data handling.\n3.Used GetX for efficient state management and app architecture",
    "rules":
        "1.Design, develop, and maintain cross-platform mobile applications using Flutter and Dart for Android and iOS platforms.\n2.Translate business requirements and UI/UX designs into high-quality, scalable mobile applications.\n3.Implement state management using frameworks such as GetX to ensure efficient data flow and performance.\n4.Integrate RESTful APIs, handle JSON parsing, and manage asynchronous operations.",
  },
];

List<Map<String, dynamic>> educationListData = [
  {
    "degree": "Mobile Computing",
    "university": "C-DAC",
    "city": "Pune",
    "startDate": DateTime(2022, 9, 7, 17, 30),
    "endDate": DateTime(2023, 3, 7, 17, 30),
  },
  {
    "degree": "Msc",
    "university": "Pune University",
    "city": "Pune",
    "startDate": DateTime(2017, 6, 7, 17, 30),
    "endDate": DateTime(2019, 6, 7, 17, 30),
  },
];

List<Map<String, dynamic>> langListData = [
  {"lang": "English", "proficiency": 4},
  {"lang": "Marathi", "proficiency": 5},
];

List<String> socialListData = [
  "https://biomakerapp.web.app",
  "https://resumemaker-a298f.web.app",
];

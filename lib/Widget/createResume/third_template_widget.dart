import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Utility/app_color.dart';
import '../../Utility/utils.dart';

class ThirdTemplateWidget extends StatelessWidget {
  ThirdTemplateWidget({super.key});

  final controller = Get.find<CreateResumeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title container
            _buildTitleContainer(),

            //Summary Text
            _buildSummaryContainer(),

            //Skill Data
            _buildSkillData(),

            //Experience Data
            _buildExperienceData(),

            //Project Data
            _buildProjectData(),

            //Education Data
            _buildEducationData(),

            //Language Data
            _buildLangaugeData(),

            //build Social Media
            _buildSocialMedia(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleContainer() {
    return Obx(() {
      final firstName = controller.firstNameController.value.text.trim();
      final lastName = controller.lastNameController.value.text.trim();
      final email = controller.emailController.value.text.trim();
      final mobile = controller.mobileController.value.text.trim();
      final address = controller.addressController.value.text.trim();
      final pincode = controller.pincodeController.value.text.trim();
      final designation = controller.userDesignationController.value.text
          .trim();

      return Container(
        width: Get.width,
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildCommonTextWithFont(
              (firstName.isNotEmpty && lastName.isNotEmpty)
                  ? "$firstName $lastName"
                  : "Nikita Nibe",
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
            SizedBox(width: 10.h),

            buildCommonTextWithFont(
              designation.isNotEmpty ? designation : "Software Developer",
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.call,
                  size: 18.sp,
                  color: controller.selectedColor.value,
                ),
                buildCommonTextWithFont(
                  mobile.isNotEmpty ? mobile : "9922856963",
                ),

                SizedBox(width: 6.w),

                Icon(
                  Icons.mail,
                  size: 18.sp,
                  color: controller.selectedColor.value,
                ),
                buildCommonTextWithFont(
                  email.isNotEmpty ? email : "nikitanibe@gmail.com",
                ),
              ],
            ),

            buildCommonTextWithFont(
              (address.isNotEmpty && pincode.isNotEmpty)
                  ? "$address, Pin Code - $pincode"
                  : "At Post-Kolhar, Tal-Rahata, Dist-Ahmednagar,PinCodes-410714",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSummaryContainer() {
    return Obx(() {
      final summary = controller.summaryController.value.text;
      return Padding(
        padding: EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title("Professional Summary"),

            SelectableText(
              summary.isNotEmpty
                  ? summary
                  : "Flutter Developer with 3 years of hands-on experience in designing, developing, and deploying high-performance mobile applications for Android and iOS. Proficient in Dart, Flutter framework, and modern app architecture with strong expertise in state management, API integration, Firebase services, and UI/UX optimization. Experienced in full app lifecycle—from requirement analysis and development to Play Store deployment and maintenance.",
              style: GoogleFonts.adamina(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSkillData() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title("Skills"),

            _buildSkillTextField(
              firstText: "Technology",
              secondText: controller.skillController.value.text.trim(),
            ),
            _buildSkillTextField(
              firstText: "Tools",
              secondText: controller.toolController.value.text.trim(),
            ),
            _buildSkillTextField(
              firstText: "Other Skills",
              secondText: controller.otherSkillsController.value.text.trim(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildExperienceData() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title("Experience"),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.jobList.length,
              itemBuilder: (context, index) {
                final item = controller.jobList[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: Icon(Icons.circle, size: 10.sp),
                        ),
                        SizedBox(width: 4.w),

                        buildCommonTextWithFont(
                          item["employerName"] ?? "",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        Spacer(),
                        buildCommonTextWithFont(
                          "${item["fromDate"] != null ? DateFormat("MM/yyyy").format(item["fromDate"]) : "From date"} - "
                          "${item["toDate"] != null ? DateFormat("MM/yyyy").format(item["toDate"]) : "To Date"}",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Row(
                        children: [
                          buildCommonTextWithFont(
                            item["jobtitle"] ?? "",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),

                          Spacer(),
                          buildCommonTextWithFont(
                            item["city"] ?? "",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: buildCommonTextWithFont(
                        item["details"] ?? "",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildEducationData() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title("Education"),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.educationList.length,
              itemBuilder: (context, index) {
                final item = controller.educationList[index];

                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Icon(Icons.circle, size: 10.sp),
                        ),

                        SizedBox(width: 4.w),
                        buildCommonTextWithFont(
                          item["degree"] ?? "",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        Spacer(),
                        buildCommonTextWithFont(
                          "${item["startDate"] != null ? DateFormat("MM/yyyy").format(item["startDate"]) : "Start Date"} - "
                          "${item["endDate"] != null ? DateFormat("MM/yyyy").format(item["endDate"]) : "End Date"}",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Row(
                        children: [
                          buildCommonTextWithFont(
                            item["university"] ?? "",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          Spacer(),
                          buildCommonTextWithFont(item["city"] ?? ""),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProjectData() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title("Projects"),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.projectList.length,
              itemBuilder: (context, index) {
                final item = controller.projectList[index];

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Icon(Icons.circle, size: 10.sp),
                    ),

                    SizedBox(width: 4.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildCommonTextWithFont(
                                "Project ${index + 1} : ",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),

                              buildCommonTextWithFont(
                                item["projectName"] ?? "",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildCommonTextWithFont(
                                "Technology : ",
                                fontWeight: FontWeight.bold,
                              ),

                              buildCommonTextWithFont(
                                item["technology"] ?? "",

                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),

                          buildCommonTextWithFont(
                            "Roles & Responsibility : ",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 40.w),
                            child: buildCommonTextWithFont(
                              item["rules"] ?? "",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildLangaugeData() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title("Langauge"),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.languageList.length,
              itemBuilder: (context, index) {
                final item = controller.languageList[index];

                final int proficiency = item["proficiency"] ?? 0;

                return Row(
                  children: [
                    Icon(Icons.circle, size: 12.sp),
                    SizedBox(width: 4.w),
                    buildCommonTextWithFont(
                      item["lang"] ?? "",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),

                    Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (i) {
                        return Icon(
                          (i) < proficiency
                              ? Icons.circle
                              : Icons.circle_outlined,
                          size: 14.sp,
                        );
                      }),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSocialMedia() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title("Social Media"),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.socialDataList.length,
              itemBuilder: (context, index) {
                final item = controller.socialDataList[index];

                return Row(
                  children: [
                    Icon(Icons.circle, size: 12.sp),
                    SizedBox(width: 4.w),
                    buildCommonTextWithFont(
                      item,
                      fontSize: 16.sp,
                      color: AppColors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSkillTextField({
    required String firstText,
    required String secondText,
  }) {
    return Row(
      children: [
        Icon(Icons.circle, size: 12.sp),
        SizedBox(width: 4.w),
        buildCommonTextWithFont("$firstText : ", fontWeight: FontWeight.bold),
        buildCommonTextWithFont(secondText, color: Colors.black87),
      ],
    );
  }
}

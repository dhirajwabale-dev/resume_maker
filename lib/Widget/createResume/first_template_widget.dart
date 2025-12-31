import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Utility/app_color.dart';
import '../../Utility/utils.dart';

class FirstTemplateWidget extends StatelessWidget {
  FirstTemplateWidget({super.key});

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

            //Education Data
            _buildEducationData(),

            //Project Data
            _buildProjectData(),

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

      return Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(border: Border.all()),
                  child: buildCommonTextWithFont(
                    (firstName.isNotEmpty && lastName.isNotEmpty)
                        ? "${firstName.substring(0, 1).toUpperCase()}${lastName.substring(0, 1).toUpperCase()}"
                        : "MN",
                    fontSize: 16.sp,
                  ),
                ),

                SizedBox(width: 10.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildCommonTextWithFont(
                        (firstName.isNotEmpty && lastName.isNotEmpty)
                            ? "$firstName $lastName"
                            : "Nikita Nibe",
                        fontWeight: FontWeight.bold,
                        fontSize: 22.sp,
                      ),

                      buildCommonTextWithFont(
                        (address.isNotEmpty && pincode.isNotEmpty)
                            ? "$address, Pin Code - $pincode"
                            : "At Post Madhewadgaon, Tal-Shrigonda, Dist-Ahmednagar, pin-413726",
                      ),

                      buildCommonTextWithFont(
                        mobile.isNotEmpty ? mobile : "9922856963",
                      ),

                      buildCommonTextWithFont(
                        email.isNotEmpty ? email : "dhirajwable212@gmail.com",
                      ),
                    ],
                  ),
                ),
              ],
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
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title("Summary"),

            SelectableText(
              summary.isNotEmpty
                  ? summary
                  : "Flutter Developer with 3 years of hands-on experience in designing, developing, and deploying high-performance mobile applications for Android and iOS. Proficient in Dart, Flutter framework, and modern app architecture with strong expertise in state management, API integration, Firebase services, and UI/UX optimization. Experienced in full app lifecycle—from requirement analysis and development to Play Store deployment and maintenance. Strong problem-solving skills with a focus on writing clean, scalable, and maintainable code.",
              style: GoogleFonts.adamina(),
            ),

            SizedBox(height: 8.h),
          ],
        ),
      );
    });
  }

  Widget _buildSkillData() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title("Skills"),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.skillsList.length,
              itemBuilder: (context, index) {
                final item = controller.skillsList[index];

                final int proficiency = item["proficiency"] ?? 0;

                return Row(
                  children: [
                    Icon(Icons.circle, size: 12.sp),
                    SizedBox(width: 4.w),
                    buildCommonTextWithFont(
                      item["skill"] ?? "",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacer(),

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

            SizedBox(height: 8.h),
          ],
        ),
      );
    });
  }

  Widget _buildExperienceData() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
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
                          buildCommonTextWithFont(
                            item["employerName"] ?? "",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),

                          SizedBox(height: 4.h),

                          buildCommonTextWithFont(
                            item["jobtitle"] ?? "",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),

                          SizedBox(height: 4.h),

                          buildCommonTextWithFont(
                            "${item["fromDate"] != null ? DateFormat("MM/yyyy").format(item["fromDate"]) : "From date"} - "
                            "${item["toDate"] != null ? DateFormat("MM/yyyy").format(item["toDate"]) : "To Date"}",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),

                          SizedBox(height: 8.h),

                          buildCommonTextWithFont(
                            item["details"] ?? "",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),

                    buildCommonTextWithFont(
                      item["city"] ?? "",
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 8.h),
          ],
        ),
      );
    });
  }

  Widget _buildEducationData() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
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

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Icon(Icons.circle, size: 10.sp),
                    ),

                    SizedBox(width: 4.w),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildCommonTextWithFont(
                          item["degree"] ?? "",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),

                        SizedBox(height: 4.h),

                        buildCommonTextWithFont(
                          item["university"] ?? "",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),

                        SizedBox(height: 4.h),

                        buildCommonTextWithFont(
                          "${item["startDate"] != null ? DateFormat("MM/yyyy").format(item["startDate"]) : "Start Date"} - "
                          "${item["endDate"] != null ? DateFormat("MM/yyyy").format(item["endDate"]) : "End Date"}",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),

                    Spacer(),
                    buildCommonTextWithFont(
                      item["city"] ?? "",
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 8.h),
          ],
        ),
      );
    });
  }

  Widget _buildProjectData() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title("Project Experience"),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 12.h),
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
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),

                              buildCommonTextWithFont(
                                item["projectName"] ?? "",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),

                          SizedBox(height: 4.h),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildCommonTextWithFont(
                                "Duration : ",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),

                              buildCommonTextWithFont(
                                item["duration"] ?? "",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),

                          SizedBox(height: 4.h),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildCommonTextWithFont(
                                "Technology : ",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),

                              buildCommonTextWithFont(
                                item["technology"] ?? "",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),

                          SizedBox(height: 4.h),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildCommonTextWithFont(
                                "OverView : ",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),

                              Expanded(
                                child: buildCommonTextWithFont(
                                  item["overview"] ?? "",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4.h),

                          buildCommonTextWithFont(
                            "Feature : ",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 40.w),
                            child: buildCommonTextWithFont(
                              item["feature"] ?? "",
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(height: 4.h),

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

            SizedBox(height: 8.h),
          ],
        ),
      );
    });
  }

  Widget _buildLangaugeData() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
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

            SizedBox(height: 8.h),
          ],
        ),
      );
    });
  }

  Widget _buildSocialMedia() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
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

            SizedBox(height: 8.h),
          ],
        ),
      );
    });
  }
}

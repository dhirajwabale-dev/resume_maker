import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Utility/app_color.dart';
import '../../Utility/utils.dart';

class SecondTemplateWidget extends StatelessWidget {
  const SecondTemplateWidget({
    super.key,
    required this.controller,
    required this.flag,
  });

  final CreateResumeController controller;
  final int flag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 40,
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(color: const Color(0xFF1F4253)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //First Container
                    _buildTitleWidget(),

                    //Education Data
                    _buildEducationData(),

                    //Skill Data
                    _buildSkillData(),

                    //Language Data
                    _buildLangaugeData(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 70,
            child: SizedBox(
              height: Get.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Title container
                    _buildTitleContainer(),

                    //Summary Text
                    _buildSummaryContainer(),

                    //Experience Data
                    _buildExperienceData(),

                    //Project Data
                    _buildProjectData(),

                    //build Social Media
                    _buildSocialMedia(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleWidget() {
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
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.white60),
              ),
              child: buildCommonText(
                (firstName.isNotEmpty && lastName.isNotEmpty)
                    ? "${firstName.substring(0, 1).toUpperCase()}${lastName.substring(0, 1).toUpperCase()}"
                    : "MN",
                fontSize: 16.sp,
                color: AppColors.white60,
              ),
            ),

            Divider(thickness: 3, color: AppColors.white),
            SizedBox(height: 4.h),
            buildCommonText("Phone Number", color: AppColors.white),
            buildCommonText(
              mobile.isNotEmpty ? mobile : "9922856963",
              color: AppColors.white60,
            ),

            SizedBox(height: 8.h),

            buildCommonText("Email ID", color: AppColors.white),
            buildCommonText(
              email.isNotEmpty ? email : "dhirajwable212@gmail.com",
              color: AppColors.white60,
            ),

            SizedBox(height: 8.h),

            buildCommonText("Address", color: AppColors.white),
            buildCommonText(
              (address.isNotEmpty && pincode.isNotEmpty)
                  ? "$address, Pin Code - $pincode"
                  : "At Post Madhewadgaon, Tal-Shrigonda, Dist-Ahmednagar, pin-413726",
              color: AppColors.white60,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTitleContainer() {
    return Obx(() {
      final firstName = controller.firstNameController.value.text.trim();
      final lastName = controller.lastNameController.value.text.trim();

      return Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCommonText(
              (firstName.isNotEmpty && lastName.isNotEmpty)
                  ? "$firstName $lastName"
                  : "Nikita Nibe",
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),

            buildCommonText(
              "Software Developer",
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title("Summary"),

            SelectableText(
              summary.isNotEmpty
                  ? summary
                  : "Flutter Developer with 3 years of hands-on experience in designing, developing, and deploying high-performance mobile applications for Android and iOS. Proficient in Dart, Flutter framework, and modern app architecture with strong expertise in state management, API integration, Firebase services, and UI/UX optimization. Experienced in full app lifecycle—from requirement analysis and development to Play Store deployment and maintenance. Strong problem-solving skills with a focus on writing clean, scalable, and maintainable code.",
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
            title("Skills", color: AppColors.white),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.skillsList.length,
              itemBuilder: (context, index) {
                final item = controller.skillsList[index];

                final int proficiency = item["proficiency"] ?? 0;

                return Row(
                  children: [
                    Icon(Icons.circle, color: AppColors.white, size: 12.sp),
                    SizedBox(width: 4.w),
                    buildCommonText(
                      item["skill"] ?? "",
                      fontSize: 16.sp,
                      color: AppColors.white60,
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
                          color: AppColors.white60,
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
                          buildCommonText(
                            item["employerName"] ?? "",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),

                          SizedBox(height: 4.h),

                          buildCommonText(
                            item["jobtitle"] ?? "",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),

                          SizedBox(height: 4.h),

                          buildCommonText(
                            "${item["fromDate"] != null ? DateFormat("MM/yyyy").format(item["fromDate"]) : "From date"} - "
                            "${item["toDate"] != null ? DateFormat("MM/yyyy").format(item["toDate"]) : "To Date"}",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),

                          SizedBox(height: 8.h),

                          buildCommonText(
                            item["details"] ?? "",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),

                    buildCommonText(
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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title("Education", color: AppColors.white),

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
                      child: Icon(
                        Icons.circle,
                        color: AppColors.white,
                        size: 10.sp,
                      ),
                    ),

                    SizedBox(width: 4.w),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildCommonText(
                          item["degree"] ?? "",
                          fontSize: 16.sp,
                          color: AppColors.white60,
                          fontWeight: FontWeight.bold,
                        ),

                        SizedBox(height: 4.h),

                        buildCommonText(
                          item["university"] ?? "",
                          fontSize: 12.sp,
                          color: AppColors.white60,
                          fontWeight: FontWeight.w500,
                        ),

                        SizedBox(height: 4.h),

                        buildCommonText(
                          "${item["startDate"] != null ? DateFormat("MM/yyyy").format(item["startDate"]) : "Start Date"} - "
                          "${item["endDate"] != null ? DateFormat("MM/yyyy").format(item["endDate"]) : "End Date"}",
                          fontSize: 12.sp,
                          color: AppColors.white60,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),

                    Spacer(),
                    buildCommonText(
                      item["city"] ?? "",
                      color: AppColors.white60,
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
                              buildCommonText(
                                "Project ${index + 1} : ",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),

                              buildCommonText(
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
                              buildCommonText(
                                "Duration : ",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),

                              buildCommonText(
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
                              buildCommonText(
                                "Technology : ",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),

                              buildCommonText(
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
                              buildCommonText(
                                "OverView : ",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),

                              Expanded(
                                child: buildCommonText(
                                  item["overview"] ?? "",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4.h),

                          buildCommonText(
                            "Feature : ",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 40.w),
                            child: buildCommonText(
                              item["feature"] ?? "",
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(height: 4.h),

                          buildCommonText(
                            "Roles & Responsibility : ",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 40.w),
                            child: buildCommonText(
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
            title("Langauge", color: AppColors.white),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.languageList.length,
              itemBuilder: (context, index) {
                final item = controller.languageList[index];

                final int proficiency = item["proficiency"] ?? 0;

                return Row(
                  children: [
                    Icon(Icons.circle, color: AppColors.white, size: 12.sp),
                    SizedBox(width: 4.w),
                    buildCommonText(
                      item["lang"] ?? "",
                      fontSize: 16.sp,
                      color: AppColors.white60,
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
                          color: AppColors.white60,
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
            title("Social Media", color: AppColors.black),
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
                    buildCommonText(
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

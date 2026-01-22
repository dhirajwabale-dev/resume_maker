import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resume_maker/UI/preview_screen.dart';
import 'package:resume_maker/Utility/utils.dart';

import '../Controller/create_resume_controller.dart';
import '../Services/responsive_ui.dart';
import '../Utility/app_color.dart';
import '../Widget/common_app_bar_widget.dart';
import '../Widget/createResume/resume_education_form_widget.dart';
import '../Widget/createResume/resume_header_form_widget.dart';
import '../Widget/createResume/resume_job_form_widget.dart';
import '../Widget/createResume/resume_lang_form_widget.dart';
import '../Widget/createResume/resume_preview_widget.dart';
import '../Widget/createResume/resume_project_form_widget.dart';
import '../Widget/createResume/resume_skills_widget.dart';
import '../Widget/createResume/resume_social_media_widget.dart';
import '../Widget/createResume/resume_summary_widget.dart';
import '../Widget/general_safe_area_widget.dart';
import '../Widget/progress_indicator_widget.dart';

class CreateResumeScreen extends StatelessWidget {
  CreateResumeScreen({super.key, this.flag = 0});

  final int flag; //For fresher 1 and for experience 0

  final controller = Get.put(CreateResumeController());

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUi.isMobile(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GeneralSafeAreaWidget(
        child: Scaffold(
          appBar: commonAppBar(),

          body: Obx(() {
            final count = controller.continueCount.value;

            return Stack(
              children: [
                isMobile
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildworkinPageWidget(isMobile),

                            _buildCommonTextFields(count),

                            //BACK AND CONTINUE BTN
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  OutlinedButton(
                                    onPressed: controller.clickOnBack,
                                    child: Text("Back"),
                                  ),

                                  (controller.isFinalSubmit.value)
                                      ? ElevatedButton(
                                          onPressed: () {
                                            Get.to(
                                              () => PreviewScreen(
                                                controller: controller,
                                                flag: flag,
                                              ),
                                            );
                                          },
                                          child: Text("preview"),
                                        )
                                      : ElevatedButton(
                                          onPressed: () =>
                                              controller.clickOnContinue(flag),
                                          child: Text("Continue"),
                                        ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20.h),

                            //Review Page
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 8.h,
                              ),
                              child: ResumePreview(
                                controller: controller,
                                flag: flag,
                              ),
                            ),

                            SizedBox(height: 12.h),
                          ],
                        ),
                      )
                    : Row(
                        children: [
                          _buildworkinPageWidget(isMobile),

                          Expanded(
                            child: SizedBox(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        //LEFT SIDE – FORM
                                        Expanded(
                                          flex: 4,
                                          child: SingleChildScrollView(
                                            padding: const EdgeInsets.all(16),
                                            child: _buildCommonTextFields(
                                              count,
                                            ),
                                          ),
                                        ),

                                        //RIGHT SIDE – LIVE PREVIEW
                                        Expanded(
                                          flex: 6,
                                          child: ResumePreview(
                                            controller: controller,
                                            flag: flag,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //BACK AND CONTINUE BTN
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 10.h,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        OutlinedButton(
                                          onPressed: controller.clickOnBack,
                                          child: Text("Back"),
                                        ),

                                        (controller.isFinalSubmit.value)
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  Get.to(
                                                    () => PreviewScreen(
                                                      controller: controller,
                                                      flag: flag,
                                                    ),
                                                  );
                                                },
                                                child: Text("preview"),
                                              )
                                            : ElevatedButton(
                                                onPressed: () => controller
                                                    .clickOnContinue(flag),
                                                child: Text("Continue"),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                //Loading Widget
                if (controller.isLoading.value) ProgressIndicatorWidget(),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCommonTextFields(int count) {
    final selectedIndex = controller.selectedTempIndex.value;

    //For Fresher
    if (flag == 1) {
      return (selectedIndex == null)
          ? Column(
              children: [
                //Header Resume Part
                if (count == 0) ResumeHeaderFormWidget(controller: controller),

                //Summary Resume Part
                if (count == 1) ResumeSummaryWidget(controller: controller),

                //Education Resume Part
                if (count == 2)
                  ResumeEducationFormWidget(controller: controller),

                //Skills Resume Part
                if (count == 3) ResumeSkillsWidget(controller: controller),

                //Language Resume Part
                if (count == 4) ResumeLangFormWidget(controller: controller),

                //Socia Media Resume Part
                if (count == 5) ResumeSocialMediaWidget(controller: controller),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Header Resume Part
                if (count == 0) ResumeHeaderFormWidget(controller: controller),

                //Summary Resume Part
                if (count == 1) ResumeSummaryWidget(controller: controller),

                //Skills Resume Part
                if (count == 2) ResumeSkillsWidget(controller: controller),

                //Education Resume Part
                if (count == 3)
                  ResumeEducationFormWidget(controller: controller),

                //Language Resume Part
                if (count == 4) ResumeLangFormWidget(controller: controller),

                //Socia Media Resume Part
                if (count == 5) ResumeSocialMediaWidget(controller: controller),

                SizedBox(height: 20.h),
              ],
            );
    }

    return (selectedIndex == null)
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Header Resume Part
              if (count == 0) ResumeHeaderFormWidget(controller: controller),

              //Summary Resume Part
              if (count == 1) ResumeSummaryWidget(controller: controller),

              //Job Resume Part
              if (count == 2) ResumeJobFormWidget(controller: controller),

              //Education Resume Part
              if (count == 3) ResumeEducationFormWidget(controller: controller),

              //Project Resume Part
              if (count == 4) ResumeProjectFormWidget(controller: controller),

              //Skills Resume Part
              if (count == 5) ResumeSkillsWidget(controller: controller),

              //Language Resume Part
              if (count == 6) ResumeLangFormWidget(controller: controller),

              //Socia Media Resume Part
              if (count == 7) ResumeSocialMediaWidget(controller: controller),

              SizedBox(height: 20.h),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Header Resume Part
              if (count == 0) ResumeHeaderFormWidget(controller: controller),

              //Summary Resume Part
              if (count == 1) ResumeSummaryWidget(controller: controller),

              //Skills Resume Part
              if (count == 2) ResumeSkillsWidget(controller: controller),

              //Job Resume Part
              if (count == 3) ResumeJobFormWidget(controller: controller),

              //Education Resume Part
              if (count == 4) ResumeEducationFormWidget(controller: controller),

              //Project Resume Part
              if (count == 5) ResumeProjectFormWidget(controller: controller),

              //Language Resume Part
              if (count == 6) ResumeLangFormWidget(controller: controller),

              //Socia Media Resume Part
              if (count == 7) ResumeSocialMediaWidget(controller: controller),

              SizedBox(height: 20.h),
            ],
          );
  }

  Widget _buildworkinPageWidget(bool isMobile) {
    return Container(
      width: isMobile ? Get.width : 80.w,
      height: isMobile ? 80.h : Get.height,
      color: Colors.blueGrey,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      child: isMobile
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Icon(Icons.file_copy, color: AppColors.white, size: 32.sp),

                  SizedBox(width: 10.w),

                  //For Experience Candidates
                  if (flag == 0) ...[
                    _buildCircularWidget(0),
                    _buildStraightHoriLine(1),
                    _buildCircularWidget(1),
                    _buildStraightHoriLine(2),
                    _buildCircularWidget(2),
                    _buildStraightHoriLine(3),
                    _buildCircularWidget(3),
                    _buildStraightHoriLine(4),
                    _buildCircularWidget(4),
                    _buildStraightHoriLine(5),
                    _buildCircularWidget(5),
                    _buildStraightHoriLine(6),
                    _buildCircularWidget(6),
                    _buildStraightHoriLine(7),
                    _buildCircularWidget(7),
                  ],

                  //For Fresher Candidates
                  if (flag == 1) ...[
                    _buildCircularWidget(0),
                    _buildStraightHoriLine(1),
                    _buildCircularWidget(1),
                    _buildStraightHoriLine(2),
                    _buildCircularWidget(2),
                    _buildStraightHoriLine(3),
                    _buildCircularWidget(3),
                  ],
                ],
              ),
            )
          : Column(
              children: [
                Icon(Icons.file_copy, color: AppColors.white, size: 32.sp),

                SizedBox(height: 14.h),

                //For Experience Candidates
                if (flag == 0) ...[
                  _buildCircularWidget(0),
                  _buildStraightLine(1),
                  _buildCircularWidget(1),
                  _buildStraightLine(2),
                  _buildCircularWidget(2),
                  _buildStraightLine(3),
                  _buildCircularWidget(3),
                  _buildStraightLine(4),
                  _buildCircularWidget(4),
                  _buildStraightLine(5),
                  _buildCircularWidget(5),
                  _buildStraightLine(6),
                  _buildCircularWidget(6),
                  _buildStraightLine(7),
                  _buildCircularWidget(7),
                ],

                //For Fresher Candidates
                if (flag == 1) ...[
                  _buildCircularWidget(0),
                  _buildStraightLine(1),
                  _buildCircularWidget(1),
                  _buildStraightLine(2),
                  _buildCircularWidget(2),
                  _buildStraightLine(3),
                  _buildCircularWidget(3),
                  _buildStraightLine(4),
                  _buildCircularWidget(4),
                  _buildStraightLine(5),
                  _buildCircularWidget(5),
                ],
              ],
            ),
    );
  }

  Widget _buildCircularWidget(int index) {
    return Obx(() {
      final isActive = controller.continueCount.value == index;
      final isCompleted = controller.continueCount.value > index;

      return GestureDetector(
        onTap: () {
          controller.continueCount.value = index;
        },
        child: Container(
          height: 30.h,
          width: 30.w,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.circular(50.r),
            color: isActive || isCompleted
                ? AppColors.white
                : AppColors.transparent,
          ),

          child: Center(
            child: buildCommonText(
              index.toString(),
              color: isActive || isCompleted
                  ? AppColors.black
                  : AppColors.white,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildStraightLine(int index) {
    return Obx(() {
      final isActive = controller.continueCount.value == index;
      final isCompleted = controller.continueCount.value > index;

      return Container(
        height: 50.h,
        width: 2.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive || isCompleted ? AppColors.white : AppColors.grey,
          ),
        ),
      );
    });
  }

  Widget _buildStraightHoriLine(int index) {
    return Obx(() {
      final isActive = controller.continueCount.value == index;
      final isCompleted = controller.continueCount.value > index;

      return Container(
        height: 2.h,
        width: 20.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive || isCompleted ? AppColors.white : AppColors.grey,
          ),
        ),
      );
    });
  }
}

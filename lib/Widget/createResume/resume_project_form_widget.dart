import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Utility/app_color.dart';
import '../../Utility/utils.dart';

class ResumeProjectFormWidget extends StatelessWidget {
  ResumeProjectFormWidget({super.key, this.flag = 0});

  final int? flag;

  final controller = Get.find<CreateResumeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCommonText(
            "Add details about your Project",
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 20.h),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textField(
                  label: "Project Name",
                  textController: controller.projectNameController.value,
                ),

                if (flag == 0)
                  _textField(
                    label: "Duration",
                    textController: controller.durationController.value,
                  ),
                _textField(
                  label: "Environment/Technology",
                  textController: controller.environmentController.value,
                ),
                if (flag == 0)
                  _textField(
                    label: "Overview",
                    textController: controller.overviewController.value,
                  ),
                if (flag == 0)
                  _textFieldForMaxLine(
                    label: "Features",
                    textController: controller.fetureController.value,
                  ),
                _textFieldForMaxLine(
                  label: "Rules & Responsibility",
                  textController: controller.rulesController.value,
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => controller.clickOnProjectAdd(),
                child: Text("Add"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField({
    required String label,
    required TextEditingController textController,
    //required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(labelText: label),
        //  /   onChanged: onChanged,
      ),
    );
  }

  Widget _textFieldForMaxLine({
    required String label,
    required TextEditingController textController,
    //required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        maxLines: 3,
        controller: textController,
        decoration: InputDecoration(labelText: label),
        // onChanged: onChanged,
      ),
    );
  }
}

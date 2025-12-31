import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Utility/app_color.dart';
import '../../Utility/utils.dart';

class ResumeSummaryWidget extends StatelessWidget {
  ResumeSummaryWidget({super.key});

  final controller = Get.find<CreateResumeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCommonText(
            "Professional Summary",
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
                //Summary textField
                _textField(
                  label: "Summary",
                  textController: controller.summaryController.value,
                ),
              ],
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
        maxLines: 5,
        controller: textController,
        decoration: InputDecoration(labelText: label),
        // onChanged: onChanged,
      ),
    );
  }
}

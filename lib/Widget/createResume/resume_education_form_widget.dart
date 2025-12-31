import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Utility/app_color.dart';
import '../../Utility/utils.dart';

class ResumeEducationFormWidget extends StatelessWidget {
  ResumeEducationFormWidget({super.key});

  final controller = Get.find<CreateResumeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCommonText(
            "Add details about your Education",
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
                  label: "Degree",
                  textController: controller.degreeController.value,
                ),
                _textField(
                  label: "University/School",
                  textController: controller.univercityController.value,
                ),
                _textField(
                  label: "City",
                  textController: controller.placeController.value,
                ),

                SizedBox(height: 10.h),

                _buildFromDateContainer(context),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => controller.clickOnEducationAdd(),
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
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        // onChanged: onChanged,
      ),
    );
  }

  Widget _buildFromDateContainer(BuildContext context) {
    return Obx(() {
      final startDate = controller.startDate.value;
      final endDate = controller.endDate.value;

      return Row(
        children: [
          Expanded(
            flex: 50,
            child: GestureDetector(
              onTap: () => controller.startDateCalender(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: buildCommonText(
                        startDate != null
                            ? DateFormat("MM/yyyy").format(startDate)
                            : "Start Date",
                      ),
                    ),
                    Icon(Icons.calendar_month),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(width: 10.w),

          Expanded(
            flex: 50,
            child: GestureDetector(
              onTap: () => controller.endDateCalender(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: buildCommonText(
                        endDate != null
                            ? DateFormat("MM/yyyy").format(endDate)
                            : "End Date",
                      ),
                    ),
                    Icon(Icons.calendar_month),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

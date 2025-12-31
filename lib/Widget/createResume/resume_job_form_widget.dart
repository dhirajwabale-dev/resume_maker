import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Utility/app_color.dart';
import '../../Utility/utils.dart';

class ResumeJobFormWidget extends StatelessWidget {
  ResumeJobFormWidget({super.key});

  final controller = Get.find<CreateResumeController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCommonText(
            "Add details about your work experience",
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
                  label: "Job Title",
                  textcontroller: controller.jobTitleController.value,
                ),
                _textField(
                  label: "Employer",
                  textcontroller: controller.employerController.value,
                ),
                _textField(
                  label: "City",
                  textcontroller: controller.employerCityController.value,
                ),

                buildCommonText("Details"),
                _buildDetailsTextField(
                  textController: controller.detailsController.value,
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
                onPressed: () => controller.clickOnJobAdd(),
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
    // required Function(String) onChanged,
    required TextEditingController textcontroller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: textcontroller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        //onChanged: onChanged,
      ),
    );
  }

  Widget _buildFromDateContainer(BuildContext context) {
    return Obx(() {
      final fromDate = controller.fromDate.value;
      final toDate = controller.toDate.value;

      return Row(
        children: [
          Expanded(
            flex: 50,
            child: GestureDetector(
              onTap: () => controller.fromDateCalender(context),
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
                        fromDate != null
                            ? DateFormat("MM/yyyy").format(fromDate)
                            : "From Date",
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
              onTap: () => controller.toDateCalender(context),
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
                        toDate != null
                            ? DateFormat("MM/yyyy").format(toDate)
                            : "To Date",
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

  Widget _buildDetailsTextField({
    required TextEditingController textController,
  }) {
    return TextFormField(
      controller: textController,
      maxLines: 5,
      decoration: InputDecoration(labelText: "Details"),
    );
  }
}

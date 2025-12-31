import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Utility/app_color.dart';
import '../../Utility/utils.dart';

class ResumeLangFormWidget extends StatelessWidget {
  ResumeLangFormWidget({super.key});

  final controller = Get.find<CreateResumeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCommonText(
            "Language",
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
                  label: "Langauge",
                  textController: controller.languageController.value,
                ),

                SizedBox(height: 12.h),

                Row(
                  children: [
                    buildCommonText(
                      "Proficiency : ",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),

                    Obx(() {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () =>
                                controller.addLangProficiency(index + 1),
                            child: Icon(
                              (index) < controller.langProCount.value
                                  ? Icons.circle
                                  : Icons.circle_outlined,
                            ),
                          );
                        }),
                      );
                    }),
                  ],
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
                onPressed: () => controller.clickOnLangAdd(),
                child: Text("ADD"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField({
    required String label,
    //required Function(String) onChanged,
    required TextEditingController textController,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(labelText: label),
        //onChanged: onChanged,
      ),
    );
  }
}

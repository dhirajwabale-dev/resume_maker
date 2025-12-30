import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Utility/app_color.dart';
import '../../Utility/utils.dart';

class ResumeSkillsWidget extends StatelessWidget {
  const ResumeSkillsWidget({
    super.key,
    required this.controller,
    this.flag = 0,
  });

  final CreateResumeController controller;
  //If This flag ==0 then Initial Theme
  final int? flag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCommonText(
            "Skills",
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
                //Summary textField for flag 0
                if (flag == 0) ...[
                  _textField(
                    label: "Skills",
                    textController: controller.skillController.value,
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
                              onTap: () => controller.addProficiency(index + 1),
                              child: Icon(
                                (index) < controller.proficiencyCount.value
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

                //Summary textField for flag 1
                if (flag == 1) ...[
                  buildCommonText("Technology"),
                  _textField(
                    label: "Skills",
                    textController: controller.skillController.value,
                  ),

                  SizedBox(height: 10.h),

                  buildCommonText("Tools"),
                  _textField(
                    label: "Tools",
                    textController: controller.toolController.value,
                  ),

                  SizedBox(height: 10.h),
                  buildCommonText("Other Skills"),
                  _textField(
                    label: "other skills",
                    textController: controller.otherSkillsController.value,
                  ),
                ],
              ],
            ),
          ),

          SizedBox(height: 12.h),
          if (flag == 0)
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => controller.clickOnSkillAdd(),
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
}

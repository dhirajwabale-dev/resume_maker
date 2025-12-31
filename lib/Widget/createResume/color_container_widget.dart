import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resume_maker/Utility/utils.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Utility/app_color.dart';

class ColorContainerWidget extends StatelessWidget {
  ColorContainerWidget({super.key});

  final controller = Get.find<CreateResumeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCommonText(
              "Select Color",
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.selectionOfRed();
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.red,
                    child: Center(
                      child: controller.isRedClick.value
                          ? Icon(Icons.check)
                          : Container(),
                    ),
                  ),
                ),

                SizedBox(width: 8),
                GestureDetector(
                  onTap: controller.selectionOfGreen,
                  child: CircleAvatar(
                    backgroundColor: AppColors.green,
                    child: Center(
                      child: controller.isGreenClick.value
                          ? Icon(Icons.check)
                          : Container(),
                    ),
                  ),
                ),

                SizedBox(width: 8),
                GestureDetector(
                  onTap: controller.selectionOfBlue,
                  child: CircleAvatar(
                    backgroundColor: AppColors.selectBlue,
                    child: Center(
                      child: controller.isBlueClick.value
                          ? Icon(Icons.check)
                          : Container(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: controller.selectionOfPurple,
                  child: CircleAvatar(
                    backgroundColor: AppColors.purple,
                    child: Center(
                      child: controller.isPurpleClick.value
                          ? Icon(Icons.check)
                          : Container(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: controller.selectionOfYellow,
                  child: CircleAvatar(
                    backgroundColor: AppColors.yellow,
                    child: Center(
                      child: controller.isYellowClick.value
                          ? Icon(Icons.check)
                          : Container(),
                    ),
                  ),
                ),

                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    controller.selectionOfPink();
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.pink,
                    child: Center(
                      child: controller.isPinkClick.value
                          ? Icon(Icons.check)
                          : Container(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: controller.selectionOfGrey,
                  child: CircleAvatar(
                    backgroundColor: AppColors.blueGrey,
                    child: Center(
                      child: controller.isGreyClick.value
                          ? Icon(Icons.check)
                          : Container(),
                    ),
                  ),
                ),

                SizedBox(width: 8),
                GestureDetector(
                  onTap: controller.selectionOfOrange,
                  child: CircleAvatar(
                    backgroundColor: AppColors.orange,
                    child: Center(
                      child: controller.isOrangeClick.value
                          ? Icon(Icons.check)
                          : Container(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

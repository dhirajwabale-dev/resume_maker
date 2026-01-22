import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Utility/utils.dart';
import 'color_container_widget.dart';
import 'first_template_widget.dart';
import 'initial_template_widget.dart';
import 'second_template_widget.dart';
import 'third_template_widget.dart';

class ResumePreview extends StatelessWidget {
  const ResumePreview({
    super.key,
    required this.controller,
    required this.flag,
  });

  final CreateResumeController controller;
  final int flag;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              children: [
                Expanded(
                  child: buildCommonText(
                    "Select Theme",
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => buildTemplateDialog(context, c: controller),
                  child: Text("Select templates"),
                ),
              ],
            ),
          ),

          //Color Container
          ColorContainerWidget(),

          SizedBox(height: 12.h),

          Obx(() {
            return buildContainerItem();
          }),
        ],
      ),
    );
  }

  Widget buildContainerItem() {
    final selectedIndex = controller.selectedTempIndex.value;

    switch (selectedIndex) {
      case 0:
        return FirstTemplateWidget(controller: controller, flag: flag);

      case 1:
        return SecondTemplateWidget(controller: controller, flag: flag);

      case 2:
        return ThirdTemplateWidget(controller: controller, flag: flag);

      default:
        return InitialTemplateWidget(controller: controller, flag: flag);
    }
  }
}

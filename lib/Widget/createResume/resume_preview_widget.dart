import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resume_maker/Utility/utils.dart';
import 'package:resume_maker/Widget/createResume/first_template_widget.dart';
import 'package:resume_maker/Widget/createResume/second_template_widget.dart';
import 'package:resume_maker/Widget/createResume/third_template_widget.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Services/responsive_ui.dart';
import 'color_container_widget.dart';
import 'initial_template_widget.dart';

class ResumePreview extends StatelessWidget {
  const ResumePreview({super.key, required this.controller});

  final CreateResumeController controller;
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUi.isMobile(context);
    return Column(
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
        ColorContainerWidget(controller: controller),

        SizedBox(height: 12.h),

        Obx(() {
          return //Resume Data View
          isMobile ? buildContainerItem() : buildContainerItem();
        }),
      ],
    );
  }

  Widget buildContainerItem() {
    final selectedIndex = controller.selectedTempIndex.value;

    switch (selectedIndex) {
      case 0:
        return FirstTemplateWidget(controller: controller);

      case 1:
        return SecondTemplateWidget(controller: controller);

      case 2:
        return ThirdTemplateWidget(controller: controller);

      default:
        return InitialTemplateWidget(controller: controller);
    }
  }
}

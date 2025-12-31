import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Controller/create_resume_controller.dart';
import '../Widget/common_app_bar_widget.dart';
import '../Widget/createResume/resume_preview_widget.dart';
import '../Widget/general_safe_area_widget.dart';

class PreviewScreen extends StatelessWidget {
  PreviewScreen({super.key});

  final controller = Get.find<CreateResumeController>();

  @override
  Widget build(BuildContext context) {
    return GeneralSafeAreaWidget(
      child: Scaffold(
        appBar: commonAppBar(),
        body: Column(
          children: [
            //Resume Preview
            Expanded(child: SingleChildScrollView(child: ResumePreview())),
            Padding(
              padding: EdgeInsets.all(10.r),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => controller.createPdf(),
                      label: Text("Download"),
                      icon: Icon(Icons.download),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

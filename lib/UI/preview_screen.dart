import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Controller/create_resume_controller.dart';
import '../Widget/common_app_bar_widget.dart';
import '../Widget/createResume/resume_preview_widget.dart';
import '../Widget/general_safe_area_widget.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, required this.controller});

  final CreateResumeController controller;

  @override
  Widget build(BuildContext context) {
    return GeneralSafeAreaWidget(
      child: Scaffold(
        appBar: commonAppBar(),
        body: Column(
          children: [
            //Resume Preview
            Expanded(
              child: SingleChildScrollView(
                child: ResumePreview(controller: controller),
              ),
            ),
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

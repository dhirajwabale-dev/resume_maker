import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Controller/create_resume_controller.dart';
import '../Widget/common_app_bar_widget.dart';
import '../Widget/createResume/resume_preview_widget.dart';
import '../Widget/general_safe_area_widget.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({
    super.key,
    required this.controller,
    required this.flag,
  });

  final CreateResumeController controller;
  final int flag;

  @override
  Widget build(BuildContext context) {
    return GeneralSafeAreaWidget(
      child: Scaffold(
        appBar: commonAppBar(),
        body: Column(
          children: [
            //Resume Preview
            Expanded(
              child: ResumePreview(controller: controller, flag: flag),
            ),
            Padding(
              padding: EdgeInsets.all(10.r),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => controller.createPdf(flag),
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

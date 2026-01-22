import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContBackBtnWidget extends StatelessWidget {
  const ContBackBtnWidget({
    super.key,
    required this.onBackPress,
    required this.onContinuePress,
    required this.isPreview,
    required this.onPreviewPress,
  });

  final bool isPreview;
  final Function() onBackPress;
  final Function() onContinuePress;
  final Function() onPreviewPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(onPressed: onBackPress, child: Text("Back")),

          (isPreview)
              ? ElevatedButton(
                  onPressed: onPreviewPress,
                  child: Text("preview"),
                )
              : ElevatedButton(
                  onPressed: onContinuePress,
                  child: Text("Continue"),
                ),
        ],
      ),
    );
  }
}

/*
 Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 10.h,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        OutlinedButton(
                                          onPressed: controller.clickOnBack,
                                          child: Text("Back"),
                                        ),

                                        (controller.isFinalSubmit.value)
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  Get.to(
                                                    () => PreviewScreen(
                                                      controller: controller,
                                                      flag: flag,
                                                    ),
                                                  );
                                                },
                                                child: Text("preview"),
                                              )
                                            : ElevatedButton(
                                                onPressed: () => controller
                                                    .clickOnContinue(flag),
                                                child: Text("Continue"),
                                              ),
                                      ],
                                    ),
                                  ),
*/

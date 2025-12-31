import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:resume_maker/Services/validation.dart';

import '../../Controller/create_resume_controller.dart';
import '../../Utility/app_color.dart';
import '../../Utility/utils.dart';

class ResumeHeaderFormWidget extends StatelessWidget with Validation {
  ResumeHeaderFormWidget({super.key, this.flag = 0});

  final int? flag;

  final controller = Get.find<CreateResumeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCommonText(
              "Let's start with your header",

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
                    label: "First Name",
                    contro: controller.firstNameController.value,
                  ),

                  _textField(
                    label: "Last Name",
                    contro: controller.lastNameController.value,
                  ),
                  _textField(
                    label: "Address",
                    contro: controller.addressController.value,
                  ),

                  if (flag == 1)
                    _textField(
                      label: "Designation",
                      contro: controller.userDesignationController.value,
                    ),

                  pincodeTextField(),

                  mobileTextField(),

                  emailTextField(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
    required TextEditingController contro,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: contro,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget pincodeTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Form(
        key: controller.pincodeFormKey,
        child: TextFormField(
          controller: controller.pincodeController.value,
          decoration: InputDecoration(labelText: "Pin code"),
          validator: (value) => pincodeValidation(value),
          onChanged: (value) {
            controller.pincodeFormKey.currentState?.validate();
          },
        ),
      ),
    );
  }

  Widget mobileTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Form(
        key: controller.mobileFormKey,
        child: TextFormField(
          controller: controller.mobileController.value,
          decoration: InputDecoration(labelText: "Mobile Number"),
          validator: (value) => mobileValidation(value),
          onChanged: (value) {
            controller.mobileFormKey.currentState?.validate();
          },
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Form(
        key: controller.emailFormKey,
        child: TextFormField(
          controller: controller.emailController.value,
          decoration: InputDecoration(labelText: "Email Id"),
          validator: (value) => emailValidation(value),
          onChanged: (value) {
            controller.emailFormKey.currentState?.validate();
          },
        ),
      ),
    );
  }
}

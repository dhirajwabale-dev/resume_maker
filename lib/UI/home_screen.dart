import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Routes/routes_name.dart';
import '../Services/responsive_ui.dart';
import '../Utility/arguments.dart';
import '../Utility/btn_name_string.dart';
import '../Utility/string_constant.dart';
import '../Utility/utils.dart';
import '../Widget/bottom_bar_widget.dart';
import '../Widget/common_app_bar_widget.dart';
import '../Widget/general_safe_area_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralSafeAreaWidget(
      child: Scaffold(
        appBar: commonAppBar(flag: "2"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: (Get.width / 1.2).w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14.h),
                    //Initial Data
                    _buildInitialData(context),

                    //Middle Widget
                    _buildMiddleWidget(context),

                    SizedBox(height: 20.h),

                    //Description Of Project
                    buildCommonText(
                      StringConstant.projectDesc,
                      fontSize: 16.sp,
                    ),

                    SizedBox(height: 10.h),

                    buildCommonText(
                      StringConstant.keyFeature,
                      fontSize: 16.dg,
                      fontWeight: FontWeight.bold,
                    ),

                    buildCommonText(
                      StringConstant.feature,

                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              //Bottom Bar Widget
              BottomBarWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialData(BuildContext context) {
    final isMobile = ResponsiveUi.isMobile(context);
    return isMobile
        ? Column(
            children: [
              commonFirstText(),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () => Get.toNamed(
                  RoutesName.createResumeScreen,
                  arguments: CreateResumeArgument(flag: 0),
                ),
                child: Text(BtnNameString.createResume),
              ),

              SizedBox(height: 12.h),

              ElevatedButton(
                onPressed: () => Get.toNamed(
                  RoutesName.createResumeScreen,
                  arguments: CreateResumeArgument(flag: 1),
                ),
                child: Text(BtnNameString.fresherResume),
              ),

              SizedBox(height: 10.h),

              _buildCarouselSlider(),
            ],
          )
        : Row(
            children: [
              Expanded(
                flex: 50,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonFirstText(),
                    SizedBox(height: 20.h),

                    //Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => Get.toNamed(
                            RoutesName.createResumeScreen,
                            arguments: CreateResumeArgument(flag: 0),
                          ),
                          child: Text(BtnNameString.createResume),
                        ),

                        SizedBox(width: 8.w),

                        ElevatedButton(
                          onPressed: () => Get.toNamed(
                            RoutesName.createResumeScreen,
                            arguments: CreateResumeArgument(flag: 1),
                          ),
                          child: Text(BtnNameString.fresherResume),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //CarouselSlider
              Expanded(flex: 50, child: _buildCarouselSlider()),
            ],
          );
  }

  Widget _buildMiddleWidget(BuildContext context) {
    final isMobile = ResponsiveUi.isMobile(context);
    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              _buildFirstColumn(),

              SizedBox(height: 12.h),

              _buildCommonSecColumn(),

              SizedBox(height: 12.h),

              _buildThirdColumn(),
            ],
          )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 30, child: _buildFirstColumn()),

                SizedBox(width: 10.w),

                Expanded(flex: 30, child: _buildCommonSecColumn()),

                SizedBox(width: 10.w),

                Expanded(flex: 30, child: _buildThirdColumn()),
              ],
            ),
          );
  }

  Widget commonFirstText() {
    return buildCommonText(
      StringConstant.indiaTopResume,
      fontWeight: FontWeight.bold,
      fontSize: 32.sp,
    );
  }

  Widget _buildCarouselSlider() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: CarouselSlider(
        items: imageList.map((item) {
          return SizedBox(
            height: 400.h,
            width: 400.w,
            child: Image.asset(
              item,
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: 400.h,
          initialPage: 0,
          viewportFraction: 1,
          enlargeCenterPage: false,
          enableInfiniteScroll: true,
          autoPlay: true,
        ),
      ),
    );
  }

  Widget _buildFirstColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.camera_alt_sharp, size: 32.sp),

        SizedBox(height: 12.h),

        buildCommonText(
          StringConstant.recruiterApproved,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),

        SizedBox(height: 8.h),

        buildCommonText(
          StringConstant.recruiterApprovedDesc,
          color: Colors.black54,
        ),
      ],
    );
  }

  Widget _buildCommonSecColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.watch_later_outlined, size: 32.sp),

        SizedBox(height: 12.h),

        buildCommonText(
          StringConstant.finishInMin,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),

        buildCommonText(StringConstant.finishInMinDesc, color: Colors.black54),
      ],
    );
  }

  Widget _buildThirdColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.badge_sharp, size: 32.sp),

        SizedBox(height: 12.h),

        buildCommonText(
          StringConstant.landInterview,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),

        buildCommonText(
          StringConstant.landInterviewDesc,
          color: Colors.black54,
        ),
      ],
    );
  }
}

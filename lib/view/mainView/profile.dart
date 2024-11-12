import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../core/util/color.dart';
import '../../core/util/reusableWidget.dart';
import '../../core/util/textStyle.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>with TickerProviderStateMixin {


  bool isLightMode = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  bool isLoading =false;
  @override
  void initState() {

    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return OverlayLoaderWithAppIcon(
        isLoading: isLoading,
        overlayBackgroundColor: AppColor.black40,
        circularProgressColor: AppColor.primary100,
        appIconSize: 60.h,
        appIcon: Image.asset("assets/image/images_png/Loader_icon.png"),
        child: Scaffold(body: appBodyDesign(getBody())));
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
            child: SizedBox(
                height: 52.h,
                child: CustomAppBar(title: "Personal Information")),
          ),
          Gap(20.h),
          Container(
            height: 668.72.h,
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 24.w),
            decoration: BoxDecoration(
              color: AppColor.primary20,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r)),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    List<dynamic> response =
                    await showCupertinoModalBottomSheet(
                        topRadius: Radius.circular(20.r),
                        context: context,
                        backgroundColor: AppColor.primary20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24.r),
                              topLeft: Radius.circular(24.r)),
                        ),
                        builder: (context) =>
                            SizedBox(
                                height: 183.h,
                                child: CameraOption(
                                  hasCamera: true,
                                )));
                    if (response[0] != null) {
                      print(response[0]);
                      setState(() {
                        selectedImage = response[0];
                      });
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColor.black0, width: 1.5.w),
                          image: DecorationImage(image: imageValue("assets/images/tempImage.png")),
                        ),

                      ),
                      Positioned(
                          left: 50.w,
                          bottom: -1.h,
                          child: Container(
                              height: 24.h,
                              width: 24.w,
                              padding: EdgeInsets.all(5.h),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.primary100,
                                  border: Border.all(
                                      color: AppColor.primary100,
                                      width: 1.5.w)),
                              child: Image.asset(
                                  "assets/images/fi_camera.png")))
                    ],
                  ),
                ),
                Gap(32.h),
                SizedBox(
                  height: 88.h,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 88.h,
                        width: 157.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "First Name",
                              style: CustomTextStyle.kTxtBold.copyWith(
                                  color: AppColor.black100,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                            Gap(2.h),
                            SizedBox(
                                height: 58.h,
                                child: CustomizedTextField(
                                    readOnly: true,
                                    textEditingController: firstName,
                                    isProfile: true)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 88.h,
                        width: 157.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Name",
                              style: CustomTextStyle.kTxtBold.copyWith(
                                  color: AppColor.black100,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                            Gap(2.h),
                            SizedBox(
                                height: 58.h,
                                child: CustomizedTextField(
                                    readOnly: true,
                                    textEditingController: lastName,
                                    isProfile: true)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(14.h),
                SizedBox(
                  height: 88.h,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 88.h,
                        width: 157.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Middle Name",
                              style: CustomTextStyle.kTxtBold.copyWith(
                                  color: AppColor.black100,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                            Gap(2.h),
                            SizedBox(
                                height: 58.h,
                                child: CustomizedTextField(
                                    readOnly: true,
                                    textEditingController: middleName,
                                    isProfile: true)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 88.h,
                        width: 157.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "User Name",
                              style: CustomTextStyle.kTxtBold.copyWith(
                                  color: AppColor.black100,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                            Gap(2.h),
                            SizedBox(
                                height: 58.h,
                                child: CustomizedTextField(
                                    readOnly: true,
                                    textEditingController: userName,
                                    isProfile: true)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(14.h),
                SizedBox(
                  height: 88.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Address",
                        style: CustomTextStyle.kTxtBold.copyWith(
                            color: AppColor.black100,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp),
                      ),
                      Gap(2.h),
                      SizedBox(
                          height: 58.h,
                          child: CustomizedTextField(
                              readOnly: true,
                              textEditingController: emailAddress,
                              isProfile: true)),
                    ],
                  ),
                ),

                Gap(24.h),
                CustomButton(
                  onTap: () {
                    if (checkIfFieldsAreFilled()) {

                    } else {
                      null;
                    }
                  },
                  buttonText: "Save Changes",
                  textColor: AppColor.black0,
                  buttonColor: checkIfFieldsAreFilled()
                      ? AppColor.primary100
                      : AppColor.primary40,
                  borderRadius: 8.r,
                  height: 58.h,
                  textfontSize: 16.sp,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  File? selectedImage;
  ImageProvider<Object> imageValue(url) {

    return Image
        .network(url!, fit: BoxFit.cover,
    )
        .image;
  }
  bool checkIfFieldsAreFilled() {
    if (firstName.text.isEmpty ||
        lastName.text.isEmpty ||
        middleName.text.isEmpty ||
        userName.text.isEmpty ||
        emailAddress.text.isEmpty ||
        phoneNumber.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}




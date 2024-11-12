import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:tezda/core/data/models/response/loginResponse.dart';

import '../../core/data/models/request/loginRequest.dart';
import '../../core/data/models/request/signUP.dart';
import '../../core/data/models/response/defaultResponse.dart';
import '../../core/providers/onBoardingProvider/onboardingProvider.dart';
import '../../core/util/AppUtill.dart';
import '../../core/util/color.dart';
import '../../core/util/constant.dart';
import '../../core/util/customValidatot.dart';
import '../../core/util/reusableWidget.dart';
import '../../core/util/textStyle.dart';
import '../bottomNav.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> with TickerProviderStateMixin {

  late AnimationController _slideController;
  late AnimationController _slideControllerTop;

  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideAnimationTop;
  bool isCompleted =false;
  CustomValidator customValidator = CustomValidator();
  @override
  void initState() {
  super.initState();

  // Slide Animation
  _slideController = AnimationController(
  vsync: this,
  duration: Duration(milliseconds: 600),
  );

  _slideControllerTop = AnimationController(
  vsync: this,
  duration: Duration(milliseconds: 600),
  );

  _slideAnimationTop = Tween<Offset>(
  begin: Offset(1.0, 0.0),
  end: Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
  parent: _slideControllerTop,
  curve: Curves.easeInOut,
  ));

  _slideAnimation = Tween<Offset>(
  begin: Offset(0.0, 1.0),
  end: Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
  parent: _slideController,
  curve: Curves.easeInOut,
  ));

  _slideController.forward();
  _slideControllerTop.forward();
  }
  String emailErrorMessage ="";
  String nameErrorMessage ="";
  bool isPasswordVisible = false;
  bool isLoading = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final value = ref.watch(onBoardingProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: OverlayLoaderWithAppIcon(
        isLoading:isLoading,
        overlayBackgroundColor: AppColor.black40,
        circularProgressColor: AppColor.primary100,
        appIconSize: 20.h,
        appIcon: CircularProgressIndicator(),
        child: Scaffold(
          body: appBodyDesign(getBody(value)),
        ),
      ),
    );
  }


  getBody(value) {

    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: _slideAnimationTop,
            child: Padding(
              padding: EdgeInsets.only(top: 52.h, left: 20.w, bottom: 17.h),
              child: SizedBox(
                  height: 52.h,
                  child: CustomAppBar(title: "Sign In")),
            ),
          ),
          Gap(20.h),
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              height: 668.72.h,
              padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColor.primary20,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Email", style: CustomTextStyle.kTxtBold.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp
                    ),),
                    height8,
                    CustomizedTextField(
                        textEditingController: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintTxt: "Enter email address",
                        onTap: () {},
                        error: emailErrorMessage,
                        onChanged: (value) {
                          setState(() {
                            emailErrorMessage =  customValidator.validateEmail(value)??"";
                          });
                        }
                    ),

                    height12,
                    Text("Password", style: CustomTextStyle.kTxtMedium.copyWith(
                        color: AppColor.black100,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp
                    ),),
                    height8,
                    CustomizedTextField(
                      textEditingController: passwordController,
                      onChanged: (value){
                        setState(() {
                         // passwordErrorMessage = customValidator.validatePassword(value)??"";
                        });

                      },
                      hintTxt: "Enter password",
                      keyboardType: TextInputType.number,
                      //error: passwordErrorMessage,
                      surffixWidget: GestureDetector(
                        onTap: (){
                          setState(() {

                          });
                        },
                        child:Padding(
                          padding:  EdgeInsets.only(right: 16.w),
                          child:  isPasswordVisible? Icon(Icons.visibility_off_outlined,):Icon(Icons.visibility_outlined),
                        ),
                      ),
                      obsec: isPasswordVisible,
                      onTap: (){
                        setState(() {
                          isPasswordVisible=!isPasswordVisible;
                        });
                      },
                      isTouched: isPasswordVisible,
                    ),

                    height45,
                    CustomButton(onTap: () async {
                      setState(() {
                        isLoading =true;
                      });
                      if (emailController.text.isNotEmpty&&passwordController.text.isNotEmpty) {
                        final productData = LoginRequest(
                            email:emailController.text,
                            password: passwordController.text,
                        );
                        final response= await ref.read(onBoardingProvider.notifier).logUserIn(productData);
                        if(response is LoginResponse){
                          Get.offAll(BottomNav(), predicate: (route) => false);

                        }else{
                          setState(() {
                            isLoading =false;
                          });
                          DefaultErrorFormat error = response as DefaultErrorFormat;
                          AppUtils.showSnack(error.message[0], context);
                        }
                      } else {
                        setState(() {
                          isLoading =false;
                        });
                        AppUtils.showInfoSnack(
                            "Please no field should be empty", context);

                      }
                    },
                      buttonText: "Submit",
                      textColor: AppColor.black0,
                      buttonColor:
                      AppColor.primary100,
                      borderRadius: 8.r,
                      height: 58.h,
                      textfontSize: 16.sp,)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

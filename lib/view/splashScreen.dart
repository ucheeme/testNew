import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/navigation/route/pages.dart';
import '../core/util/color.dart';
import '../core/util/constant.dart';
import '../core/util/reusableWidget.dart';
import '../core/util/textStyle.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>  with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _slideControllerB;
  late AnimationController _scaleController;
  late AnimationController _moveController;
  late AnimationController _containerController;

  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideAnimationB;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _moveAnimation;
  late Animation<Size> _containerSizeAnimation;

  @override
  void initState() {
    super.initState();
    _slideControllerB = AnimationController(
      vsync: this,
      // duration: Duration(milliseconds: 600),
      duration: Duration(milliseconds: 600),
    );
    // Slide Animation
    _slideController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Scale Animation
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_scaleController);

    // Move Animation for the Image
    _moveController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    // Slide animation from bottom
    _slideAnimationB = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideControllerB,
      curve: Curves.easeInOut,
    ));


    _moveAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, -0.1),
    ).animate(CurvedAnimation(
      parent: _moveController,
      curve: Curves.easeInOut,
    ));

    // Size Animation for the Second Container
    _containerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _containerSizeAnimation = Tween<Size>(
      begin: Size(0.w, 50.h),
      end: Size(Get.width, 388.72.h),
    ).animate(CurvedAnimation(
      parent: _containerController,
      curve: Curves.easeInOut,
    ));

    // Start the animations
    _slideController.forward().then((_) {
      _scaleController.forward().then((_) {
        _scaleController.reverse().then((_) {
          Future.delayed(Duration(seconds: 1), () {
            _moveController.forward();
            _containerController.forward();
            _slideControllerB.forward();
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    _moveController.dispose();
    _containerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primary100,AppColor.primary10],
            stops: [0.0, 1.0,],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h,),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: SlideTransition(
                    position:  _moveAnimation,
                    child: Container(
                      padding: EdgeInsets.only(left: 78.w,right: 78.w,top: 170.h),
                      child: Center(
                        child: Image.asset(tezdaLogo,height: 206.h,),
                      ),
                    ),
                  ),
                ),
                height30,
                SlideTransition(

                  child: Container(

                    height: 400.h,
                    decoration: BoxDecoration(
                      color: AppColor.primary20,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r),topRight: Radius.circular(30.r)),
                    ),
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          height40,
                          SizedBox(
                            height: 89.h,
                            width: 314.w,
                            child: Text(
                                "Enhanced Visualization",
                                textAlign: TextAlign.center,
                                style: CustomTextStyle.kTxtBold.copyWith(
                                    color: AppColor.black100,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 32.sp
                                )
                            ),
                          ),
                          Gap(20.h),
                          SizedBox(
                            height: 80.h,
                            width: 314.w,
                            child: Text(
                              "Users can virtually explore products and experience "
                                  "them in a lifelike environment, "
                                  "enabling them to visualize and assess items "
                                  "more accurately before making a purchase.",
                              textAlign: TextAlign.center,
                              style: CustomTextStyle.kTxtMedium.copyWith(
                                  color: AppColor.black100,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp
                              ),
                            ),
                          ),
                          height35,
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 24.w),
                            child: CustomButton(
                              height:58.h,
                              onTap: (){
                                Get.toNamed(Pages.signUp,);
                              }, buttonText: "Register Now",
                              textColor:AppColor.black0 ,
                              buttonColor: AppColor.primary100,borderRadius: 8.r,),
                          ),
                          height10,
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 24.w),
                            child: CustomButton(
                              height:58.h,
                              onTap: (){
                                Get.toNamed(Pages.login);
                                //Get.to(HomeScreen());
                              }, buttonText: "Already have an account",
                              textColor:AppColor.secondary100 ,
                              buttonColor: Colors.transparent,borderRadius: 8.r,),
                          ),
                          height40
                        ],
                      ),
                    ),
                  ),
                  position: _slideAnimationB,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //https://placeimg.com/640/480/any
  }
}

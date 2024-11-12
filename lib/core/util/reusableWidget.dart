import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tezda/core/util/textStyle.dart';

import 'color.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.onTap,
    this.borderRadius,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    required this.buttonText,
    this.height,
    this.width,
    this.textfontSize,
    this.icon,
    this.hasIcon,
    Key? key,
  }) : super(key: key);

  VoidCallback onTap;
  IconData? icon;
  Color? buttonColor;

  double? borderRadius;

  Color? textColor;

  String buttonText;
  bool? hasIcon;
  Color? borderColor;
  double? width;
  double? height;
  double? textfontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: buttonColor ?? Colors.white,
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius ?? 0)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                    visible: icon == null ? false : true,
                    child: Icon(
                      icon,
                      color: AppColor.black0,
                    )),
                Visibility(
                    visible: icon == null ? false : true, child: Gap(5.w)),
                Text(
                  buttonText,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w400,
                    fontSize: textfontSize ?? 16.sp,
                    fontFamily: 'Gilroy-Bold',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomizedTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? labeltxt;
  final String? hintTxt;
  final bool? obsec;
  bool? isConfirmPasswordMatch;
  final Widget? surffixWidget;
  final Function(String)? onChanged;
  final bool? readOnly;
  bool? isPasswordVisible;
  bool? isTouched = false;
  bool? isProfile = false;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final int? maxLines;
  final int? maxLength;
  final String? suffixText;
  final Widget? prefixWidget;
  final String? prefix;
  final Function()? onEditingComplete;
  String? error;
  final List<TextInputFormatter>? inputFormat;

  CustomizedTextField(
      {super.key,
        this.isProfile,
        this.prefix,
        this.prefixWidget,
        this.prefixIconConstraints,
        this.error,
        this.isConfirmPasswordMatch,
        this.onEditingComplete,
        this.maxLines,
        this.textEditingController,
        this.keyboardType,
        this.textInputAction,
        this.labeltxt,
        this.hintTxt,
        this.obsec,
        this.surffixWidget,
        this.inputFormat,
        this.readOnly,
        this.onChanged,
        this.validator,
        this.onTap,
        this.suffixIconConstraints,
        this.maxLength,
        this.suffixText,
        this.isTouched,
        this.isPasswordVisible});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autofocus: false,
            cursorColor: AppColor.primary100,
            obscureText: obsec ?? false,
            textCapitalization: TextCapitalization.sentences,
            controller: textEditingController,
            keyboardType: keyboardType,
            textAlignVertical: TextAlignVertical.center,
            readOnly: readOnly ?? false,
            onTap: onTap,
            textInputAction: textInputAction,
            inputFormatters: inputFormat ?? [],
            onEditingComplete: onEditingComplete,
            onChanged: onChanged,
            maxLength: maxLength,
            maxLines: maxLines ?? 1,
            validator: validator ??
                    (value) {
                  if (value!.isEmpty) {
                    return "Fill empty field";
                  } else {
                    return null;
                  }
                },
            style: CustomTextStyle.kTxtMedium.copyWith(
                color: AppColor.black100,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp),
            decoration: InputDecoration(
                hintText: hintTxt,
                contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                //hintTextDirection: TextDirection.LTR,
                isDense: true,
                suffixText: suffixText,
                prefixText: prefix,
                prefixIcon: prefixWidget ?? const SizedBox.shrink(),
                prefixIconConstraints: suffixIconConstraints ??
                    BoxConstraints(
                      minWidth: 19.w,
                      minHeight: 19.h,
                    ),
                suffixIconConstraints: suffixIconConstraints ??
                    BoxConstraints(minWidth: 19.w, minHeight: 19.h),
                suffixIcon: surffixWidget ?? const SizedBox.shrink(),
                fillColor: (isProfile == true)
                    ? AppColor.primary30
                    : isTouched == true
                    ? AppColor.primary20
                    : AppColor.black0,
                filled: true,
                // errorText: error,
                // errorStyle: CustomTextStyle.kTxtMedium.copyWith(
                //     color: (isConfirmPasswordMatch != null &&
                //             isConfirmPasswordMatch == false)
                //         ? AppColor.success100
                //         : AppColor.Error100,
                //     fontSize: 10.sp),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: AppColor.primary100, width: 0.5.w),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.black40),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                errorBorder: (error == null || error == "")
                    ? null
                    : OutlineInputBorder(
                  borderSide:
                  BorderSide(color: AppColor.Error100, width: 0.2.w),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.black80),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: AppColor.primary100, width: 0.5.w),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                hintStyle: CustomTextStyle.kTxtRegular.copyWith(
                    color: const Color(0xff79747E),
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp)),
          ),
          Gap(4.h),
          Text(
            error ?? "",
            style: CustomTextStyle.kTxtMedium.copyWith(
                color: (isConfirmPasswordMatch != null &&
                    isConfirmPasswordMatch == false)
                    ? AppColor.success100
                    : AppColor.Error100,
                fontSize: 10.sp),
          ),
        ],
      ),
    );
  }
}


class CustomAppBar extends StatelessWidget {
  String title;
  bool? isBottomNav;

  CustomAppBar({super.key, required this.title, this.isBottomNav});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Visibility(
            visible: isBottomNav == true ? false : true,
            child: Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.only(
                left: 4.w,
              ),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppColor.black0,
                  )),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColor.black0,
                size: 21,
              ),
            ),
          ),
        ),
        Gap(32.w),
        Text(
          title,
          style: CustomTextStyle.kTxtBold.copyWith(
              color: AppColor.black0,
              fontSize: 20.sp,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}

Container appBodyDesign(Widget bodyDesign) {
  return Container(
    width: Get.width,
    height: Get.height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColor.primary100, AppColor.primary10],
        stops: [
          0.0,
          1.0,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: bodyDesign,
  );
}

Future<dynamic> openBottomSheet(BuildContext context, Widget bottomScreen,
    {background = AppColor.black0}) {
  return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      backgroundColor: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(24.r), topLeft: Radius.circular(24.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: bottomScreen,
      ));
}

class CameraOption extends StatefulWidget {
  bool? hasCamera;
  CameraOption({super.key, this.hasCamera}) ;

  @override
  State<CameraOption> createState() => _CameraOptionState();
}

class _CameraOptionState extends State<CameraOption> {
  // CameraController? _controller;
  @override
  void initState() {

    super.initState();
  }

  bool isNotEmpty=false;
  List<String> images=[];

  File? _image;
  String? _base64Image;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    // final pickedFile = await picker.getImage(source: source);
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _resizeAndEncodeImage();
      }
    });


  }
  Future<void> _resizeAndEncodeImage() async {
    final fileSize = await _image!.length();

    if (fileSize > 300 * 1024) {
      // Image size is greater than 300KB, resize the image
      final tempDir = await getTemporaryDirectory();
      final tempPath = path.join(tempDir.path, path.basename(_image!.path));

      img.Image? image = img.decodeImage(_image!.readAsBytesSync());
      final resizedImage = img.copyResize(image!, width: 800);

      File(tempPath).writeAsBytesSync(img.encodeJpg(resizedImage));

      setState(() {
        _image = File(tempPath);
      });
      _cropImage(_image!,tempPath);
    } else {
      _cropImage(_image!,_image!.path);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    //  _controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: 220.h,
        color: AppColor.primary20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,

              height: 53.h,
              child: Padding(
                padding:  EdgeInsets.only(left: 20.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Image upload",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black100,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400
                      )
                  ),
                ),
              ),
            ),
            Gap(20.h),
            GestureDetector(
              onTap: () async {
                if(widget.hasCamera==null || widget.hasCamera==true){
                  await getImage(ImageSource.camera);
                }


              },
              child: Container(
                width: double.infinity,
                height: 54.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.h),
                  child:
                  Text("Take a picture with your camera",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black80,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                      )
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                getImage(ImageSource.gallery);
              },
              child: Container(
                width: double.infinity,
                height: 54.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.h),
                  child:
                  Text("Upload from device",
                      style: CustomTextStyle.kTxtMedium.copyWith(
                          color: AppColor.black80,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _cropImage(File imgFile,String path) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        uiSettings:[
          AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: AppColor.primary100,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
          ),
          IOSUiSettings(
            title: "Image Cropper",
            showCancelConfirmationDialog: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
          )
        ]
    );
    CircularProgressIndicator(color: AppColor.primary100,);
    if (croppedFile != null) {

      imageCache.clear();
      setState(() {
        _image= File(croppedFile.path);
        _base64Image = base64Encode(_image!.readAsBytesSync());
      });
      // reload();
    }else{
      setState(() {
        _image= File(imgFile.path);
        _base64Image = base64Encode(_image!.readAsBytesSync());
      });
    }
    Get.back(result:[ _image,_base64Image]);
  }
}

void requestCameraPermission(context) async {
  var status = await Permission.camera.request();
  if (status.isGranted) {

  } else if (status.isDenied) {
    final snackBar=SnackBar(
      content: Text('Camera permission denied!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else if (status.isPermanentlyDenied) {

  }
}

void checkCameraPermission(context) async {
  var status = await Permission.camera.status;
  if (status.isGranted) {

  } else {
    requestCameraPermission(context);
  }
}
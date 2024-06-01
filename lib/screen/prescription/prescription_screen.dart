// ignore_for_file: prefer_const_constructors, sort_child_properties_last, deprecated_member_use, avoid_print, unused_element, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmafast/controller/prescription_controller.dart';
import 'package:pharmafast/helpar/routes_helper.dart';
import 'package:pharmafast/model/fontfamily_model.dart';
import 'package:pharmafast/model/model.dart';
import 'package:pharmafast/utils/Colors.dart';

class PreScriptionScreen extends StatefulWidget {
  const PreScriptionScreen({super.key});

  @override
  State<PreScriptionScreen> createState() => _PreScriptionScreenState();
}

class _PreScriptionScreenState extends State<PreScriptionScreen> {
  PreScriptionControllre preScriptionControllre = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        backgroundColor: WhiteColor,
        elevation: 0,
        leading: BackButton(
          color: BlackColor,
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Upload Prescription".tr,
          maxLines: 1,
          style: TextStyle(
            color: BlackColor,
            fontFamily: FontFamily.gilroyBold,
            fontSize: 18,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          cameraAndGallarySheet();
        },
        child: Container(
          height: 50,
          width: Get.size.width,
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          alignment: Alignment.center,
          child: Text(
            "Upload Prescription".tr,
            style: TextStyle(
              color: WhiteColor,
              fontFamily: FontFamily.gilroyBold,
              fontSize: 17,
            ),
          ),
          decoration: BoxDecoration(
            gradient: gradient.btnGradient,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.size.height * 0.06,
              ),
              Container(
                height: 170,
                width: Get.size.width,
                alignment: Alignment.center,
                child: Image.asset("assets/prescription.png"),
              ),
              SizedBox(
                height: Get.size.height * 0.06,
              ),
              InkWell(
                onTap: () {
                  cameraAndGallarySheet();
                },
                child: Container(
                  width: Get.size.width,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/Group5346.png"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: 'Upload Prescription '.tr,
                                style: TextStyle(
                                  color: gradient.defoultColor,
                                  fontFamily: FontFamily.gilroyBold,
                                  fontSize: 17,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text:
                                        'and let usarrange your medicines for you'
                                            .tr,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: FontFamily.gilroyMedium,
                                      color: BlackColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 50,
                        width: Get.size.width,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(1),
                              child: Image.asset(
                                "assets/R.png",
                                height: 30,
                                width: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Get 15% off on medicines*".tr,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: BlackColor,
                                      fontFamily: FontFamily.gilroyBold,
                                      fontSize: 17,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "How it works".tr,
                                    style: TextStyle(
                                      color: greytext,
                                      fontFamily: FontFamily.gilroyMedium,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(
                          0.5,
                          0.5,
                        ),
                        blurRadius: 0.5,
                        spreadRadius: 0.5,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  priscriptionSheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/Rx.png",
                      height: 25,
                      width: 25,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "What is a valid Prescription ?".tr,
                      style: TextStyle(
                        fontFamily: FontFamily.gilroyBold,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future priscriptionSheet() {
    return Get.bottomSheet(
      Container(
        height: 380,
        width: Get.size.width,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "How prescription process work".tr,
              maxLines: 1,
              style: TextStyle(
                fontFamily: FontFamily.gilroyBold,
                fontSize: 22,
                color: BlackColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/bolt.png",
                            height: 22,
                            width: 22,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 90,
                            child: Text(
                              "Easy & Fast Process".tr,
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 13,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFf0eff4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/rocket-launch.png",
                            height: 22,
                            width: 22,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 90,
                            child: Text(
                              "Excusive Support".tr,
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 13,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFf0eff4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/door-closed.png",
                            height: 22,
                            width: 22,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 90,
                            child: Text(
                              "Delivery Doorstep".tr,
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 13,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFf0eff4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: model().prisList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      "${index + 1}. ${model().prisList[index]}",
                      style: TextStyle(
                        fontFamily: FontFamily.gilroyMedium,
                        fontSize: 15,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: WhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }

  Future cameraAndGallarySheet() {
    return Get.bottomSheet(
      Container(
        height: 150,
        width: Get.size.width,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                _openCamera(context);
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/camera-circle.png",
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "CAMERA".tr,
                      style: TextStyle(
                        fontFamily: FontFamily.gilroyBold,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _openGallery(context);
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/image-gallery.png",
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "GALLARY".tr,
                      style: TextStyle(
                        fontFamily: FontFamily.gilroyBold,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: WhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    List<XFile> images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      preScriptionControllre.path = [];
      for (var i = 0; i < images.length; i++) {
        preScriptionControllre.path.add(images[i].path);
      }
      Get.back();
      Get.toNamed(Routes.prescriptionDetails);
    }
    // final pickedFile =
    //     await ImagePicker().getImage(source: ImageSource.gallery);
    // print(pickedFile?.path.toString());
    // if (pickedFile != null) {
    //   path = pickedFile.path;
    //   setState(() {});
    //   File imageFile = File(path.toString());
    //   List<int> imageBytes = imageFile.readAsBytesSync();
    //   base64Image = base64Encode(imageBytes);
    //   setState(() {});
    // } else {
    //   print("Null Image");
    // }
  }

  void _openCamera(BuildContext context) async {
    // final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    print("=========--------${pickedFile?.path.toString()}");
    if (pickedFile != null) {
      preScriptionControllre.path = [];
      preScriptionControllre.path.add(pickedFile.path);
      setState(() {});
      Get.back();
      Get.toNamed(Routes.prescriptionDetails);
    } else {
      print("Null Image");
    }
  }
}

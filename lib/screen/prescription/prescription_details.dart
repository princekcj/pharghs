// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_field, prefer_final_fields, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, avoid_print, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmafast/controller/prescription_controller.dart';
import 'package:pharmafast/controller/stordata_controller.dart';
import 'package:pharmafast/helpar/routes_helper.dart';
import 'package:pharmafast/model/fontfamily_model.dart';
import 'package:pharmafast/utils/Colors.dart';
import 'package:pharmafast/utils/Custom_widget.dart';

class PrescriptionDetails extends StatefulWidget {
  const PrescriptionDetails({super.key});

  @override
  State<PrescriptionDetails> createState() => _PrescriptionDetailsState();
}

class _PrescriptionDetailsState extends State<PrescriptionDetails> {
  PreScriptionControllre preScriptionControllre = Get.find();
  StoreDataContoller storeDataContoller = Get.find();
  int _groupValue = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      preScriptionControllre.isOrderLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
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
        actions: [
          InkWell(
            onTap: () {
              cameraAndGallarySheet();
            },
            child: Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              child: Icon(Icons.add),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: gradient.btnGradient,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PreScriptionControllre>(builder: (context) {
        return InkWell(
          onTap: () {
            if (preScriptionControllre.isOrderLoading != true) {
              if (preScriptionControllre.path.isNotEmpty) {
                preScriptionControllre.setOrderLoading();
                preScriptionControllre.uploadPriscriptionOrder(
                    storeID:
                        storeDataContoller.storeDataInfo?.storeInfo.storeId);
              } else {
                showToastMessage("Please Upload Prescription".tr);
              }
            }
          },
          child: Container(
            height: 50,
            width: Get.size.width,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: Text(
              "Proceed".tr,
              style: TextStyle(
                fontFamily: FontFamily.gilroyBold,
                fontSize: 15,
                color: WhiteColor,
              ),
            ),
            decoration: !preScriptionControllre.isOrderLoading
                ? BoxDecoration(
                    gradient: gradient.btnGradient,
                    borderRadius: BorderRadius.circular(15),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue.shade300,
                  ),
          ),
        );
      }),
      body: GetBuilder<PreScriptionControllre>(builder: (context) {
        return !preScriptionControllre.isOrderLoading
            ? Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 15),
                            child: GridView.builder(
                              itemCount: preScriptionControllre.path.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 120,
                              ),
                              itemBuilder: (context, index) {
                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(
                                            preScriptionControllre.path[index],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: BlackColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned(
                                      top: -9,
                                      right: 3,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            preScriptionControllre.path.remove(
                                                preScriptionControllre
                                                    .path[index]);
                                          });
                                        },
                                        child: Container(
                                          height: 22,
                                          width: 22,
                                          padding: EdgeInsets.all(6),
                                          child: Image.asset(
                                            "assets/x.png",
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: gradient.btnGradient,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      }),
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
      for (var i = 0; i < images.length; i++) {
        preScriptionControllre.path.add(images[i].path);
      }
      setState(() {});
      Get.back();
      Get.toNamed(Routes.prescriptionDetails);
    }
  }

  void _openCamera(BuildContext context) async {
    // List<XFile> images = await ImagePicker().pickMultiImage();
    // if (images.isNotEmpty) {
    //   for (var i = 0; i < images.length; i++) {
    //     preScriptionControllre.path.add(images[i].path);
    //   }
    //   Get.back();
    //   Get.toNamed(Routes.prescriptionDetails);
    // }
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    print(pickedFile?.path.toString());
    if (pickedFile != null) {
      preScriptionControllre.path.add(pickedFile.path);
      setState(() {});
      Get.back();
      Get.toNamed(Routes.prescriptionDetails);
      // File imageFile = File(path.toString());
      // List<int> imageBytes = imageFile.readAsBytesSync();
      // base64Image = base64Encode(imageBytes);
    } else {
      print("Null Image");
    }
  }
}

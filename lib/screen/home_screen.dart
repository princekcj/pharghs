// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:pharmafast/Api/config.dart';
import 'package:pharmafast/Api/data_store.dart';
import 'package:pharmafast/controller/catdetails_controller.dart';
import 'package:pharmafast/controller/home_controller.dart';
import 'package:pharmafast/controller/notification_controller.dart';
import 'package:pharmafast/controller/stordata_controller.dart';
import 'package:pharmafast/helpar/routes_helper.dart';
import 'package:pharmafast/model/fontfamily_model.dart';
import 'package:pharmafast/utils/Colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var currency;
var wallat1;

class _HomeScreenState extends State<HomeScreen> {
  HomePageController homePageController = Get.find();
  CatDetailsController catDetailsController = Get.find();
  StoreDataContoller storeDataContoller = Get.find();
  NotificationController notificationController = Get.find();

  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return exit(0);
      },
      child: Scaffold(
        backgroundColor: bgcolor,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(
                Duration(seconds: 2),
                () {
                  homePageController.getHomeDataApi();
                },
              );
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: WhiteColor,
                  elevation: 0,
                  expandedHeight: 130,
                  floating: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SizedBox(
                      height: 220,
                      width: Get.width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Pharmafast".tr,
                                style: TextStyle(
                                  color: gradient.defoultColor,
                                  fontFamily: FontFamily.gilroyExtraBold,
                                  fontSize: 24,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  notificationController.getNotificationData();
                                  Get.toNamed(Routes.notificationScreen);
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  padding: EdgeInsets.all(9),
                                  child: Image.asset(
                                    "assets/bell-on.png",
                                    height: 20,
                                    width: 20,
                                    color: gradient.defoultColor,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFeef4ff),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.profileScreen);
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        alignment: Alignment.center,
                                        child: Text(
                                          getData.read("UserLogin")["name"][0],
                                          style: TextStyle(
                                            color: gradient.defoultColor,
                                            fontFamily: FontFamily.gilroyBold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: WhiteColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 20,
                                        width: 16,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          "assets/menu1.png",
                                        ),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xFFeef4ff),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.homeSearchScreen, arguments: {
                                "statusWiseSearch": true,
                              });
                            },
                            child: Container(
                              height: 45,
                              width: Get.size.width,
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/Search.png",
                                    height: 18,
                                    width: 18,
                                    color: Color(0xFF636268),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Search for stores".tr,
                                    style: TextStyle(
                                      color: greyColor,
                                      fontFamily: FontFamily.gilroyMedium,
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
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: GetBuilder<HomePageController>(builder: (context) {
                    return homePageController.isLoading
                        ? Column(
                            children: [
                              Container(
                                color: WhiteColor,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 210,
                                      width: Get.size.width,
                                      child: PageView.builder(
                                        itemCount: homePageController
                                            .homeInfo?.homeData.banlist.length,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: Get.size.width,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 15),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: FadeInImage.assetNetwork(
                                                fadeInCurve: Curves.easeInCirc,
                                                placeholder:
                                                    "assets/ezgif.com-crop.gif",

                                                placeholderCacheHeight: 210,
                                                placeholderFit: BoxFit.fill,
                                                // placeholderScale: 1.0,
                                                image:
                                                    "${Config.imageUrl}${homePageController.homeInfo?.homeData.banlist[index].img ?? ""}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              // image: DecorationImage(
                                              //   image: AssetImage(model().imgList[index]),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          );
                                        },
                                        onPageChanged: (value) {
                                          setState(() {
                                            selectIndex = value;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                      width: Get.size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ...List.generate(
                                              homePageController
                                                  .homeInfo!
                                                  .homeData
                                                  .banlist
                                                  .length, (index) {
                                            return Indicator(
                                              isActive: selectIndex == index
                                                  ? true
                                                  : false,
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "In the Spotlight".tr,
                                        style: TextStyle(
                                          color: BlackColor,
                                          fontFamily:
                                              FontFamily.gilroyExtraBold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Pharmafast we want you to explore".tr,
                                        style: TextStyle(
                                          color: BlackColor,
                                          fontFamily: FontFamily.gilroyMedium,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 320,
                                      width: Get.size.width,
                                      child:
                                          homePageController.homeInfo!.homeData
                                                  .spotlightStore.isNotEmpty
                                              ? ListView.builder(
                                                  itemCount: homePageController
                                                      .homeInfo
                                                      ?.homeData
                                                      .spotlightStore
                                                      .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () async {
                                                        catDetailsController
                                                                .strId =
                                                            homePageController
                                                                    .homeInfo
                                                                    ?.homeData
                                                                    .spotlightStore[
                                                                        index]
                                                                    .storeId ??
                                                                "";
                                                        await storeDataContoller
                                                            .getStoreData(
                                                          storeId:
                                                              homePageController
                                                                  .homeInfo
                                                                  ?.homeData
                                                                  .spotlightStore[
                                                                      index]
                                                                  .storeId,
                                                        );
                                                        save("changeIndex",
                                                            true);
                                                        homePageController
                                                            .isback = "1";
                                                        Get.toNamed(Routes
                                                            .bottombarProScreen);
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                height: 240,
                                                                width: 280,
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  child: FadeInImage
                                                                      .assetNetwork(
                                                                    fadeInCurve:
                                                                        Curves
                                                                            .easeInCirc,
                                                                    placeholder:
                                                                        "assets/ezgif.com-crop.gif",

                                                                    placeholderCacheHeight:
                                                                        240,
                                                                    placeholderCacheWidth:
                                                                        280,
                                                                    placeholderFit:
                                                                        BoxFit
                                                                            .fill,
                                                                    // placeholderScale: 1.0,
                                                                    image:
                                                                        "${Config.imageUrl}${homePageController.homeInfo?.homeData.spotlightStore[index].storeCover ?? ""}",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 10,
                                                                left: 10,
                                                                right: 10,
                                                                child:
                                                                    Container(
                                                                  width: 265,
                                                                  height: 70,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              20),
                                                                    ),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          AssetImage(
                                                                        "assets/Rectangle1.png",
                                                                      ),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 10,
                                                                        left:
                                                                            15),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              300,
                                                                          child:
                                                                              Text(
                                                                            homePageController.homeInfo?.homeData.spotlightStore[index].storeSloganTitle.toUpperCase() ??
                                                                                "",
                                                                            maxLines:
                                                                                1,
                                                                            style:
                                                                                TextStyle(
                                                                              color: WhiteColor,
                                                                              letterSpacing: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontFamily: FontFamily.gilroyLight,
                                                                              fontSize: 13,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              300,
                                                                          padding:
                                                                              EdgeInsets.only(right: 10),
                                                                          child:
                                                                              Text(
                                                                            homePageController.homeInfo?.homeData.spotlightStore[index].storeSlogan ??
                                                                                "",
                                                                            maxLines:
                                                                                2,
                                                                            style:
                                                                                TextStyle(
                                                                              color: WhiteColor,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontFamily: FontFamily.gilroyBold,
                                                                              fontSize: 17,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                bottom: 25,
                                                                left: 25,
                                                                child:
                                                                    Container(
                                                                  height: 60,
                                                                  width: 60,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    child: Image
                                                                        .network(
                                                                      "${Config.imageUrl}${homePageController.homeInfo?.homeData.spotlightStore[index].storeLogo ?? ""}",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        WhiteColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        Get.width *
                                                                            0.44,
                                                                    child: Text(
                                                                      homePageController
                                                                              .homeInfo
                                                                              ?.homeData
                                                                              .spotlightStore[index]
                                                                              .storeTitle ??
                                                                          "",
                                                                      maxLines:
                                                                          1,
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            BlackColor,
                                                                        fontFamily:
                                                                            FontFamily.gilroyExtraBold,
                                                                        fontSize:
                                                                            17,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        Get.width *
                                                                            0.44,
                                                                    child: Text(
                                                                      homePageController
                                                                              .homeInfo
                                                                              ?.homeData
                                                                              .spotlightStore[index]
                                                                              .storeCategoryName ??
                                                                          "",
                                                                      maxLines:
                                                                          1,
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            BlackColor,
                                                                        fontFamily:
                                                                            FontFamily.gilroyMedium,
                                                                        fontSize:
                                                                            16,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                height: 40,
                                                                width: 110,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "Shop now".tr,
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        WhiteColor,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .gilroyBold,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient: gradient
                                                                      .btnGradient,
                                                                  // color: Color(0xFF42955f),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(
                                                  height: 300,
                                                  width: Get.size.width,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "No medical store available \nin your area."
                                                        .tr,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          FontFamily.gilroyBold,
                                                      fontSize: 15,
                                                      color: BlackColor,
                                                    ),
                                                  ),
                                                ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              homePageController
                                      .homeInfo!.homeData.favlist.isNotEmpty
                                  ? Container(
                                      width: Get.size.width,
                                      color: WhiteColor,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text(
                                              "Your favorites".tr,
                                              style: TextStyle(
                                                color: BlackColor,
                                                fontFamily:
                                                    FontFamily.gilroyExtraBold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(left: 15),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Pharmafast your love".tr,
                                                  style: TextStyle(
                                                    color: BlackColor,
                                                    fontFamily:
                                                        FontFamily.gilroyMedium,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Image.asset(
                                                  "assets/heart.png",
                                                  height: 18,
                                                  width: 18,
                                                  color: gradient.defoultColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 150,
                                            width: Get.size.width,
                                            child: ListView.builder(
                                              itemCount: homePageController
                                                  .homeInfo
                                                  ?.homeData
                                                  .favlist
                                                  .length,
                                              physics: BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () async {
                                                    catDetailsController.strId =
                                                        homePageController
                                                                .homeInfo
                                                                ?.homeData
                                                                .favlist[index]
                                                                .storeId ??
                                                            "";
                                                    await storeDataContoller
                                                        .getStoreData(
                                                      storeId:
                                                          homePageController
                                                              .homeInfo
                                                              ?.homeData
                                                              .favlist[index]
                                                              .storeId,
                                                    );
                                                    Get.toNamed(Routes
                                                        .bottombarProScreen);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 110,
                                                        width: 90,
                                                        margin:
                                                            EdgeInsets.all(8),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: FadeInImage
                                                              .assetNetwork(
                                                            placeholderCacheHeight:
                                                                110,
                                                            placeholderCacheWidth:
                                                                90,
                                                            placeholderFit:
                                                                BoxFit.cover,
                                                            placeholder:
                                                                "assets/ezgif.com-crop.gif",
                                                            image:
                                                                "${Config.imageUrl}${homePageController.homeInfo?.homeData.favlist[index].storeCover ?? ""}",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          // image: DecorationImage(
                                                          //   image: AssetImage(
                                                          //       "assets/foodimg.jpg"),
                                                          //   fit: BoxFit.cover,
                                                          // ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 95,
                                                        child: Text(
                                                          homePageController
                                                                  .homeInfo
                                                                  ?.homeData
                                                                  .favlist[
                                                                      index]
                                                                  .storeTitle ??
                                                              "",
                                                          maxLines: 1,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: FontFamily
                                                                .gilroyMedium,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: 15,
                                                            color: BlackColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: WhiteColor,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Pharmafast by category".tr,
                                        style: TextStyle(
                                          color: BlackColor,
                                          fontFamily:
                                              FontFamily.gilroyExtraBold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    homePageController.homeInfo!.homeData
                                            .catlist.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: GridView.builder(
                                              itemCount: homePageController
                                                  .homeInfo
                                                  ?.homeData
                                                  .catlist
                                                  .length,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                mainAxisExtent: 130,
                                                crossAxisSpacing: 15,
                                                mainAxisSpacing: 15,
                                              ),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () async {
                                                    await catDetailsController
                                                        .getCatWiseData(
                                                            catId: homePageController
                                                                    .homeInfo
                                                                    ?.homeData
                                                                    .catlist[
                                                                        index]
                                                                    .id ??
                                                                "");
                                                    Get.toNamed(
                                                      Routes.categoryScreen,
                                                      arguments: {
                                                        "catName":
                                                            homePageController
                                                                    .homeInfo
                                                                    ?.homeData
                                                                    .catlist[
                                                                        index]
                                                                    .title ??
                                                                "",
                                                        "catImag":
                                                            homePageController
                                                                    .homeInfo
                                                                    ?.homeData
                                                                    .catlist[
                                                                        index]
                                                                    .cover ??
                                                                "",
                                                      },
                                                    );
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 80,
                                                        width: 70,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          child: FadeInImage
                                                              .assetNetwork(
                                                            fadeInCurve: Curves
                                                                .easeInCirc,
                                                            placeholder:
                                                                "assets/ezgif.com-crop.gif",

                                                            placeholderCacheHeight:
                                                                80,
                                                            placeholderCacheWidth:
                                                                90,
                                                            placeholderFit:
                                                                BoxFit.fill,
                                                            // placeholderScale: 1.0,
                                                            image:
                                                                "${Config.imageUrl}${homePageController.homeInfo?.homeData.catlist[index].img ?? ""}",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFcfefe0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        width: 100,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          homePageController
                                                                  .homeInfo
                                                                  ?.homeData
                                                                  .catlist[
                                                                      index]
                                                                  .title ??
                                                              "",
                                                          maxLines: 2,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: FontFamily
                                                                .gilroyMedium,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : Container(
                                            height: 200,
                                            width: Get.size.width,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "The medicine category \nis unavailable in your area."
                                                  .tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                fontSize: 15,
                                                color: BlackColor,
                                              ),
                                            ),
                                          ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Top Medicine Stores".tr,
                                        style: TextStyle(
                                          color: BlackColor,
                                          fontFamily:
                                              FontFamily.gilroyExtraBold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    homePageController.homeInfo!.homeData
                                            .topStore.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: homePageController
                                                .homeInfo
                                                ?.homeData
                                                .topStore
                                                .length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () async {
                                                  catDetailsController.strId =
                                                      homePageController
                                                              .homeInfo
                                                              ?.homeData
                                                              .topStore[index]
                                                              .storeId ??
                                                          "";
                                                  await storeDataContoller
                                                      .getStoreData(
                                                    storeId: homePageController
                                                        .homeInfo
                                                        ?.homeData
                                                        .topStore[index]
                                                        .storeId,
                                                  );
                                                  save("changeIndex", true);
                                                  homePageController.isback =
                                                      "1";
                                                  Get.toNamed(Routes
                                                      .bottombarProScreen);
                                                },
                                                child: Container(
                                                  width: Get.size.width,
                                                  margin: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          SizedBox(
                                                            height: 150,
                                                            width:
                                                                Get.size.width,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                topRight: Radius
                                                                    .circular(
                                                                        15),
                                                              ),
                                                              child: FadeInImage
                                                                  .assetNetwork(
                                                                fadeInCurve: Curves
                                                                    .easeInCirc,
                                                                placeholder:
                                                                    "assets/ezgif.com-crop.gif",
                                                                placeholderCacheHeight:
                                                                    150,
                                                                placeholderFit:
                                                                    BoxFit.fill,
                                                                // placeholderScale: 1.0,
                                                                image:
                                                                    "${Config.imageUrl}${homePageController.homeInfo?.homeData.topStore[index].storeCover ?? ""}",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            child: Container(
                                                              height: 65,
                                                              width: Get
                                                                  .size.width,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: Get
                                                                              .size
                                                                              .width *
                                                                          0.79,
                                                                      child:
                                                                          Text(
                                                                        homePageController.homeInfo?.homeData.topStore[index].couponTitle ??
                                                                            "",
                                                                        maxLines:
                                                                            1,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              WhiteColor,
                                                                          fontFamily:
                                                                              FontFamily.gilroyExtraBold,
                                                                          fontSize:
                                                                              20,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Text(
                                                                      homePageController
                                                                              .homeInfo
                                                                              ?.homeData
                                                                              .topStore[index]
                                                                              .couponSubtitle ??
                                                                          "",
                                                                      maxLines:
                                                                          1,
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            WhiteColor,
                                                                        fontFamily:
                                                                            FontFamily.gilroyMedium,
                                                                        fontSize:
                                                                            14,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: AssetImage(
                                                                      "assets/Rectangle.png"),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 15),
                                                            child: Text(
                                                              homePageController
                                                                      .homeInfo
                                                                      ?.homeData
                                                                      .topStore[
                                                                          index]
                                                                      .storeTitle ??
                                                                  "",
                                                              style: TextStyle(
                                                                color:
                                                                    BlackColor,
                                                                fontFamily:
                                                                    FontFamily
                                                                        .gilroyBold,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Html(
                                                              data: homePageController
                                                                      .homeInfo
                                                                      ?.homeData
                                                                      .topStore[
                                                                          index]
                                                                      .storeSdesc ??
                                                                  "",
                                                              style: {
                                                                '#': Style(
                                                                  fontSize:
                                                                      FontSize(
                                                                          14),
                                                                  maxLines: 2,
                                                                  color:
                                                                      BlackColor,
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .gilroyMedium,
                                                                  textOverflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 15),
                                                            child: Row(
                                                              children: [
                                                                Image.asset(
                                                                  "assets/heart.png",
                                                                  height: 18,
                                                                  width: 18,
                                                                  color: gradient
                                                                      .defoultColor,
                                                                ),
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text(
                                                                  "${homePageController.homeInfo?.homeData.topStore[index].totalFav} ${"Love this".tr}",
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        BlackColor,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .gilroyMedium,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Image.asset(
                                                                  "assets/ic_star_review.png",
                                                                  height: 15,
                                                                  width: 15,
                                                                ),
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  homePageController
                                                                          .homeInfo
                                                                          ?.homeData
                                                                          .topStore[
                                                                              index]
                                                                          .storeRate ??
                                                                      "",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .gilroyMedium,
                                                                    color:
                                                                        BlackColor,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 15),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  width: 120,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              8),
                                                                  child: Text(
                                                                    "${homePageController.homeInfo?.homeData.topStore[index].storeTags[0]}",
                                                                    maxLines: 1,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .gilroyMedium,
                                                                      color: gradient
                                                                          .defoultColor,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        gradient
                                                                            .lightGradient,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  height: 30,
                                                                  width: 100,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    "${homePageController.homeInfo?.homeData.topStore[index].storeTags.length}+ More",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          FontFamily
                                                                              .gilroyMedium,
                                                                      color: gradient
                                                                          .defoultColor,
                                                                    ),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        gradient
                                                                            .lightGradient,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: WhiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .grey.shade300,
                                                        offset: const Offset(
                                                          0.5,
                                                          0.5,
                                                        ),
                                                        blurRadius: 0.5,
                                                        spreadRadius: 0.5,
                                                      ), //BoxShadow
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        offset: const Offset(
                                                            0.0, 0.0),
                                                        blurRadius: 0.0,
                                                        spreadRadius: 0.0,
                                                      ), //BoxShadow
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : Container(
                                            height: 200,
                                            width: Get.size.width,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "No medical store available \nin your area."
                                                  .tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                fontSize: 15,
                                                color: BlackColor,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : SizedBox(
                            height: Get.size.height,
                            width: Get.size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        height: isActive ? 12 : 8,
        width: isActive ? 12 : 8,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF36393D) : Color(0xFFB3B2B7),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

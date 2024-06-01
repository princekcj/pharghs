// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unrelated_type_equality_checks, use_key_in_widget_constructors, must_be_immutable, library_private_types_in_public_api, unused_field, prefer_final_fields, avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmafast/Api/config.dart';
import 'package:pharmafast/controller/cart_controller.dart';
import 'package:pharmafast/controller/catdetails_controller.dart';
import 'package:pharmafast/controller/fav_controller.dart';
import 'package:pharmafast/controller/productdetails_controller.dart';
import 'package:pharmafast/controller/stordata_controller.dart';
import 'package:pharmafast/helpar/routes_helper.dart';
import 'package:pharmafast/model/fontfamily_model.dart';
import 'package:pharmafast/screen/home_screen.dart';
import 'package:pharmafast/utils/Colors.dart';
import 'package:pharmafast/utils/Custom_widget.dart';
import 'package:pharmafast/utils/cart_item.dart';

class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen({super.key});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  CatDetailsController catDetailsController = Get.find();
  StoreDataContoller storeDataContoller = Get.find();
  ProductDetailsController productDetailsController = Get.find();
  CartController cartController = Get.find();
  FavController favController = Get.find();
  int cnt = 0;
  ScrollController? _scrollController;
  bool lastStatus = true;
  double height = Get.height * 0.56;

  late Box<CartItem> cart;
  late final List<CartItem> items;
  double productPrice = 0;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    cart = Hive.box<CartItem>('cart');
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    setupHive();
  }

  Future<void> setupHive() async {
    await Hive.initFlutter();
    cart = Hive.box<CartItem>('cart');
    AsyncSnapshot.waiting();
    List<CartItem> tempList = [];
    catDetailsController.getCartLangth();
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(HomeScreen());
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: bgcolor,
        body: GetBuilder<StoreDataContoller>(builder: (context) {
          return storeDataContoller.isLoading
              ? NestedScrollView(
                  controller: _scrollController,
                  physics: NeverScrollableScrollPhysics(),
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        elevation: 0,
                        backgroundColor: _isShrink ? WhiteColor : bgcolor,
                        pinned: true,
                        expandedHeight: Get.height * 0.63,
                        automaticallyImplyLeading: false,
                        leading: _isShrink
                            ? InkWell(
                                onTap: () {
                                  Get.offAll(HomeScreen());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/Back.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              )
                            : null,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          title: _isShrink
                              ? SizedBox(
                                  width: Get.size.width * 0.4,
                                  child: Text(
                                    storeDataContoller.storeDataInfo?.storeInfo
                                            .storeTitle ??
                                        "",
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: BlackColor,
                                      fontFamily: FontFamily.gilroyBold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              : null,
                          background: Container(
                            height: Get.height * 0.63,
                            width: Get.size.width,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 35,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.offAll(HomeScreen());
                                      },
                                      child: Image.asset(
                                        "assets/Back.png",
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.homeSearchScreen,
                                          arguments: {
                                            "statusWiseSearch": false,
                                          },
                                        );
                                      },
                                      child: Image.asset(
                                        "assets/Search1.png",
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // Image.asset(
                                    //   "assets/meassege.png",
                                    //   height: 40,
                                    //   width: 40,
                                    // ),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    // Image.asset(
                                    //   "assets/Share.png",
                                    //   height: 40,
                                    //   width: 40,
                                    // ),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                  ],
                                ),
                                Spacer(),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      // height: Get.size.height * 0.45,
                                      width: Get.size.width * 0.9,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text(
                                              storeDataContoller.storeDataInfo
                                                      ?.storeInfo.storeTitle ??
                                                  "",
                                              style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                fontSize: 20,
                                                color: BlackColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/heart.png",
                                                  height: 18,
                                                  width: 18,
                                                  color: gradient.defoultColor,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "${storeDataContoller.storeDataInfo?.storeInfo.totalFav} ${"Love this".tr}.",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: greytext,
                                                    fontFamily:
                                                        FontFamily.gilroyMedium,
                                                    fontSize: 14,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                  "${storeDataContoller.storeDataInfo?.storeInfo.storeRate}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    color: BlackColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: SizedBox(
                                              width: Get.size.width,
                                              child: Text(
                                                "${storeDataContoller.storeDataInfo?.storeInfo.storeTags.join(",")}",
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: greytext,
                                                  fontFamily:
                                                      FontFamily.gilroyMedium,
                                                  fontSize: 14,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Text(
                                              storeDataContoller
                                                      .storeDataInfo
                                                      ?.storeInfo
                                                      .storeShortDesc ??
                                                  "",
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: BlackColor,
                                                fontFamily:
                                                    FontFamily.gilroyMedium,
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              AnimatedContainer(
                                                height: 40,
                                                width: storeDataContoller
                                                            .storeDataInfo
                                                            ?.storeInfo
                                                            .isFavourite ==
                                                        0
                                                    ? Get.size.width * 0.4
                                                    : Get.size.width * 0.17,
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.fastOutSlowIn,
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.all(10),
                                                child: InkWell(
                                                  onTap: () {
                                                    favController
                                                        .addFavAndRemoveApi(
                                                      storeId:
                                                          storeDataContoller
                                                              .storeDataInfo
                                                              ?.storeInfo
                                                              .storeId,
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      storeDataContoller
                                                                  .storeDataInfo
                                                                  ?.storeInfo
                                                                  .isFavourite ==
                                                              0
                                                          ? Image.asset(
                                                              "assets/heartOutlinded.png",
                                                              height: 20,
                                                              width: 20,
                                                              color: gradient
                                                                  .defoultColor,
                                                            )
                                                          : Image.asset(
                                                              "assets/heart.png",
                                                              height: 20,
                                                              width: 20,
                                                              color: gradient
                                                                  .defoultColor,
                                                            ),
                                                      storeDataContoller
                                                                  .storeDataInfo
                                                                  ?.storeInfo
                                                                  .isFavourite ==
                                                              0
                                                          ? SizedBox(
                                                              width: 8,
                                                            )
                                                          : SizedBox(),
                                                      storeDataContoller
                                                                  .storeDataInfo
                                                                  ?.storeInfo
                                                                  .isFavourite ==
                                                              0
                                                          ? Text(
                                                              "Love This".tr,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color: gradient
                                                                    .defoultColor,
                                                                fontFamily:
                                                                    FontFamily
                                                                        .gilroyBold,
                                                                fontSize: 16,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),

                                              // : AnimatedContainer(
                                              //     height: 40,
                                              //     width: 50,
                                              //     duration: const Duration(
                                              //         seconds: 1),
                                              //     curve: Curves.fastOutSlowIn,
                                              //   ),,
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    catDetailsController
                                                        .changeIndex(1);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          "assets/info-circle.png",
                                                          height: 20,
                                                          width: 20,
                                                          color: gradient
                                                              .defoultColor,
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          "About".tr,
                                                          style: TextStyle(
                                                            color: gradient
                                                                .defoultColor,
                                                            fontFamily:
                                                                FontFamily
                                                                    .gilroyBold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Divider(),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          catDRow(
                                            img: "assets/box.png",
                                            text: "Delivery across your zone".tr,
                                          ),
                                          catDRow(
                                            img: "assets/clock.png",
                                            text:
                                                "Usually dispatches orders on the same day"
                                                    .tr,
                                          ),
                                          catDRow(
                                            img: "assets/star.png",
                                            text: "Delivery fee will apply".tr,
                                          ),
                                          catDRow(
                                            img: "assets/shopping-bag-alt.png",
                                            text:
                                                "${"All orders will be Delivered by".tr} ${storeDataContoller.storeDataInfo?.storeInfo.storeTitle ?? ""}",
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: WhiteColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    Positioned(
                                      top: -30,
                                      left: 25,
                                      child: Container(
                                        height: 65,
                                        width: 70,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            "${Config.imageUrl}${storeDataContoller.storeDataInfo?.storeInfo.storeLogo ?? ""}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: WhiteColor,
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "${Config.imageUrl}${storeDataContoller.storeDataInfo?.storeInfo.storeCover ?? ""}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        actions: _isShrink
                            ? [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.homeSearchScreen,
                                      arguments: {
                                        "statusWiseSearch": false,
                                      },
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/Search1.png",
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ]
                            : null,
                      ),
                    ];
                  },
                  body: RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 2),
                        () {
                          storeDataContoller.getStoreData(
                              storeId: catDetailsController.strId);
                        },
                      );
                    },
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {
                            catDetailsController.changeIndex(2);
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
                                          image: AssetImage(
                                              "assets/Group5346.png"),
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
                                                fontFamily:
                                                    FontFamily.gilroyMedium,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Get 15% off on medicines*".tr,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: BlackColor,
                                                fontFamily:
                                                    FontFamily.gilroyBold,
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
                                                fontFamily:
                                                    FontFamily.gilroyMedium,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 90,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Upload".tr,
                                          style: TextStyle(
                                            color: WhiteColor,
                                            fontFamily: FontFamily.gilroyBold,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          gradient: gradient.btnGradient,
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
                            ),
                          ),
                        ),
                        Container(
                          width: Get.size.width,
                          child: Column(
                            children: [
                              storeDataContoller
                                      .storeDataInfo!.recentproduct.isNotEmpty
                                  ? SizedBox(
                                      height: 10,
                                    )
                                  : SizedBox(),
                              storeDataContoller
                                      .storeDataInfo!.recentproduct.isNotEmpty
                                  ? Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            "Recently added".tr,
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              fontSize: 20,
                                              color: BlackColor,
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
                                            "${storeDataContoller.storeDataInfo?.recentproduct.length} ${"iteam".tr}",
                                            style: TextStyle(
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
                                              fontSize: 14,
                                              color: greytext,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                              storeDataContoller
                                      .storeDataInfo!.recentproduct.isNotEmpty
                                  ? SizedBox(
                                      height: 250,
                                      width: Get.size.width,
                                      child: ListView.builder(
                                        itemCount: storeDataContoller
                                            .storeDataInfo
                                            ?.recentproduct
                                            .length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            height: 280,
                                            width: 150,
                                            margin: EdgeInsets.all(1),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    productDetailsController
                                                        .getProductDetailsApi(
                                                      pId: storeDataContoller
                                                          .storeDataInfo
                                                          ?.recentproduct[index]
                                                          .id,
                                                    );
                                                    productDetailsController.getProductDetails(
                                                        index1: index,
                                                        sId: storeDataContoller
                                                                .storeDataInfo
                                                                ?.storeInfo
                                                                .storeId ??
                                                            "",
                                                        strName1: storeDataContoller
                                                                .storeDataInfo
                                                                ?.storeInfo
                                                                .storeTitle ??
                                                            "",
                                                        logo1: storeDataContoller
                                                                .storeDataInfo
                                                                ?.storeInfo
                                                                .storeLogo ??
                                                            "",
                                                        slogan1: storeDataContoller
                                                                .storeDataInfo
                                                                ?.storeInfo
                                                                .storeSlogan ??
                                                            "",
                                                        straddress: storeDataContoller
                                                                .storeDataInfo
                                                                ?.storeInfo
                                                                .storeAddress ??
                                                            "",
                                                        isFev1: storeDataContoller
                                                            .storeDataInfo
                                                            ?.storeInfo
                                                            .isFavourite,
                                                        qLimit1: storeDataContoller.storeDataInfo?.recentproduct[index].qlimit ?? "",
                                                        lat1: storeDataContoller.storeDataInfo?.storeInfo.storeLat ?? "",
                                                        long1: storeDataContoller.storeDataInfo?.storeInfo.storeLongs ?? "");
                                                    Get.toNamed(Routes
                                                        .productDetailsScreen);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 125,
                                                        width: 125,
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
                                                                125,
                                                            placeholderCacheWidth:
                                                                125,
                                                            placeholderFit:
                                                                BoxFit.fill,
                                                            image:
                                                                "${Config.imageUrl}${storeDataContoller.storeDataInfo?.recentproduct[index].img}",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          storeDataContoller
                                                                  .storeDataInfo
                                                                  ?.recentproduct[
                                                                      index]
                                                                  .title ??
                                                              "",
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FontFamily
                                                                    .gilroyBold,
                                                            fontSize: 15,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        width: 230,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            Text(
                                                              "${currency}${storeDataContoller.storeDataInfo?.recentproduct[index].sprice ?? ""}",
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .gilroyBold,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "${currency}${storeDataContoller.storeDataInfo?.recentproduct[index].aprice ?? ""}",
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color:
                                                                    greyColor,
                                                                fontFamily:
                                                                    FontFamily
                                                                        .gilroyMedium,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                //! ------------ Add Product Widget -------------!//
                                                isItem(storeDataContoller
                                                            .storeDataInfo
                                                            ?.recentproduct[
                                                                index]
                                                            .id
                                                            .toString()) !=
                                                        "0"
                                                    ? Container(
                                                        height: 40,
                                                        width: 130,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 7,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  onRemoveItem(
                                                                      index,
                                                                      isItem(storeDataContoller
                                                                          .storeDataInfo
                                                                          ?.recentproduct[
                                                                              index]
                                                                          .id
                                                                          .toString()),
                                                                      id1: storeDataContoller
                                                                              .storeDataInfo
                                                                              ?.recentproduct[
                                                                                  index]
                                                                              .id ??
                                                                          "",
                                                                      price1: storeDataContoller
                                                                              .storeDataInfo
                                                                              ?.recentproduct[index]
                                                                              .sprice ??
                                                                          "");
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 30,
                                                                width: 30,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: gradient
                                                                      .defoultColor,
                                                                  size: 18,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  isItem(storeDataContoller
                                                                          .storeDataInfo
                                                                          ?.recentproduct[
                                                                              index]
                                                                          .id)
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: gradient
                                                                        .defoultColor,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .gilroyBold,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  onAddItem(
                                                                    index,
                                                                    isItem(storeDataContoller
                                                                        .storeDataInfo
                                                                        ?.recentproduct[
                                                                            index]
                                                                        .id),
                                                                    id1: storeDataContoller
                                                                            .storeDataInfo
                                                                            ?.recentproduct[index]
                                                                            .id ??
                                                                        "",
                                                                    price1: storeDataContoller
                                                                            .storeDataInfo
                                                                            ?.recentproduct[index]
                                                                            .sprice ??
                                                                        "",
                                                                    strTitle1: storeDataContoller
                                                                            .storeDataInfo
                                                                            ?.recentproduct[index]
                                                                            .title ??
                                                                        "",
                                                                    isRequride1: storeDataContoller
                                                                            .storeDataInfo
                                                                            ?.recentproduct[index]
                                                                            .isRequire ??
                                                                        "",
                                                                    per1: storeDataContoller
                                                                            .storeDataInfo
                                                                            ?.recentproduct[index]
                                                                            .percentage
                                                                            .toString() ??
                                                                        "",
                                                                    qLimit1: storeDataContoller
                                                                            .storeDataInfo
                                                                            ?.recentproduct[index]
                                                                            .qlimit ??
                                                                        "",
                                                                    storeId1: storeDataContoller
                                                                        .storeDataInfo
                                                                        ?.storeInfo
                                                                        .storeId,
                                                                    sPrice1: storeDataContoller
                                                                            .storeDataInfo
                                                                            ?.recentproduct[index]
                                                                            .aprice ??
                                                                        "",
                                                                  );
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 30,
                                                                width: 30,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: gradient
                                                                      .defoultColor,
                                                                  size: 18,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 7,
                                                            ),
                                                          ],
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade300),
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            onAddItem(
                                                              index,
                                                              isItem(storeDataContoller
                                                                  .storeDataInfo
                                                                  ?.recentproduct[
                                                                      index]
                                                                  .id),
                                                              id1: storeDataContoller
                                                                      .storeDataInfo
                                                                      ?.recentproduct[
                                                                          index]
                                                                      .id ??
                                                                  "",
                                                              price1: storeDataContoller
                                                                      .storeDataInfo
                                                                      ?.recentproduct[
                                                                          index]
                                                                      .sprice ??
                                                                  "",
                                                              strTitle1: storeDataContoller
                                                                      .storeDataInfo
                                                                      ?.recentproduct[
                                                                          index]
                                                                      .title ??
                                                                  "",
                                                              isRequride1: storeDataContoller
                                                                      .storeDataInfo
                                                                      ?.recentproduct[
                                                                          index]
                                                                      .isRequire ??
                                                                  "",
                                                              per1: storeDataContoller
                                                                      .storeDataInfo
                                                                      ?.recentproduct[
                                                                          index]
                                                                      .percentage
                                                                      .toString() ??
                                                                  "",
                                                              qLimit1: storeDataContoller
                                                                      .storeDataInfo
                                                                      ?.recentproduct[
                                                                          index]
                                                                      .qlimit ??
                                                                  "",
                                                              storeId1:
                                                                  storeDataContoller
                                                                      .storeDataInfo
                                                                      ?.storeInfo
                                                                      .storeId,
                                                              sPrice1: storeDataContoller
                                                                      .storeDataInfo
                                                                      ?.recentproduct[
                                                                          index]
                                                                      .aprice ??
                                                                  "",
                                                            );
                                                          });
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 130,
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "Add".tr,
                                                            style: TextStyle(
                                                              color: gradient
                                                                  .defoultColor,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .gilroyBold,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : SizedBox(),
                              storeDataContoller
                                      .storeDataInfo!.catwiseproduct.isNotEmpty
                                  ? Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(left: 15),
                                          child: Text(
                                            "All Products".tr,
                                            style: TextStyle(
                                              fontFamily:
                                                  FontFamily.gilroyExtraBold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: ListView.builder(
                                            itemCount: storeDataContoller
                                                .storeDataInfo
                                                ?.catwiseproduct
                                                .length,
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index1) {
                                              return Theme(
                                                data: ThemeData().copyWith(
                                                    dividerColor:
                                                        Colors.transparent),
                                                child: ExpansionTile(
                                                  initiallyExpanded: true,
                                                  iconColor: Color(0xFF50c1b7),
                                                  title: Text(
                                                    storeDataContoller
                                                            .storeDataInfo
                                                            ?.catwiseproduct[
                                                                index1]
                                                            .catTitle ??
                                                        "",
                                                    style: TextStyle(
                                                      color: BlackColor,
                                                      fontFamily:
                                                          FontFamily.gilroyBold,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    "${storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata.length} ${"iteam".tr}",
                                                    style: TextStyle(
                                                      color: greytext,
                                                      fontFamily: FontFamily
                                                          .gilroyMedium,
                                                    ),
                                                  ),
                                                  children: [
                                                    ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          storeDataContoller
                                                              .storeDataInfo
                                                              ?.catwiseproduct[
                                                                  index1]
                                                              .productdata
                                                              .length,
                                                      padding: EdgeInsets.zero,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return InkWell(
                                                          onTap: () {},
                                                          child: Container(
                                                            height: 175,
                                                            width:
                                                                Get.size.width,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                10),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        productDetailsController
                                                                            .getProductDetailsApi(
                                                                          pId: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].id ??
                                                                              "",
                                                                        );
                                                                        productDetailsController.getProductDetails(
                                                                            index1:
                                                                                index,
                                                                            sId: storeDataContoller.storeDataInfo?.storeInfo.storeId ??
                                                                                "",
                                                                            strName1: storeDataContoller.storeDataInfo?.storeInfo.storeTitle ??
                                                                                "",
                                                                            logo1: storeDataContoller.storeDataInfo?.storeInfo.storeLogo ??
                                                                                "",
                                                                            slogan1: storeDataContoller.storeDataInfo?.storeInfo.storeSlogan ??
                                                                                "",
                                                                            straddress: storeDataContoller.storeDataInfo?.storeInfo.storeAddress ??
                                                                                "",
                                                                            isFev1:
                                                                                storeDataContoller.storeDataInfo?.storeInfo.isFavourite,
                                                                            qLimit1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].qlimit,
                                                                            lat1: storeDataContoller.storeDataInfo?.storeInfo.storeLat ?? "",
                                                                            long1: storeDataContoller.storeDataInfo?.storeInfo.storeLongs ?? "");
                                                                        Get.toNamed(
                                                                            Routes.productDetailsScreen);
                                                                      },
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                30,
                                                                            width:
                                                                                80,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Text(
                                                                              "${storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].percentage}% Off",
                                                                              style: TextStyle(
                                                                                fontFamily: FontFamily.gilroyBold,
                                                                                color: WhiteColor,
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              gradient: gradient.greenGradient,
                                                                              borderRadius: BorderRadius.only(
                                                                                topRight: Radius.circular(10),
                                                                                bottomLeft: Radius.circular(10),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].title ??
                                                                                "",
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: FontFamily.gilroyBold,
                                                                              fontSize: 18,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                "${currency}${storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].sprice ?? ""}",
                                                                                style: TextStyle(
                                                                                  fontFamily: FontFamily.gilroyBold,
                                                                                  fontSize: 18,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                "${currency}${storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].aprice ?? ""}",
                                                                                style: TextStyle(color: greyColor, fontFamily: FontFamily.gilroyMedium, fontSize: 15, decoration: TextDecoration.lineThrough),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].description ??
                                                                                "",
                                                                            maxLines:
                                                                                2,
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: FontFamily.gilroyMedium,
                                                                              height: 1.2,
                                                                              fontSize: 13,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].isRequire == "1"
                                                                              ? Row(
                                                                                  children: [
                                                                                    Image.asset(
                                                                                      "assets/Rx.png",
                                                                                      height: 20,
                                                                                      width: 20,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 8,
                                                                                    ),
                                                                                    Text(
                                                                                      "Required".tr,
                                                                                      maxLines: 1,
                                                                                      style: TextStyle(
                                                                                        color: greyColor,
                                                                                        fontFamily: FontFamily.gilroyMedium,
                                                                                        fontSize: 13,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : SizedBox()
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        productDetailsController
                                                                            .getProductDetailsApi(
                                                                          pId: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].id ??
                                                                              "",
                                                                        );
                                                                        productDetailsController.getProductDetails(
                                                                            index1:
                                                                                index,
                                                                            strName1: storeDataContoller.storeDataInfo?.storeInfo.storeTitle ??
                                                                                "",
                                                                            logo1: storeDataContoller.storeDataInfo?.storeInfo.storeLogo ??
                                                                                "",
                                                                            slogan1: storeDataContoller.storeDataInfo?.storeInfo.storeSlogan ??
                                                                                "",
                                                                            straddress: storeDataContoller.storeDataInfo?.storeInfo.storeAddress ??
                                                                                "",
                                                                            qLimit1:
                                                                                storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].qlimit,
                                                                            lat1: storeDataContoller.storeDataInfo?.storeInfo.storeLat ?? "",
                                                                            long1: storeDataContoller.storeDataInfo?.storeInfo.storeLongs ?? "");
                                                                        Get.toNamed(
                                                                            Routes.productDetailsScreen);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            120,
                                                                        width:
                                                                            120,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                          child:
                                                                              FadeInImage.assetNetwork(
                                                                            fadeInCurve:
                                                                                Curves.easeInCirc,
                                                                            placeholder:
                                                                                "assets/ezgif.com-crop.gif",
                                                                            placeholderCacheHeight:
                                                                                120,
                                                                            placeholderCacheWidth:
                                                                                120,
                                                                            placeholderFit:
                                                                                BoxFit.fill,
                                                                            image:
                                                                                "${Config.imageUrl}${storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].img}",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    //! ------------ Add Product Widget -------------!//
                                                                    isItem(storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].id.toString()) !=
                                                                            "0"
                                                                        ? Container(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                130,
                                                                            margin:
                                                                                EdgeInsets.all(5),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 7,
                                                                                ),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      onRemoveItem(
                                                                                        index,
                                                                                        isItem(storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].id.toString()),
                                                                                        id1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].id ?? "",
                                                                                        price1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].sprice ?? "",
                                                                                      );
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 30,
                                                                                    width: 30,
                                                                                    alignment: Alignment.center,
                                                                                    child: Icon(
                                                                                      Icons.remove,
                                                                                      color: gradient.defoultColor,
                                                                                      size: 18,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    child: Text(
                                                                                      isItem(storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].id).toString(),
                                                                                      style: TextStyle(
                                                                                        color: gradient.defoultColor,
                                                                                        fontFamily: FontFamily.gilroyBold,
                                                                                        fontSize: 15,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      onAddItem(index, isItem(storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].id), id1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].id ?? "", price1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].sprice ?? "", strTitle1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].title ?? "", per1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].percentage.toString() ?? "", isRequride1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].isRequire ?? "", qLimit1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].qlimit ?? "", storeId1: storeDataContoller.storeDataInfo?.storeInfo.storeId, sPrice1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].aprice ?? "");
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 30,
                                                                                    width: 30,
                                                                                    alignment: Alignment.center,
                                                                                    child: Icon(
                                                                                      Icons.add,
                                                                                      color: gradient.defoultColor,
                                                                                      size: 18,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 7,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              border: Border.all(color: Colors.grey.shade300),
                                                                            ),
                                                                          )
                                                                        : InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                onAddItem(
                                                                                  index,
                                                                                  isItem(storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].id),
                                                                                  id1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].id ?? "",
                                                                                  price1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].sprice ?? "",
                                                                                  strTitle1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].title ?? "",
                                                                                  per1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].percentage.toString() ?? "",
                                                                                  isRequride1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].isRequire ?? "",
                                                                                  qLimit1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].qlimit ?? "",
                                                                                  storeId1: storeDataContoller.storeDataInfo?.storeInfo.storeId,
                                                                                  sPrice1: storeDataContoller.storeDataInfo?.catwiseproduct[index1].productdata[index].aprice ?? "",
                                                                                );
                                                                              });
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 40,
                                                                              width: 130,
                                                                              margin: EdgeInsets.all(5),
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                "Add".tr,
                                                                                style: TextStyle(
                                                                                  color: gradient.defoultColor,
                                                                                  fontFamily: FontFamily.gilroyBold,
                                                                                  fontSize: 15,
                                                                                ),
                                                                              ),
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                border: Border.all(color: Colors.grey.shade300),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.circular(15),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        }),
      ),
    );
  }

  Future<void> onAddItem(
    int index,
    String qtys, {
    String? id1,
    price1,
    strTitle1,
    per1,
    isRequride1,
    qLimit1,
    storeId1,
    sPrice1,
  }) async {
    String? id = id1;
    String? price = price1.toString();
    int? qty = int.parse(qtys);
    qty = qty + 1;
    cart = Hive.box<CartItem>('cart');
    final newItem = CartItem();
    newItem.id = id;
    newItem.price = double.parse(price1.toString());
    newItem.quantity = qty;
    newItem.productPrice = double.parse(price1.toString());
    newItem.strTitle = strTitle1;
    newItem.per = per1;
    newItem.isRequride = isRequride1;
    newItem.qLimit = qLimit1;
    newItem.storeID = storeId1;
    newItem.sPrice = double.parse(sPrice1);

    print("<<<<<<<<ID>>>>>>>>" + id1.toString());
    print("<<<<<<<<Price1>>>>>>>>" + price1.toString());
    print("<<<<<<<<Qty>>>>>>>>" + qty.toString());
    print("<<<<<<<<StrTitle1>>>>>>>>" + strTitle1.toString());
    print("<<<<<<<<Per1>>>>>>>>" + per1.toString());
    print("<<<<<<<<IsRequride1>>>>>>>>" + isRequride1.toString());
    print("<<<<<<<<QLimit1>>>>>>>>" + qLimit1.toString());
    print("<<<<<<<<StoreId1>>>>>>>>" + storeId1.toString());

    if (qtys == "0") {
      cart.put(id, newItem);
      catDetailsController.getCartLangth();
    } else {
      if (int.parse(isItem(id)) < int.parse(qLimit1)) {
        var item = cart.get(id);
        item?.quantity = qty;
        cart.put(id, item!);
      } else {
        showToastMessage("Exceeded the maximum quantity limit per order!".tr);
      }
    }
  }

  void onRemoveItem(int index, String qtys, {String? id1, price1}) {
    String? id = id1;
    String? price = price1;
    int? qty = int.parse(qtys);
    qty = qty - 1;
    cart = Hive.box<CartItem>('cart');
    if (qtys == "1") {
      cart.delete(id);
      catDetailsController.getCartLangth();
    } else {
      var item = cart.get(id);
      item?.quantity = qty;
      cart.put(id, item!);
    }
  }

  String isItem(String? index) {
    for (final item in cart.values) {
      if (item.id == index) {
        return item.quantity.toString();
      }
    }
    return "0";
  }

  Widget catDRow({String? img, text}) {
    return Padding(
      padding: EdgeInsets.only(top: 5, right: 5),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Image.asset(
            img ?? "",
            height: 13,
            width: 13,
            color: greytext,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              style: TextStyle(
                color: greytext,
                fontFamily: FontFamily.gilroyMedium,
                fontSize: 13,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

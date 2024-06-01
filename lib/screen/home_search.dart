// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_brace_in_string_interps, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmafast/Api/config.dart';
import 'package:pharmafast/controller/catdetails_controller.dart';
import 'package:pharmafast/controller/home_controller.dart';
import 'package:pharmafast/controller/productdetails_controller.dart';
import 'package:pharmafast/controller/search_controller.dart';
import 'package:pharmafast/controller/stordata_controller.dart';
import 'package:pharmafast/helpar/routes_helper.dart';
import 'package:pharmafast/model/fontfamily_model.dart';
import 'package:pharmafast/screen/home_screen.dart';
import 'package:pharmafast/utils/Colors.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({super.key});

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> {
  TextEditingController search = TextEditingController();
  MySearchController searchController = Get.find();
  CatDetailsController catDetailsController = Get.find();
  StoreDataContoller storeDataContoller = Get.find();
  ProductDetailsController productDetailsController = Get.find();
  HomePageController homePageController = Get.find();

  bool statusWiseSearch = Get.arguments["statusWiseSearch"];

  @override
  void initState() {
    super.initState();
    search.text = "";
    if (statusWiseSearch == true) {
      searchController.getSearchStoreData(keyWord: "a");
    } else if (statusWiseSearch == false) {
      searchController.getSearchProductData(
        keyWord: "a",
        storeID: storeDataContoller.storeDataInfo?.storeInfo.storeId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: GetBuilder<MySearchController>(builder: (context) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      width: Get.size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2, right: 8),
                        child: TextField(
                          controller: search,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (value) {
                            // searchController.getSearchData(
                            //     countryId: getData.read("countryId"));
                          },
                          onChanged: (value) {
                            statusWiseSearch
                                ? value != ""
                                    ? searchController.getSearchStoreData(
                                        keyWord: value)
                                    : searchController.getSearchStoreData(
                                        keyWord: "a")
                                : value != ""
                                    ? searchController.getSearchProductData(
                                        keyWord: value,
                                        storeID: storeDataContoller
                                            .storeDataInfo?.storeInfo.storeId,
                                      )
                                    : searchController.getSearchProductData(
                                        keyWord: "a",
                                        storeID: storeDataContoller
                                            .storeDataInfo?.storeInfo.storeId,
                                      );
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 6),
                            border: InputBorder.none,
                            hintText: statusWiseSearch
                                ? "Search for stores"
                                : "Search for products",
                            hintStyle: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: greytext,
                            ),
                            prefixIcon: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: BlackColor,
                                size: 18,
                              ),
                            ),
                            // suffix: InkWell(
                            //   onTap: () {
                            //     search.text = "";
                            //   },
                            //   child: Container(
                            //     height: 45,
                            //     width: 30,
                            //     padding: EdgeInsets.only(top: 0),
                            //     alignment: Alignment.center,
                            //     child: Icon(
                            //       Icons.close,
                            //       color: BlackColor,
                            //       size: 18,
                            //     ),
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: WhiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              search.text != ""
                  ? SizedBox(
                      height: 10,
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: search.text != ""
                    ? statusWiseSearch
                        ? Text(
                            "${searchController.searchInfo.length} ${"Stores".tr}",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: FontFamily.gilroyBold,
                              color: BlackColor,
                            ),
                          )
                        : Text(
                            "${searchController.searchProductInfo.length} ${"Products".tr}",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: FontFamily.gilroyBold,
                              color: BlackColor,
                            ),
                          )
                    : SizedBox(),
              ),
              search.text != ""
                  ? SizedBox(
                      height: 10,
                    )
                  : SizedBox(),
              statusWiseSearch
                  ? searchController.isLoading
                      ? searchController.searchInfo.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: searchController.searchInfo.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      catDetailsController.strId =
                                          searchController
                                              .searchInfo[index].storeId;
                                      await storeDataContoller.getStoreData(
                                        storeId: searchController
                                            .searchInfo[index].storeId,
                                      );
                                      Get.toNamed(Routes.bottombarProScreen);
                                    },
                                    child: Container(
                                      height: 170,
                                      width: Get.size.width,
                                      margin: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 170,
                                                width: 120,
                                                margin: EdgeInsets.all(10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    fadeInCurve:
                                                        Curves.easeInCirc,
                                                    placeholder:
                                                        "assets/ezgif.com-crop.gif",
                                                    placeholderCacheHeight: 170,
                                                    placeholderCacheWidth: 120,
                                                    placeholderFit: BoxFit.fill,
                                                    // placeholderScale: 1.0,
                                                    image:
                                                        "${Config.imageUrl}${searchController.searchInfo[index].storeCover}",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                right: 10,
                                                child: Container(
                                                  height: 70,
                                                  width: 120,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 7),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          searchController
                                                              .searchInfo[index]
                                                              .couponTitle,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            color: WhiteColor,
                                                            fontFamily:
                                                                FontFamily
                                                                    .gilroyBold,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          searchController
                                                              .searchInfo[index]
                                                              .couponSubtitle,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            color: WhiteColor,
                                                            fontFamily: FontFamily
                                                                .gilroyMedium,
                                                            fontSize: 13,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/Rectangle.png"),
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  searchController
                                                      .searchInfo[index]
                                                      .storeTitle,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: BlackColor,
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    fontSize: 18,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Text(
                                                    searchController
                                                        .searchInfo[index]
                                                        .storeSdesc,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: BlackColor,
                                                      fontFamily: FontFamily
                                                          .gilroyMedium,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/heart.png",
                                                      height: 18,
                                                      width: 18,
                                                      color:
                                                          gradient.defoultColor,
                                                    ),
                                                    Text(
                                                      "${searchController.searchInfo[index].totalFav} ${"Love this".tr}",
                                                      style: TextStyle(
                                                        color: BlackColor,
                                                        fontFamily: FontFamily
                                                            .gilroyMedium,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Image.asset(
                                                      "assets/ic_star_review.png",
                                                      height: 18,
                                                      width: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      searchController
                                                          .searchInfo[index]
                                                          .storeRate,
                                                      style: TextStyle(
                                                        fontFamily: FontFamily
                                                            .gilroyBold,
                                                        color: BlackColor,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width: 100,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        searchController
                                                            .searchInfo[index]
                                                            .storeTags[0],
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontFamily: FontFamily
                                                              .gilroyMedium,
                                                          color: gradient
                                                              .defoultColor,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        gradient: gradient
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
                                                      width: 50,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "${searchController.searchInfo[index].storeTags.length}+",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontFamily: FontFamily
                                                              .gilroyMedium,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: gradient
                                                              .defoultColor,
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        gradient: gradient
                                                            .lightGradient,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: WhiteColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Container(
                                  height: 200,
                                  width: Get.size.width,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "No medical store available \nin your area.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      fontSize: 15,
                                      color: BlackColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                      : Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                  : searchController.isLoading
                      ? searchController.searchProductInfo.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount:
                                    searchController.searchProductInfo.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      productDetailsController
                                          .getProductDetailsApi(
                                        pId: searchController
                                            .searchProductInfo[index].id,
                                      );
                                      productDetailsController.getProductDetails(
                                          index1: index,
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
                                          qLimit1: searchController
                                              .searchProductInfo[index].qlimit,
                                          lat1: storeDataContoller.storeDataInfo?.storeInfo.storeLat ?? "",
                                          long1: storeDataContoller.storeDataInfo?.storeInfo.storeLongs ?? "");
                                      Get.toNamed(Routes.productDetailsScreen);
                                    },
                                    child: Container(
                                      height: 150,
                                      width: Get.size.width,
                                      margin: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 110,
                                            margin: EdgeInsets.all(10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: FadeInImage.assetNetwork(
                                                fadeInCurve: Curves.easeInCirc,
                                                placeholder:
                                                    "assets/ezgif.com-crop.gif",
                                                placeholderCacheHeight: 120,
                                                placeholderCacheWidth: 120,
                                                placeholderFit: BoxFit.fill,
                                                image:
                                                    "${Config.imageUrl}${searchController.searchProductInfo[index].img}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 80,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "${searchController.searchProductInfo[index].percentage}% Off",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          FontFamily.gilroyBold,
                                                      color: WhiteColor,
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        gradient.greenGradient,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  searchController
                                                      .searchProductInfo[index]
                                                      .title,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    fontSize: 17,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${currency}${searchController.searchProductInfo[index].sprice}",
                                                      style: TextStyle(
                                                        fontFamily: FontFamily
                                                            .gilroyBold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    Text(
                                                      "${currency}${searchController.searchProductInfo[index].aprice}",
                                                      style: TextStyle(
                                                        fontFamily: FontFamily
                                                            .gilroyBold,
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                searchController
                                                            .searchProductInfo[
                                                                index]
                                                            .isRequire ==
                                                        "1"
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
                                                            "Rx Required",
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color: greyColor,
                                                              fontFamily: FontFamily
                                                                  .gilroyMedium,
                                                              fontSize: 13,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox()
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: WhiteColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Container(
                                  height: 200,
                                  width: Get.size.width,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "The medicine is currently \nunavailable in region",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      fontSize: 15,
                                      color: BlackColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                      : Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
            ],
          ),
        );
      }),
    );
  }
}

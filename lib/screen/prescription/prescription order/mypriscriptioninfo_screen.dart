// ignore_for_file: prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmafast/Api/config.dart';
import 'package:pharmafast/controller/catdetails_controller.dart';
import 'package:pharmafast/controller/prescription_controller.dart';
import 'package:pharmafast/controller/stordata_controller.dart';
import 'package:pharmafast/model/fontfamily_model.dart';
import 'package:pharmafast/screen/about_screen.dart';
import 'package:pharmafast/screen/home_screen.dart';
import 'package:pharmafast/screen/yourcart_screen.dart';
import 'package:pharmafast/utils/Colors.dart';
import 'package:pharmafast/utils/Custom_widget.dart';
import 'package:pharmafast/utils/cart_item.dart';

class MyPriscriptionInfo extends StatefulWidget {
  const MyPriscriptionInfo({super.key});

  @override
  State<MyPriscriptionInfo> createState() => _MyPriscriptionInfoState();
}

class _MyPriscriptionInfoState extends State<MyPriscriptionInfo> {
  PreScriptionControllre preScriptionControllre = Get.find();
  CatDetailsController catDetailsController = Get.find();
  StoreDataContoller storeDataContoller = Get.find();

  String oID = Get.arguments["oID"];

  final note = TextEditingController();
  var selectedRadioTile;
  String? rejectmsg = '';

  late Box<CartItem> cart;
  late final List<CartItem> items;

  @override
  void initState() {
    cart = Hive.box<CartItem>('cart');
    super.initState();
  }

  Future<void> setupHive() async {
    await Hive.initFlutter();
    cart = Hive.box<CartItem>('cart');
    AsyncSnapshot.waiting();

    // catDetailsController.getCartLangth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        leading: BackButton(
          color: BlackColor,
        ),
        title: Text(
          "${"Order ID:".tr} #$oID",
          style: TextStyle(
              fontFamily: FontFamily.gilroyBold,
              color: BlackColor,
              fontSize: 17),
        ),
        elevation: 0,
        backgroundColor: WhiteColor,
      ),
      bottomNavigationBar:
          GetBuilder<PreScriptionControllre>(builder: (context) {
        return preScriptionControllre
                    .preDetailsInfo?.pOrderProductList.flowId ==
                "4"
            ? InkWell(
                onTap: () async {
                  storeDataContoller.storeid = preScriptionControllre
                          .preDetailsInfo?.pOrderProductList.storeId ??
                      "";
                  await storeDataContoller.getStoreData(
                    storeId: preScriptionControllre
                            .preDetailsInfo?.pOrderProductList.storeId ??
                        "",
                  );
                  for (var element in cart.values) {
                    if (element.storeID == storeDataContoller.storeid) {
                      cart.delete(element.id);
                    }
                  }
                  for (var i = 0;
                      i <
                          preScriptionControllre.preDetailsInfo!
                              .pOrderProductList.cartOrderProductData.length;
                      i++) {
                    cart.delete(preScriptionControllre.preDetailsInfo
                            ?.pOrderProductList.cartOrderProductData[i].id ??
                        "");
                    onAddItem(
                      i,
                      isItem(preScriptionControllre.preDetailsInfo
                              ?.pOrderProductList.cartOrderProductData[i].id ??
                          ""),
                      id1: preScriptionControllre.preDetailsInfo
                              ?.pOrderProductList.cartOrderProductData[i].id ??
                          "",
                      price1: preScriptionControllre
                              .preDetailsInfo
                              ?.pOrderProductList
                              .cartOrderProductData[i]
                              .sprice ??
                          "",
                      strTitle1: preScriptionControllre
                              .preDetailsInfo
                              ?.pOrderProductList
                              .cartOrderProductData[i]
                              .title ??
                          "",
                      per1: preScriptionControllre
                              .preDetailsInfo
                              ?.pOrderProductList
                              .cartOrderProductData[i]
                              .percentage
                              .toString() ??
                          "",
                      isRequride1: preScriptionControllre
                              .preDetailsInfo
                              ?.pOrderProductList
                              .cartOrderProductData[i]
                              .isRequire ??
                          "",
                      qLimit1: preScriptionControllre
                              .preDetailsInfo
                              ?.pOrderProductList
                              .cartOrderProductData[i]
                              .qlimit ??
                          "",
                      storeId1: preScriptionControllre
                          .preDetailsInfo?.pOrderProductList.storeId,
                      sPrice1: preScriptionControllre
                              .preDetailsInfo
                              ?.pOrderProductList
                              .cartOrderProductData[i]
                              .aprice ??
                          "",
                      quntaty: preScriptionControllre
                              .preDetailsInfo
                              ?.pOrderProductList
                              .orderProductData[i]
                              .productQuantity ??
                          "",
                    );
                  }
                  Get.to(YourCartScreen(CartStatus: "2", oID: oID));
                },
                child: Container(
                  height: 45,
                  width: Get.size.width,
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  alignment: Alignment.center,
                  child: Text(
                    "View Cart".tr,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyBold,
                      color: WhiteColor,
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: gradient.btnGradient,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              )
            : preScriptionControllre.preDetailsInfo?.pOrderProductList.flowId ==
                    "3"
                ? Container(
                    height: 50,
                    width: Get.size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              ticketCancell(oID);
                            },
                            child: Container(
                              height: 50,
                              width: Get.size.width,
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              alignment: Alignment.center,
                              child: Text(
                                "Reject".tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  color: WhiteColor,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: RedColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              preScriptionControllre.makeDicision(
                                  oID: oID, status: "1", reson: "n/a");
                            },
                            child: Container(
                              height: 50,
                              width: Get.size.width,
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              alignment: Alignment.center,
                              child: Text(
                                "Accept".tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  color: WhiteColor,
                                ),
                              ),
                              decoration: BoxDecoration(
                                gradient: gradient.btnGradient,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : preScriptionControllre
                                    .preDetailsInfo?.pOrderProductList.flowId ==
                                "10" &&
                            preScriptionControllre
                                    .preDetailsInfo?.pOrderProductList.isRate ==
                                "0" ||
                        preScriptionControllre
                                    .preDetailsInfo?.pOrderProductList.flowId ==
                                "13" &&
                            preScriptionControllre
                                    .preDetailsInfo?.pOrderProductList.isRate ==
                                "0"
                    ? InkWell(
                        onTap: () {
                          reviewSheet();
                        },
                        child: Container(
                          height: 45,
                          width: Get.size.width,
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            "Review".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyBold,
                              fontSize: 17,
                              color: WhiteColor,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: gradient.btnGradient,
                          ),
                        ),
                      )
                    : SizedBox();
      }),
      body: GetBuilder<PreScriptionControllre>(builder: (context) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: preScriptionControllre.isLoading
                ? Column(
                    children: [
                      SizedBox(height: Get.height * 0.02),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: WhiteColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Uploaded Prescription".tr,
                              style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  color: BlackColor,
                                  fontSize: 17),
                            ),
                            SizedBox(height: Get.height * 0.02),
                            SizedBox(
                              height: Get.height * 0.22,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: preScriptionControllre
                                    .preDetailsInfo
                                    ?.pOrderProductList
                                    .orderPrescription
                                    .length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        FullScreenImage(
                                          imageUrl:
                                              "${Config.imageUrl}${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderPrescription[index] ?? ""}",
                                          tag: "generate_a_unique_tag",
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: Get.height * 0.2,
                                      width: Get.width * 0.4,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              "assets/ezgif.com-crop.gif",
                                          placeholderFit: BoxFit.cover,
                                          image:
                                              "${Config.imageUrl}${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderPrescription[index]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: transparent,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      preScriptionControllre.preDetailsInfo!.pOrderProductList
                              .orderProductData.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: WhiteColor),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Medicine information".tr,
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          color: BlackColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "${"Total Item".tr} ${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderProductData.length}",
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          color: gradient.defoultColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height * 0.02),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: preScriptionControllre
                                        .preDetailsInfo
                                        ?.pOrderProductList
                                        .orderProductData
                                        .length,
                                    itemBuilder: (context, index) {
                                      return bgdecoration(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      preScriptionControllre
                                                              .preDetailsInfo
                                                              ?.pOrderProductList
                                                              .orderProductData[
                                                                  index]
                                                              .productName ??
                                                          "",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontFamily: FontFamily
                                                            .gilroyBold,
                                                        color: BlackColor,
                                                        fontSize: 15,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(
                                            //     height: Get.height * 0.006),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderProductData[index].productQuantity}x",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    color: BlackColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.03),
                                                Text(
                                                  "${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderProductData[index].productPrice}${currency}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    color: BlackColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.02),
                                                Text(
                                                  "${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderProductData[index].productDiscount}${currency}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    color: greyColor
                                                        .withOpacity(0.5),
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      preScriptionControllre.preDetailsInfo?.pOrderProductList
                                  .additionalNote !=
                              ""
                          ? SizedBox(height: Get.height * 0.02)
                          : SizedBox(),
                      preScriptionControllre.preDetailsInfo?.pOrderProductList
                                  .additionalNote !=
                              ""
                          ? Container(
                              width: Get.size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: WhiteColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Note".tr,
                                      style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          color: BlackColor,
                                          fontSize: 16)),
                                  SizedBox(height: Get.height * 0.02),
                                  Text(
                                    preScriptionControllre
                                            .preDetailsInfo
                                            ?.pOrderProductList
                                            .additionalNote ??
                                        "",
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyMedium,
                                      color: BlackColor,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      preScriptionControllre.preDetailsInfo?.pOrderProductList
                                  .pMethodName !=
                              ""
                          ? SizedBox(height: Get.height * 0.02)
                          : SizedBox(),
                      preScriptionControllre.preDetailsInfo?.pOrderProductList
                                  .pMethodName !=
                              ""
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: WhiteColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Payment Information".tr,
                                      style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          color: BlackColor,
                                          fontSize: 16)),
                                  SizedBox(height: Get.height * 0.02),
                                  bgdecoration(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${"Order ID:".tr} #${oID}",
                                            style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                color: BlackColor,
                                                fontSize: 16)),
                                        SizedBox(height: Get.height * 0.015),
                                        Paymentinfo(
                                            text: "Status".tr,
                                            infotext: preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .orderStatus ??
                                                ""),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Order Type".tr,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyMedium,
                                                    color: Colors.grey.shade400,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  preScriptionControllre
                                                          .preDetailsInfo
                                                          ?.pOrderProductList
                                                          .orderType ??
                                                      "",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    color:
                                                        gradient.defoultColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: Get.height * 0.015),
                                          ],
                                        ),
                                        preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .orderType ==
                                                "Self"
                                            ? Paymentinfo(
                                                text: "Time Slot".tr,
                                                infotext: preScriptionControllre
                                                        .preDetailsInfo
                                                        ?.pOrderProductList
                                                        .orderTimeslot ??
                                                    "",
                                              )
                                            : SizedBox(),
                                        Paymentinfo(
                                          text: "Payment Method".tr,
                                          infotext: preScriptionControllre
                                                  .preDetailsInfo
                                                  ?.pOrderProductList
                                                  .pMethodName ??
                                              "",
                                        ),
                                        preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .orderTransactionId !=
                                                ""
                                            ? Paymentinfo(
                                                text: "Transaction ID".tr,
                                                infotext: preScriptionControllre
                                                        .preDetailsInfo
                                                        ?.pOrderProductList
                                                        .orderTransactionId ??
                                                    "",
                                              )
                                            : SizedBox(),
                                        Paymentinfo(
                                          text: "Order Date".tr,
                                          infotext: preScriptionControllre
                                                  .preDetailsInfo
                                                  ?.pOrderProductList
                                                  .orderDate
                                                  .toString()
                                                  .split(" ")
                                                  .first ??
                                              "",
                                        ),
                                        Paymentinfo(
                                            text: "Sub total".tr,
                                            infotext:
                                                "${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderSubTotal}${currency}"),
                                        preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .couponAmount !=
                                                "0"
                                            ? Paymentinfo(
                                                text: "Coupons".tr,
                                                infotext:
                                                    "${preScriptionControllre.preDetailsInfo?.pOrderProductList.couponAmount}${currency}")
                                            : SizedBox(),
                                        preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .wallAmt !=
                                                "0"
                                            ? Paymentinfo(
                                                text: "Wallet".tr,
                                                infotext:
                                                    "${preScriptionControllre.preDetailsInfo?.pOrderProductList.wallAmt}${currency}")
                                            : SizedBox(),
                                        preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .orderType ==
                                                "Delivery"
                                            ? Paymentinfo(
                                                text: "Delivery Charge".tr,
                                                infotext:
                                                    "${preScriptionControllre.preDetailsInfo?.pOrderProductList.deliveryCharge}${currency}")
                                            : SizedBox(),
                                        Paymentinfo(
                                            text: "Store Charge".tr,
                                            infotext:
                                                "${preScriptionControllre.preDetailsInfo?.pOrderProductList.storeCharge}${currency}"),
                                        DottedLine(
                                          dashColor: greyColor,
                                        ),
                                        SizedBox(height: Get.height * 0.02),
                                        Paymentinfo(
                                            text: "Total Amount".tr,
                                            infotext:
                                                "${preScriptionControllre.preDetailsInfo?.pOrderProductList.orderTotal}${currency}"),
                                        GetBuilder<PreScriptionControllre>(
                                            builder: (context) {
                                          double netPayable = double.parse(
                                                  preScriptionControllre
                                                          .preDetailsInfo
                                                          ?.pOrderProductList
                                                          .orderTotal
                                                          .toString() ??
                                                      "") -
                                              double.parse(
                                                  preScriptionControllre
                                                          .preDetailsInfo
                                                          ?.pOrderProductList
                                                          .wallAmt
                                                          .toString() ??
                                                      "") -
                                              double.parse(
                                                  preScriptionControllre
                                                          .preDetailsInfo
                                                          ?.pOrderProductList
                                                          .couponAmount
                                                          .toString() ??
                                                      "");

                                          return Paymentinfo(
                                              text: "Net Payable".tr,
                                              infotext:
                                                  "${netPayable.toStringAsFixed(1)}${currency}");
                                        }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: Get.height * 0.02),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: WhiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Store Details".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                color: BlackColor,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.02),
                            bgdecoration(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        // SizedBox(width: Get.width * 0.02),
                                        SizedBox(
                                          width: Get.width * 0.65,
                                          child: Text(
                                            preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .storeTitle ??
                                                "",
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: BlackColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: gradient.defoultColor,
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(color: Colors.grey.shade300),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/location-pin.png",
                                            height: 20,
                                            width: 20,
                                            color: gradient.defoultColor,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              preScriptionControllre
                                                      .preDetailsInfo
                                                      ?.pOrderProductList
                                                      .storeAddress ??
                                                  "",
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyMedium,
                                                color: greyColor,
                                                fontSize: 15,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/phone-call.png",
                                            height: 20,
                                            width: 20,
                                            color: gradient.defoultColor,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            preScriptionControllre
                                                    .preDetailsInfo
                                                    ?.pOrderProductList
                                                    .storeMobile ??
                                                "",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
                                              color: greyColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      preScriptionControllre.preDetailsInfo?.pOrderProductList
                                  .riderTitle !=
                              ""
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: WhiteColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery Boy Details".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: BlackColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.02),
                                  bgdecoration(
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/user.png",
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(width: Get.width * 0.02),
                                              SizedBox(
                                                width: Get.width * 0.65,
                                                child: Text(
                                                  preScriptionControllre
                                                          .preDetailsInfo
                                                          ?.pOrderProductList
                                                          .riderTitle ??
                                                      "",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    color: BlackColor,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: gradient.defoultColor,
                                                size: 16,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: Get.height * 0.01),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(
                                                color: Colors.grey.shade300),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/phone-call.png",
                                                  height: 20,
                                                  width: 20,
                                                  color: gradient.defoultColor,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  preScriptionControllre
                                                          .preDetailsInfo
                                                          ?.pOrderProductList
                                                          .riderMobile ??
                                                      "",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyMedium,
                                                    color: greyColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      if (preScriptionControllre.preDetailsInfo?.pOrderProductList.flowId ==
                          "0") ...{
                        ordermassage(massage: "Waiting For Store Decision")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "1") ...{
                        ordermassage(
                            massage:
                                "You are now waiting for the medicine to be added to your cart")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "2") ...{
                        ordermassage(massage: "Cancelled By Store")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "3") ...{
                        ordermassage(
                            massage:
                                "Your cart is awaiting your acceptance or approval")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "4") ...{
                        ordermassage(
                            massage:
                                "You have accepted your cart and are now waiting to make a payment for the items in your order")
                      } else if (preScriptionControllre.preDetailsInfo?.pOrderProductList.flowId == "5" &&
                          preScriptionControllre
                                  .preDetailsInfo?.pOrderProductList.orderType ==
                              "Self") ...{
                        ordermassage(
                            massage:
                                "Kindly collect your order from the store.")
                      } else if (preScriptionControllre.preDetailsInfo?.pOrderProductList.flowId == "5" &&
                          preScriptionControllre
                                  .preDetailsInfo?.pOrderProductList.orderType ==
                              "Delivery") ...{
                        ordermassage(
                            massage:
                                "Payment Done Waiting For Assign Delivery Boy")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "6") ...{
                        ordermassage(
                            massage: "Waiting For Delivery Boy Decision")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "7") ...{
                        ordermassage(massage: "Delivery Boy Accepted Order")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "8") ...{
                        ordermassage(
                            massage:
                                "Delivery Boy Reject Order Find Another Delivery Boy.")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "9") ...{
                        ordermassage(massage: "Delivery Boy PickUp Order")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "10") ...{
                        ordermassage(massage: "Delivery Boy Completed Order")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "11") ...{
                        ordermassage(massage: "Cancelled By You")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "12") ...{
                        ordermassage(massage: "Delivery Boy Cancelled Order")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "13") ...{
                        ordermassage(massage: "Order Completed")
                      } else if (preScriptionControllre
                              .preDetailsInfo?.pOrderProductList.flowId ==
                          "14") ...{
                        ordermassage(massage: "Cart Rejected By You")
                      },
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )
                : SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ),
        );
      }),
    );
  }

  ticketCancell(orderId) {
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: WhiteColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    Container(
                        height: 6,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(25))),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "Select Reason".tr,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Gilroy Bold',
                          color: BlackColor),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "Please select the reason for cancellation:".tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Gilroy Medium',
                          color: BlackColor),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    ListView.builder(
                      itemCount: cancelList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return RadioListTile(
                          dense: true,
                          value: i,
                          activeColor: Color(0xFF246BFD),
                          tileColor: BlackColor,
                          selected: true,
                          groupValue: selectedRadioTile,
                          title: Text(
                            cancelList[i]["title"],
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Gilroy Medium',
                                color: BlackColor),
                          ),
                          onChanged: (val) {
                            setState(() {});
                            selectedRadioTile = val;
                            rejectmsg = cancelList[i]["title"];
                          },
                        );
                      },
                    ),
                    rejectmsg == "Others".tr
                        ? SizedBox(
                            height: 50,
                            width: Get.width * 0.85,
                            child: TextField(
                              controller: note,
                              decoration: InputDecoration(
                                  isDense: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF246BFD), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF246BFD), width: 1),
                                  ),
                                  hintText: 'Enter reason'.tr,
                                  hintStyle: TextStyle(
                                      fontFamily: 'Gilroy Medium',
                                      fontSize: Get.size.height / 55,
                                      color: Colors.grey)),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: Get.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Get.width * 0.35,
                          height: Get.height * 0.05,
                          child: ticketbutton(
                            title: "Cancel".tr,
                            bgColor: RedColor,
                            titleColor: Colors.white,
                            ontap: () {
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.35,
                          height: Get.height * 0.05,
                          child: ticketbutton(
                            title: "Confirm".tr,
                            gradient1: gradient.btnGradient,
                            titleColor: Colors.white,
                            ontap: () {
                              preScriptionControllre.makeDicision(
                                oID: orderId,
                                status: "2",
                                reson: rejectmsg == "Others".tr
                                    ? note.text
                                    : rejectmsg,
                              );
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.04),
                  ],
                ),
              ),
            );
          });
        });
  }

  List cancelList = [
    {"id": 1, "title": "Financing fell through".tr},
    {"id": 2, "title": "Inspection issues".tr},
    {"id": 3, "title": "Change in financial situation".tr},
    {"id": 4, "title": "Title issues".tr},
    {"id": 5, "title": "Seller changes their mind".tr},
    {"id": 6, "title": "Competing offer".tr},
    {"id": 7, "title": "Personal reasons".tr},
    {"id": 8, "title": "Others".tr},
  ];

  ticketbutton(
      {Function()? ontap,
      String? title,
      Color? bgColor,
      titleColor,
      Gradient? gradient1}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: Get.height * 0.04,
        width: Get.width * 0.40,
        decoration: BoxDecoration(
          color: bgColor,
          gradient: gradient1,
          borderRadius: (BorderRadius.circular(18)),
        ),
        child: Center(
          child: Text(title!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: titleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  fontFamily: 'Gilroy Medium')),
        ),
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
    quntaty,
  }) async {
    String? id = id1;
    String? price = price1.toString();
    int? qty = int.parse(qtys);
    qty = qty + 1;
    cart = Hive.box<CartItem>('cart');
    final newItem = CartItem();
    newItem.id = id;
    newItem.price = double.parse(price1.toString());
    newItem.quantity = int.parse(quntaty);
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
    print("<<<<<<<<SPrice1>>>>>>>>" + sPrice1.toString());

    print("-------------------------------------------------");

    if (qtys == "0") {
      cart.put(id, newItem);
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

  Paymentinfo({String? text, infotext}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text!,
              style: TextStyle(
                fontFamily: FontFamily.gilroyMedium,
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
            ),
            Text(
              infotext,
              style: TextStyle(
                fontFamily: FontFamily.gilroyBold,
                color: BlackColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.015),
      ],
    );
  }

  Future reviewSheet() {
    return Get.bottomSheet(
      isScrollControlled: true,
      GetBuilder<PreScriptionControllre>(builder: (context) {
        return Container(
          height: 520,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Leave a Review".tr,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: FontFamily.gilroyBold,
                  color: BlackColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Divider(
                  color: greytext,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "How was your experience".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: FontFamily.gilroyBold,
                  color: BlackColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RatingBar(
                initialRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: Image.asset(
                    'assets/starBold.png',
                    color: gradient.defoultColor,
                  ),
                  half: Image.asset(
                    'assets/star-half.png',
                    color: gradient.defoultColor,
                  ),
                  empty: Image.asset(
                    'assets/star.png',
                    color: gradient.defoultColor,
                  ),
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  preScriptionControllre.totalRateUpdate(rating);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Divider(
                  color: greytext,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Text(
                  "Write Your Review".tr,
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: FontFamily.gilroyBold,
                    color: BlackColor,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: TextFormField(
                  controller: preScriptionControllre.ratingText,
                  minLines: 4,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: BlackColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "Your review here...".tr,
                    hintStyle: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      fontSize: 15,
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyMedium,
                    fontSize: 16,
                    color: BlackColor,
                  ),
                ),
                decoration: BoxDecoration(
                  color: WhiteColor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Divider(
                  color: greytext,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: Text(
                          "Maybe Later".tr,
                          style: TextStyle(
                            color: blueColor,
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFeef4ff),
                          borderRadius: BorderRadius.circular(45),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        preScriptionControllre.orderReviewApi(orderID: oID);
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: Text(
                          "Submit".tr,
                          style: TextStyle(
                            color: WhiteColor,
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(45),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          decoration: BoxDecoration(
            color: WhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        );
      }),
    );
  }
}

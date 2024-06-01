// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sort_child_properties_last, must_be_immutable, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pharmafast/Api/config.dart';
import 'package:pharmafast/controller/myorder_controller.dart';
import 'package:pharmafast/model/fontfamily_model.dart';
import 'package:pharmafast/screen/about_screen.dart';
import 'package:pharmafast/screen/home_screen.dart';
import 'package:pharmafast/utils/Colors.dart';
import 'package:pharmafast/utils/Custom_widget.dart';

class OrderdetailsScreen extends StatefulWidget {
  const OrderdetailsScreen({super.key});

  @override
  State<OrderdetailsScreen> createState() => _OrderdetailsScreenState();
}

class _OrderdetailsScreenState extends State<OrderdetailsScreen> {
  MyOrderController myOrderController = Get.find();

  String oID = Get.arguments["oID"];
  bool usercontect = false;

  @override
  void initState() {
    super.initState();
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
          backgroundColor: WhiteColor),
      bottomNavigationBar: GetBuilder<MyOrderController>(builder: (context) {
        return myOrderController
                            .orderInformetionInfo?.orderProductList.flowId ==
                        "7" &&
                    myOrderController
                            .orderInformetionInfo?.orderProductList.isRate ==
                        "0" ||
                myOrderController
                            .orderInformetionInfo?.orderProductList.flowId ==
                        "10" &&
                    myOrderController
                            .orderInformetionInfo?.orderProductList.isRate ==
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: GetBuilder<MyOrderController>(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: myOrderController.isLoading
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * 0.02),
                      myOrderController.orderInformetionInfo!.orderProductList
                              .orderPrescription.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
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
                                      itemCount: myOrderController
                                          .orderInformetionInfo
                                          ?.orderProductList
                                          .orderPrescription
                                          .length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(
                                              FullScreenImage(
                                                imageUrl:
                                                    "${Config.imageUrl}${myOrderController.orderInformetionInfo?.orderProductList.orderPrescription[index] ?? ""}",
                                                tag: "generate_a_unique_tag",
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: Get.height * 0.2,
                                            width: Get.width * 0.4,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    "assets/ezgif.com-crop.gif",
                                                placeholderFit: BoxFit.cover,
                                                image:
                                                    "${Config.imageUrl}${myOrderController.orderInformetionInfo?.orderProductList.orderPrescription[index]}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: transparent,
                                            ),
                                          ),
                                        );
                                      },
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
                            color: WhiteColor),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  "${"Total Item".tr} ${myOrderController.orderInformetionInfo?.orderProductList.orderProductData.length}",
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
                              itemCount: myOrderController.orderInformetionInfo
                                  ?.orderProductList.orderProductData.length,
                              itemBuilder: (context, index) {
                                return bgdecoration(
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                myOrderController
                                                        .orderInformetionInfo
                                                        ?.orderProductList
                                                        .orderProductData[index]
                                                        .productName ??
                                                    "",
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.gilroyBold,
                                                  color: BlackColor,
                                                  fontSize: 15,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.005),
                                      Row(
                                        children: [
                                          Text(
                                            "${myOrderController.orderInformetionInfo?.orderProductList.orderProductData[index].productQuantity}x",
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: BlackColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.03),
                                          Text(
                                            "${myOrderController.orderInformetionInfo?.orderProductList.orderProductData[index].productPrice}${currency}",
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: BlackColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Text(
                                            "${myOrderController.orderInformetionInfo?.orderProductList.orderProductData[index].productDiscount}${currency}",
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: greyColor.withOpacity(0.5),
                                              decoration:
                                                  TextDecoration.lineThrough,
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
                      ),
                      SizedBox(height: Get.height * 0.02),
                      myOrderController.orderInformetionInfo?.orderProductList
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
                                    myOrderController.orderInformetionInfo
                                            ?.orderProductList.additionalNote ??
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
                            Text("Payment Information".tr,
                                style: TextStyle(
                                    fontFamily: FontFamily.gilroyBold,
                                    color: BlackColor,
                                    fontSize: 16)),
                            SizedBox(height: Get.height * 0.02),
                            bgdecoration(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${"Order ID:".tr} #${oID}",
                                      style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          color: BlackColor,
                                          fontSize: 16)),
                                  SizedBox(height: Get.height * 0.015),
                                  Paymentinfo(
                                      text: "Status".tr,
                                      infotext: myOrderController
                                              .orderInformetionInfo
                                              ?.orderProductList
                                              .orderStatus ??
                                          ""),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                            myOrderController
                                                    .orderInformetionInfo
                                                    ?.orderProductList
                                                    .orderType ??
                                                "",
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: gradient.defoultColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * 0.015),
                                    ],
                                  ),
                                  myOrderController.orderInformetionInfo
                                              ?.orderProductList.orderType ==
                                          "Self"
                                      ? Paymentinfo(
                                          text: "Time Slot".tr,
                                          infotext: myOrderController
                                                  .orderInformetionInfo
                                                  ?.orderProductList
                                                  .orderTimeslot ??
                                              "",
                                        )
                                      : SizedBox(),
                                  Paymentinfo(
                                    text: "Payment Method".tr,
                                    infotext: myOrderController
                                            .orderInformetionInfo
                                            ?.orderProductList
                                            .pMethodName ??
                                        "",
                                  ),
                                  myOrderController
                                              .orderInformetionInfo
                                              ?.orderProductList
                                              .orderTransactionId !=
                                          "0"
                                      ? Paymentinfo(
                                          text: "Transaction ID".tr,
                                          infotext: myOrderController
                                                  .orderInformetionInfo
                                                  ?.orderProductList
                                                  .orderTransactionId ??
                                              "",
                                        )
                                      : SizedBox(),
                                  Paymentinfo(
                                    text: "Order Date".tr,
                                    infotext: myOrderController
                                            .orderInformetionInfo
                                            ?.orderProductList
                                            .orderDate
                                            .toString()
                                            .split(" ")
                                            .first ??
                                        "",
                                  ),
                                  Paymentinfo(
                                      text: "Sub total".tr,
                                      infotext:
                                          "${myOrderController.orderInformetionInfo?.orderProductList.orderSubTotal}${currency}"),
                                  myOrderController.orderInformetionInfo
                                              ?.orderProductList.couponAmount !=
                                          "0"
                                      ? Paymentinfo(
                                          text: "Coupons".tr,
                                          infotext:
                                              "${myOrderController.orderInformetionInfo?.orderProductList.couponAmount}${currency}")
                                      : SizedBox(),
                                  myOrderController.orderInformetionInfo
                                              ?.orderProductList.wallAmt !=
                                          "0"
                                      ? Paymentinfo(
                                          text: "Wallet".tr,
                                          infotext:
                                              "${myOrderController.orderInformetionInfo?.orderProductList.wallAmt}${currency}")
                                      : SizedBox(),
                                  myOrderController.orderInformetionInfo
                                              ?.orderProductList.orderType ==
                                          "Delivery"
                                      ? Paymentinfo(
                                          text: "Delivery Charge".tr,
                                          infotext:
                                              "${myOrderController.orderInformetionInfo?.orderProductList.deliveryCharge}${currency}")
                                      : SizedBox(),
                                  Paymentinfo(
                                      text: "Store Charge".tr,
                                      infotext:
                                          "${myOrderController.orderInformetionInfo?.orderProductList.storeCharge}${currency}"),
                                  DottedLine(
                                    dashColor: greyColor,
                                  ),
                                  SizedBox(height: Get.height * 0.02),
                                  Paymentinfo(
                                      text: "Total Amount".tr,
                                      infotext:
                                          "${myOrderController.orderInformetionInfo?.orderProductList.orderTotal}${currency}"),
                                  GetBuilder<MyOrderController>(
                                    builder: (context) {
                                      double netpayment = double.parse(
                                              myOrderController
                                                      .orderInformetionInfo
                                                      ?.orderProductList
                                                      .orderTotal
                                                      .toString() ??
                                                  "") -
                                          double.parse(myOrderController
                                                  .orderInformetionInfo
                                                  ?.orderProductList
                                                  .wallAmt
                                                  .toString() ??
                                              "") -
                                          double.parse(myOrderController
                                                  .orderInformetionInfo
                                                  ?.orderProductList
                                                  .couponAmount
                                                  .toString() ??
                                              "");
                                      return Paymentinfo(
                                          text: "Net Payable".tr,
                                          infotext:
                                              "${netpayment.toStringAsFixed(1)}${currency}");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      myOrderController.orderInformetionInfo?.orderProductList
                                  .orderType ==
                              "Delivery"
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
                                    "Delivery Address".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: BlackColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  bgdecoration(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/location-pin.png",
                                              height: 20,
                                              width: 20,
                                              color: gradient.defoultColor,
                                            ),
                                            SizedBox(width: Get.width * 0.02),
                                            Text(
                                              myOrderController
                                                      .orderInformetionInfo
                                                      ?.orderProductList
                                                      .orderAddressType ??
                                                  "",
                                              style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyBold,
                                                color: BlackColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(color: Colors.grey.shade300),
                                        Text(
                                          myOrderController
                                                  .orderInformetionInfo
                                                  ?.orderProductList
                                                  .customerAddress ??
                                              "",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyMedium,
                                            color: greycolor,
                                            fontSize: 15,
                                          ),
                                        ),
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
                                            myOrderController
                                                    .orderInformetionInfo
                                                    ?.orderProductList
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
                                              myOrderController
                                                      .orderInformetionInfo
                                                      ?.orderProductList
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
                                            myOrderController
                                                    .orderInformetionInfo
                                                    ?.orderProductList
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
                      myOrderController.orderInformetionInfo?.orderProductList
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
                                                color: gradient.defoultColor,
                                              ),
                                              SizedBox(width: Get.width * 0.02),
                                              SizedBox(
                                                width: Get.width * 0.65,
                                                child: Text(
                                                  myOrderController
                                                          .orderInformetionInfo
                                                          ?.orderProductList
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
                                                  myOrderController
                                                          .orderInformetionInfo
                                                          ?.orderProductList
                                                          .riderMobile ??
                                                      "",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyMedium,
                                                    color: BlackColor,
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
                      SizedBox(height: Get.height * 0.02),
                      if (myOrderController.orderInformetionInfo?.orderProductList.flowId ==
                          "0") ...{
                        ordermassage(massage: "Waiting For Store Decision")
                      } else if (myOrderController.orderInformetionInfo?.orderProductList.flowId == "1" &&
                          myOrderController.orderInformetionInfo
                                  ?.orderProductList.orderType ==
                              "Self") ...{
                        ordermassage(
                            massage:
                                "Your order has been accepted and is now being prepared for pickup")
                      } else if (myOrderController.orderInformetionInfo
                                  ?.orderProductList.flowId ==
                              "1" &&
                          myOrderController.orderInformetionInfo
                                  ?.orderProductList.orderType ==
                              "Delivery") ...{
                        ordermassage(
                            massage:
                                "Your order has been accepted and is now awaiting assignment to a delivery boy")
                      } else if (myOrderController
                              .orderInformetionInfo?.orderProductList.flowId ==
                          "2") ...{
                        ordermassage(massage: "Cancelled By Store")
                      } else if (myOrderController
                              .orderInformetionInfo?.orderProductList.flowId ==
                          "3") ...{
                        ordermassage(
                            massage: "Waiting For Delivery Boy Decision")
                      } else if (myOrderController
                              .orderInformetionInfo?.orderProductList.flowId ==
                          "4") ...{
                        ordermassage(massage: "Delivery Boy Accepted Order")
                      } else if (myOrderController
                              .orderInformetionInfo?.orderProductList.flowId ==
                          "5") ...{
                        ordermassage(massage: "Delivery Boy Reject Order")
                      } else if (myOrderController
                              .orderInformetionInfo?.orderProductList.flowId ==
                          "6") ...{
                        ordermassage(massage: "Delivery Boy PickUp Order")
                      } else if (myOrderController
                              .orderInformetionInfo?.orderProductList.flowId ==
                          "7") ...{
                        ordermassage(massage: "Delivery Boy Completed Order")
                      } else if (myOrderController
                              .orderInformetionInfo?.orderProductList.flowId ==
                          "8") ...{
                        ordermassage(massage: "Cancelled By You")
                      } else if (myOrderController
                              .orderInformetionInfo?.orderProductList.flowId ==
                          "9") ...{
                        ordermassage(massage: "Delivery Boy Cancelled Order")
                      } else if (myOrderController
                              .orderInformetionInfo?.orderProductList.flowId ==
                          "10") ...{
                        ordermassage(massage: "Order Completed")
                      },
                      SizedBox(
                        height: 25,
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
          );
        }),
      ),
    );
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
      GetBuilder<MyOrderController>(builder: (context) {
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
                  myOrderController.totalRateUpdate(rating);
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
                  controller: myOrderController.ratingText,
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
                        // bookingDetailsController.reviewUpdateApi(
                        //   bookId: bookingDetailsController
                        //       .bookDetailsInfo?.bookdetails.bookId,
                        // );
                        myOrderController.orderReviewApi(orderID: oID);
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

// To parse this JSON data, do
//
//     final orderInformetionInfo = orderInformetionInfoFromJson(jsonString);

import 'dart:convert';

OrderInformetionInfo orderInformetionInfoFromJson(String str) =>
    OrderInformetionInfo.fromJson(json.decode(str));

String orderInformetionInfoToJson(OrderInformetionInfo data) =>
    json.encode(data.toJson());

class OrderInformetionInfo {
  OrderInformetionInfo({
    required this.orderProductList,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  OrderProductList orderProductList;
  String responseCode;
  String result;
  String responseMsg;

  factory OrderInformetionInfo.fromJson(Map<String, dynamic> json) =>
      OrderInformetionInfo(
        orderProductList: OrderProductList.fromJson(json["OrderProductList"]),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "OrderProductList": orderProductList.toJson(),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class OrderProductList {
  OrderProductList({
    required this.orderDate,
    required this.riderTitle,
    required this.riderImage,
    required this.riderMobile,
    required this.pMethodName,
    required this.customerAddress,
    required this.deliveryCharge,
    required this.couponAmount,
    required this.orderTotal,
    required this.orderSubTotal,
    required this.commentReject,
    required this.storeTitle,
    required this.storeAddress,
    required this.orderAddress,
    required this.orderAddressType,
    required this.storeImg,
    required this.storeMobile,
    required this.orderType,
    required this.isRate,
    required this.orderTimeslot,
    required this.orderPrescription,
    required this.wallAmt,
    required this.orderTransactionId,
    required this.additionalNote,
    required this.orderStatus,
    required this.flowId,
    required this.storeCharge,
    required this.orderProductData,
  });

  DateTime orderDate;
  String riderTitle;
  String riderImage;
  String riderMobile;
  String pMethodName;
  String customerAddress;
  String deliveryCharge;
  String couponAmount;
  String orderTotal;
  String orderSubTotal;
  String commentReject;
  String storeTitle;
  String storeAddress;
  String orderAddress;
  String orderAddressType;
  String storeImg;
  String storeMobile;
  String orderType;
  String isRate;
  String orderTimeslot;
  List<String> orderPrescription;
  String wallAmt;
  String orderTransactionId;
  String additionalNote;
  String orderStatus;
  String flowId;
  String storeCharge;
  List<OrderProductDatum> orderProductData;

  factory OrderProductList.fromJson(Map<String, dynamic> json) =>
      OrderProductList(
        orderDate: DateTime.parse(json["order_date"]),
        riderTitle: json["rider_title"],
        riderImage: json["rider_image"],
        riderMobile: json["rider_mobile"],
        pMethodName: json["p_method_name"],
        customerAddress: json["customer_address"],
        deliveryCharge: json["Delivery_charge"],
        couponAmount: json["Coupon_Amount"],
        orderTotal: json["Order_Total"],
        orderSubTotal: json["Order_SubTotal"],
        commentReject: json["comment_reject"].toString(),
        storeTitle: json["store_title"],
        storeAddress: json["store_address"],
        orderAddress: json["order_address"],
        orderAddressType: json["order_address_type"],
        storeImg: json["store_img"],
        storeMobile: json["store_mobile"],
        orderType: json["order_type"],
        isRate: json["is_rate"],
        orderTimeslot: json["order_timeslot"],
        orderPrescription:
            List<String>.from(json["order_prescription"].map((x) => x)),
        wallAmt: json["wall_amt"],
        orderTransactionId: json["Order_Transaction_id"],
        additionalNote: json["Additional_Note"],
        orderStatus: json["Order_Status"],
        flowId: json["Flow_id"],
        storeCharge: json["store_charge"],
        orderProductData: List<OrderProductDatum>.from(
            json["Order_Product_Data"]
                .map((x) => OrderProductDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_date":
            "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "rider_title": riderTitle,
        "rider_image": riderImage,
        "rider_mobile": riderMobile,
        "p_method_name": pMethodName,
        "customer_address": customerAddress,
        "Delivery_charge": deliveryCharge,
        "Coupon_Amount": couponAmount,
        "Order_Total": orderTotal,
        "Order_SubTotal": orderSubTotal,
        "comment_reject": commentReject,
        "store_title": storeTitle,
        "store_address": storeAddress,
        "order_address": orderAddress,
        "order_address_type": orderAddressType,
        "store_img": storeImg,
        "store_mobile": storeMobile,
        "order_type": orderType,
        "is_rate": isRate,
        "order_timeslot": orderTimeslot,
        "order_prescription":
            List<dynamic>.from(orderPrescription.map((x) => x)),
        "wall_amt": wallAmt,
        "Order_Transaction_id": orderTransactionId,
        "Additional_Note": additionalNote,
        "Order_Status": orderStatus,
        "Flow_id": flowId,
        "store_charge": storeCharge,
        "Order_Product_Data":
            List<dynamic>.from(orderProductData.map((x) => x.toJson())),
      };
}

class OrderProductDatum {
  OrderProductDatum({
    required this.productQuantity,
    required this.productName,
    required this.productDiscount,
    required this.productPrice,
    required this.isRequired,
    required this.productTotal,
  });

  String productQuantity;
  String productName;
  int productDiscount;
  String productPrice;
  String isRequired;
  double productTotal;

  factory OrderProductDatum.fromJson(Map<String, dynamic> json) =>
      OrderProductDatum(
        productQuantity: json["Product_quantity"],
        productName: json["Product_name"],
        productDiscount: json["Product_discount"],
        productPrice: json["Product_price"],
        isRequired: json["is_required"],
        productTotal: json["Product_total"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Product_quantity": productQuantity,
        "Product_name": productName,
        "Product_discount": productDiscount,
        "Product_price": productPrice,
        "is_required": isRequired,
        "Product_total": productTotal,
      };
}

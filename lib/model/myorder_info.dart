// To parse this JSON data, do
//
//     final orderInfo = orderInfoFromJson(jsonString);

import 'dart:convert';

OrderInfo orderInfoFromJson(String str) => OrderInfo.fromJson(json.decode(str));

String orderInfoToJson(OrderInfo data) => json.encode(data.toJson());

class OrderInfo {
  OrderInfo({
    required this.orderHistory,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<OrderHistory> orderHistory;
  String responseCode;
  String result;
  String responseMsg;

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        orderHistory: List<OrderHistory>.from(
            json["OrderHistory"].map((x) => OrderHistory.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "OrderHistory": List<dynamic>.from(orderHistory.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class OrderHistory {
  OrderHistory({
    required this.id,
    required this.status,
    required this.storeTitle,
    required this.orderType,
    required this.flowId,
    required this.storeAddress,
    required this.paymentTitle,
    required this.storeImg,
    required this.orderDate,
    required this.total,
  });

  String id;
  String status;
  String storeTitle;
  String orderType;
  String flowId;
  String storeAddress;
  String paymentTitle;
  String storeImg;
  DateTime orderDate;
  String total;

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
        id: json["id"],
        status: json["status"],
        storeTitle: json["store_title"],
        orderType: json["order_type"],
        flowId: json["Flow_id"],
        storeAddress: json["store_address"],
        paymentTitle: json["payment_title"],
        storeImg: json["store_img"],
        orderDate: DateTime.parse(json["order_date"]),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "store_title": storeTitle,
        "order_type": orderType,
        "Flow_id": flowId,
        "store_address": storeAddress,
        "payment_title": paymentTitle,
        "store_img": storeImg,
        "order_date":
            "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "total": total,
      };
}

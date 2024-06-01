// To parse this JSON data, do
//
//     final priscriptionInfo = priscriptionInfoFromJson(jsonString);

import 'dart:convert';

PriscriptionInfo priscriptionInfoFromJson(String str) =>
    PriscriptionInfo.fromJson(json.decode(str));

String priscriptionInfoToJson(PriscriptionInfo data) =>
    json.encode(data.toJson());

class PriscriptionInfo {
  PriscriptionInfo({
    required this.pOrderHistory,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<POrderHistory> pOrderHistory;
  String responseCode;
  String result;
  String responseMsg;

  factory PriscriptionInfo.fromJson(Map<String, dynamic> json) =>
      PriscriptionInfo(
        pOrderHistory: List<POrderHistory>.from(
            json["pOrderHistory"].map((x) => POrderHistory.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "pOrderHistory":
            List<dynamic>.from(pOrderHistory.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class POrderHistory {
  POrderHistory({
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

  factory POrderHistory.fromJson(Map<String, dynamic> json) => POrderHistory(
        id: json["id"],
        status: json["status"],
        storeTitle: json["store_title"],
        orderType: json["order_type"].toString(),
        flowId: json["Flow_id"],
        storeAddress: json["store_address"],
        paymentTitle: json["payment_title"].toString(),
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

// To parse this JSON data, do
//
//     final productInfo = productInfoFromJson(jsonString);

import 'dart:convert';

ProductInfo productInfoFromJson(String str) =>
    ProductInfo.fromJson(json.decode(str));

String productInfoToJson(ProductInfo data) => json.encode(data.toJson());

class ProductInfo {
  ProductInfo({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
    required this.productData,
  });

  String responseCode;
  String result;
  String responseMsg;
  ProductData productData;

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
        productData: ProductData.fromJson(json["ProductData"]),
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
        "ProductData": productData.toJson(),
      };
}

class ProductData {
  ProductData({
    required this.id,
    required this.title,
    required this.img,
    required this.aprice,
    required this.sprice,
    required this.qlimit,
    required this.status,
    required this.percentage,
    required this.description,
    required this.disclaimer,
    required this.isRequire,
  });

  String id;
  String title;
  List<String> img;
  String aprice;
  String sprice;
  String qlimit;
  String status;
  int percentage;
  String description;
  String disclaimer;
  String isRequire;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        title: json["title"],
        img: List<String>.from(json["img"].map((x) => x)),
        aprice: json["aprice"],
        sprice: json["sprice"],
        qlimit: json["qlimit"],
        status: json["status"],
        percentage: json["percentage"],
        description: json["description"],
        disclaimer: json["disclaimer"],
        isRequire: json["is_require"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "img": List<dynamic>.from(img.map((x) => x)),
        "aprice": aprice,
        "sprice": sprice,
        "qlimit": qlimit,
        "status": status,
        "percentage": percentage,
        "description": description,
        "disclaimer": disclaimer,
        "is_require": isRequire,
      };
}

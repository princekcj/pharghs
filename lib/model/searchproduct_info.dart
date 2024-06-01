// To parse this JSON data, do
//
//     final searchProductInfo = searchProductInfoFromJson(jsonString);

import 'dart:convert';

SearchProductInfo searchProductInfoFromJson(String str) =>
    SearchProductInfo.fromJson(json.decode(str));

String searchProductInfoToJson(SearchProductInfo data) =>
    json.encode(data.toJson());

class SearchProductInfo {
  SearchProductInfo({
    required this.id,
    required this.title,
    required this.img,
    required this.aprice,
    required this.sprice,
    required this.status,
    required this.percentage,
    required this.qlimit,
    required this.isRequire,
  });

  String id;
  String title;
  String img;
  String aprice;
  String sprice;
  String status;
  int percentage;
  String qlimit;
  String isRequire;

  factory SearchProductInfo.fromJson(Map<String, dynamic> json) =>
      SearchProductInfo(
        id: json["id"],
        title: json["title"],
        img: json["img"],
        aprice: json["aprice"],
        sprice: json["sprice"],
        status: json["status"],
        percentage: json["percentage"],
        qlimit: json["qlimit"],
        isRequire: json["is_require"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "img": img,
        "aprice": aprice,
        "sprice": sprice,
        "status": status,
        "percentage": percentage,
        "qlimit": qlimit,
        "is_require": isRequire,
      };
}

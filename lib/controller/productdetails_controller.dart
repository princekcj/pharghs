// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pharmafast/Api/config.dart';
import 'package:http/http.dart' as http;
import 'package:pharmafast/Api/data_store.dart';
import 'package:pharmafast/model/product_info.dart';

class ProductDetailsController extends GetxController implements GetxService {
  ProductInfo? productInfo;
  bool isLoading = false;

  String logo = "";
  String slogan = "";
  String strName = "";
  String strAddress = "";
  String sID = "";
  int qLimit = 0;
  int? isFev;
  var lat;
  var long;
  int? index;

  getProductDetailsApi({String? pId}) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "pid": pId,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.produtsInformetion);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        productInfo = ProductInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getProductDetails({
    String? sId,
    logo1,
    slogan1,
    strName1,
    straddress,
    qLimit1,
    int? isFev1,
    var lat1,
    var long1,
    int? index1,
  }) {
    logo = logo1 ?? "";
    slogan = slogan1 ?? "";
    strName = strName1 ?? "";
    strAddress = straddress ?? "";
    sID = sId ?? "";
    qLimit = int.parse(qLimit1 ?? "0");
    isFev = isFev1;
    lat = double.parse(lat1);
    long = double.parse(long1);
    index = index1;
    update();
  }
}

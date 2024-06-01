// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pharmafast/Api/config.dart';
import 'package:pharmafast/Api/data_store.dart';
import 'package:pharmafast/model/myorder_info.dart';
import 'package:pharmafast/model/orderinformetion_info.dart';
import 'package:pharmafast/utils/Custom_widget.dart';

class MyOrderController extends GetxController implements GetxService {
  OrderInfo? orderInfo;
  OrderInformetionInfo? orderInformetionInfo;

  bool isLoading = false;
  TextEditingController ratingText = TextEditingController();

  double tRate = 1.0;

  totalRateUpdate(double rating) {
    tRate = rating;
    update();
  }

  myOrderHistory({String? statusWise}) async {
    try {
      isLoading = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "status": statusWise,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.myOrderHistory);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        orderInfo = OrderInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  cancleOrder({String? orderId1, reason}) async {
    try {
      isLoading = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "order_id": orderId1,
        "comment_reject": reason,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.orderCancle);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result["Result"] == "true") {
          myOrderHistory(statusWise: 'Current');
          Get.back();
        }
        showToastMessage(result["ResponseMsg"]);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  myOrderInformetion({String? orderId}) async {
    try {
      isLoading = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "order_id": orderId,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.orderInformetion);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("/*/*/*/*/*/*/*/*/*/" + result.toString());
        orderInformetionInfo = OrderInformetionInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  orderReviewApi({String? orderID}) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "order_id": orderID,
        "total_rate": tRate.toString(),
        "rate_text": ratingText.text != "" ? ratingText.text : "",
      };

      print("!!!!!!!!!!!!!!!!" + map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.orderReview);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        tRate = 1.0;
        ratingText.text = "";
        Get.back();
        myOrderInformetion(orderId: orderID);
        showToastMessage(result["ResponseMsg"]);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

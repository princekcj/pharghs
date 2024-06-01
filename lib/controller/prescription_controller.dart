// ignore_for_file: avoid_print, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pharmafast/Api/config.dart';
import 'package:pharmafast/Api/data_store.dart';
import 'package:pharmafast/model/predetails_info.dart';
import 'package:pharmafast/model/priscription_info.dart';
import 'package:pharmafast/utils/Custom_widget.dart';

class PreScriptionControllre extends GetxController implements GetxService {
  List<String> path = [];
  bool isLoading = false;

  PriscriptionInfo? priscriptionInfo;
  PreDetailsInfo? preDetailsInfo;
  TextEditingController ratingText = TextEditingController();

  double tRate = 1.0;

  bool isOrderLoading = false;

  totalRateUpdate(double rating) {
    tRate = rating;
    update();
  }

  setOrderLoading() {
    isOrderLoading = true;
    update();
  }

  uploadPriscriptionOrder({String? storeID}) async {
    var headers = {
      'content-type': 'application/json',
    };
    try {
      Map<String, String> map = {
        "uid": getData.read("UserLogin")["id"],
        "store_id": storeID ?? "",
        "size": path.length.toString(),
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse(Config.baseurl + Config.orderPriscription));
      request.fields.addAll(map);
      print(":::::::::::::" + map.toString());
      for (int i = 0; i < path.length; i++) {
        request.files
            .add(await http.MultipartFile.fromPath('image$i', '${path[i]}'));
      }
      request.headers.addAll(headers);
      var response = await request.send();
      var responsed = await http.Response.fromStream(response);
      var responseData = json.decode(responsed.body);
      showToastMessage(responseData["ResponseMsg"]);
      priscriptionSuccessFullSheet();
      print("|||||||||" + responseData["ResponseMsg"].toString());
      path = [];
      isOrderLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  myPriscriptionOrderHistory({String? statusWise}) async {
    try {
      isLoading = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "status": statusWise,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.priscriptionHistory);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print(":::::::++++++" + response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(":::::::++++++" + result.toString());

        priscriptionInfo = PriscriptionInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  myPriscriptionInformetion({String? oID}) async {
    try {
      isLoading = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "order_id": oID,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.priscriptionInformetion);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("!!!!!!!!!!!!!!" + response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("!!!!!!!!!!!!!!" + result.toString());
        preDetailsInfo = PreDetailsInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  preOrderCancle({String? oID, reson}) async {
    try {
      isLoading = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "order_id": oID,
        "comment_reject": reson,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.preOrderCancle);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result["Result"] == "true") {
          myPriscriptionOrderHistory(statusWise: 'Current');
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

  makeDicision({String? oID, status, reson}) async {
    try {
      Map map = {
        "oid": oID,
        "status": status,
        "comment_reject": reson,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.makeDecision);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        myPriscriptionInformetion(oID: oID);
        showToastMessage(result["ResponseMsg"]);
      }
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
      Uri uri = Uri.parse(Config.baseurl + Config.priOrderReview);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        tRate = 1.0;
        ratingText.text = "";
        Get.back();
        myPriscriptionInformetion(oID: orderID);
        showToastMessage(result["ResponseMsg"]);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

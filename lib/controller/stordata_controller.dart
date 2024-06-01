// ignore_for_file: avoid_print, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pharmafast/Api/config.dart';
import 'package:pharmafast/Api/data_store.dart';
import 'package:http/http.dart' as http;
import 'package:pharmafast/model/storedata_info.dart';

class StoreDataContoller extends GetxController implements GetxService {
  bool isLoading = false;
  StoreDataInfo? storeDataInfo;

  String storeid = "";

  getStoreData({String? storeId}) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "store_id": storeId,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.storeData);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        storeid = result["StoreInfo"]["store_id"];
        print("SSSSSSSSSS" + storeId.toString());
        storeDataInfo = StoreDataInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}

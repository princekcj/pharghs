// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pharmafast/Api/config.dart';
import 'package:pharmafast/Api/data_store.dart';
import 'package:pharmafast/model/search_info.dart';
import 'package:pharmafast/model/searchproduct_info.dart';
import 'package:pharmafast/screen/onbording_screen.dart';
import 'package:http/http.dart' as http;

class MySearchController extends GetxController implements GetxService {
  List<SearchInfo> searchInfo = [];
  List<SearchProductInfo> searchProductInfo = [];
  bool isLoading = false;

  getSearchStoreData({String? keyWord}) async {
    try {
      isLoading = false;
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "lats": lat,
        "longs": long,
        "keyword": keyWord,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.storeSearchApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        searchInfo = [];
        for (var element in result["SearchStoreData"]) {
          searchInfo.add(SearchInfo.fromJson(element));
        }
        print(result.toString());
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getSearchProductData({String? keyWord, storeID}) async {
    try {
      isLoading = false;
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "store_id": storeID,
        "keyword": keyWord,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.productSearch);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        searchProductInfo = [];
        for (var element in result["SearchProductData"]) {
          searchProductInfo.add(SearchProductInfo.fromJson(element));
        }
        print(result.toString());
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}

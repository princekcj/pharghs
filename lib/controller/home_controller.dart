// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pharmafast/Api/config.dart';
import 'package:http/http.dart' as http;
import 'package:pharmafast/Api/data_store.dart';
import 'package:pharmafast/model/home_info.dart';
import 'package:pharmafast/screen/home_screen.dart';
import 'package:pharmafast/screen/onbording_screen.dart';

class HomePageController extends GetxController implements GetxService {
  HomeInfo? homeInfo;
  bool isLoading = false;

  String isback = "1";

  HomePageController() {
    getHomeDataApi();
  }
  getHomeDataApi() async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "lats": lat.toString(),
        "longs": long.toString(),
      };
      Uri uri = Uri.parse(Config.baseurl + Config.homeDataApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result.toString());
        currency = result["HomeData"]["currency"];
        wallat1 = result["HomeData"]["wallet"];
        homeInfo = HomeInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}

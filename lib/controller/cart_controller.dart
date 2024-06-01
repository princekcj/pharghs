// ignore_for_file: avoid_print, unused_local_variable, depend_on_referenced_packages, prefer_interpolation_to_compose_strings, prefer_collection_literals, unnecessary_cast, unnecessary_brace_in_string_interps, body_might_complete_normally_nullable, await_only_futures, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pharmafast/Api/config.dart';
import 'package:pharmafast/Api/data_store.dart';
import 'package:http/http.dart' as http;
import 'package:pharmafast/controller/prescription_controller.dart';
import 'package:pharmafast/model/address_info.dart';
import 'package:pharmafast/model/cartdata_info.dart';
import 'package:pharmafast/model/coupon_info.dart';
import 'package:pharmafast/model/payment_info.dart';
import 'package:pharmafast/screen/onbording_screen.dart';
import 'package:pharmafast/screen/yourcart_screen.dart';
import 'package:pharmafast/utils/Custom_widget.dart';
import 'package:pharmafast/utils/cart_item.dart';
import 'package:sqflite/sqflite.dart';

class CartController extends GetxController implements GetxService {
  PreScriptionControllre preScriptionControllre = Get.find();
  AddressInfo? addressInfo;
  CouponInfo? couponInfo;
  Database? database;
  PaymentInfo? paymentInfo;
  CartDataInfo? cartDataInfo;

  bool isOrderLoading = false;

  bool isLoading = false;

  String addressLat = "";
  String addressLong = "";
  String addresTitle = "";
  String aType = "";

  double subTotal = 0.0;
  double couponAmt = 0.0;

  String couponId = "";

  String copResult = "";
  String couponMsg = "";

  List isRq = [];

  Box<CartItem> cart = Hive.box<CartItem>('cart');

  File? image;

  CartController() {
    getPaymentListApi();
  }

  setOrderLoading() {
    isOrderLoading = true;
    update();
  }

  setOrderLoadingOff() {
    isOrderLoading = false;
    update();
  }

  getSubTotalClc({double? pPrice, String? subdiv, strCharge}) {
    if (subdiv == "pluse") {
      print("+++++Pluse+++++" + subTotal.toString());
      subTotal = (subTotal + pPrice!);
      print("+++++Pluse+++++" + subTotal.toString());

      update();
    } else if (subdiv == "div") {
      print("-----div-----" + subTotal.toString());
      subTotal = (subTotal - pPrice!);
      print("-----div-----" + subTotal.toString());
      update();
    }
  }

  addressListApi() async {
    try {
      isLoading = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"],
      };
      Uri uri = Uri.parse(Config.baseurl + Config.addressList);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        addressInfo = AddressInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getCouponList({String? sId}) async {
    try {
      isLoading = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "store_id": sId,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.couponList);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        couponInfo = CouponInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getPaymentListApi() async {
    try {
      isLoading = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"],
      };
      Uri uri = Uri.parse(Config.baseurl + Config.paymentList);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        paymentInfo = PaymentInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getCartDataApi({String? storeID}) async {
    try {
      isLoading = false;
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "lats": addressLat != "" ? addressLat : lat,
        "longs": addressLong != "" ? addressLong : long,
        "store_id": storeID,
      };
      print("%%%%%%%%%%%%%%%%^^^^^^^^^^^" + map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.cartDataApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("<<<<<<<<<<>>>>>>>>>>>" + response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print('=======+++++++++========' +
            result["StoreData"]["rest_dcharge"].toString());
        if (getData.read("clc") == true) {
          if (groupValue == 0) {
            if (result["StoreData"]["store_is_pickup"] == "0") {
              total = subTotal +
                  (int.parse(result["StoreData"]["store_charge"].toString()) +
                      int.parse(
                          result["StoreData"]["rest_dcharge"].toString()));
              getTotal = total;
              save("clc", false);
            } else {
              total = (subTotal +
                  int.parse(result["StoreData"]["store_charge"].toString()));
              getTotal = total;
              save("clc", false);
            }
          } else {
            total = subTotal +
                (int.parse(result["StoreData"]["store_charge"].toString()) +
                    int.parse(result["StoreData"]["rest_dcharge"].toString()));
            getTotal = total;
            save("clc", false);
          }
        }
        cartDataInfo = CartDataInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getAddress({String? aLat, aLong, aTitle, aType1}) {
    addressLat = aLat ?? "";
    addressLong = aLong ?? "";
    addresTitle = aTitle ?? "";
    aType = aType1 ?? "";
    update();
  }

  checkCouponDataApi({String? cid}) async {
    try {
      isLoading = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
        "cid": cid,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.couponCheck);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        copResult = result["Result"];
        couponMsg = result["ResponseMsg"];
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  emptyAllDetailsInStore({List<CartItem>? pList1}) {
    for (var i = 0; i < pList1!.length; i++) {
      cart.delete(pList1[i].id);
    }
    subTotal = 0;
    total = 0;
    addressLat = "";
    addressLong = "";
    addresTitle = "";
    subTotal = 0.0;
    couponAmt = 0.0;
    couponId = "";
    copResult = "";
    couponMsg = "";
    preScriptionControllre.path = [];
    isOrderLoading = false;
    update();
  }

  // orderNowApi({
  //   String? wallAmt,
  //   couId,
  //   couAmt,
  //   pMethodId,
  //   storeId,
  //   oType,
  //   oTimeSlot,
  //   fullAddress,
  //   dCharge,
  //   otid,
  //   productTotal,
  //   productSubTotal,
  //   aNote,
  //   lats,
  //   longs,
  //   sCharge,
  //   List<CartItem>? pList,
  //   List? isReq,
  //   List? imgPath,
  // }) async {
  //   try {
  //     List list = [];
  //     var map = Map<String, dynamic>();
  //     map["uid"] = getData.read("UserLogin")["id"];
  //     map["wall_amt"] = wallAmt;
  //     map["cou_id"] = couId;
  //     map["cou_amt"] = couAmt;
  //     map["p_method_id"] = pMethodId;
  //     map["store_id"] = storeId;
  //     map["o_type"] = oType;
  //     map["o_timeslot"] = oTimeSlot;
  //     map["full_address"] = fullAddress;
  //     map["d_charge"] = dCharge;
  //     map["transaction_id"] = otid;
  //     map["product_total"] = productTotal;
  //     map["product_subtotal"] = productSubTotal;
  //     map["a_note"] = aNote;
  //     map["lats"] = lats;
  //     map["longs"] = longs;
  //     map["s_charge"] = sCharge;
  //     map["size"] = imgPath!.length.toString();
  //     for (var i = 0; i < pList!.length; i++) {
  //       CartItem item = CartItem();
  //       Map map = {
  //         "pid": pList[i].id,
  //         "title": pList[i].strTitle,
  //         "cost": pList[i].sPrice,
  //         "qty": pList[i].quantity,
  //         "discount": pList[i].price,
  //         "is_required": pList[i].isRequride,
  //       };
  //       list.add(jsonEncode(map));
  //     }
  //     map["ProductData"] = list.toString();
  //     print("::::::::.....<map>.....::::::::::" + map.toString());
  //     print("£££@@@@@!!!" + imgPath.toString());
  //     if (isReq != []) {
  //       for (var i = 0; i < imgPath.length; i++) {
  //         // String fileName =
  //         //     await http.MultipartFile.fromPath('image$i', '${imgPath[i]}')
  //         //         .toString();
  //         await http.MultipartFile.fromPath(map["image${i}"], '${imgPath[i]}')
  //             .toString();
  //       }
  //     }
  //     print("::::::::.....<Map>.....::::::::::" + map.toString());
  //     Uri uri = Uri.parse(Config.baseurl + Config.orderNow);
  //     var response = await http.post(
  //       uri,
  //       body: map,
  //     );
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       showToastMessage(result["ResponseMsg"]);
  //       emptyAllDetailsInStore(pList1: pList);
  //     }
  //     update();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<Map<String, dynamic>?> doImageUpload(
    Map<String, String> params,
    List<String> imgs,
    List<CartItem> cartViewList1,
  ) async {
    List list = [];
    var headers = {
      'content-type': 'application/json',
    };
    // selectedimage
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(Config.baseurl + Config.orderNow));
      request.fields.addAll(params);
      print("???????????" + params.toString());
      for (var i = 0; i < cartViewList1.length; i++) {
        var map = {
          "pid": cartViewList1[i].id,
          "title": cartViewList1[i].strTitle,
          "cost": cartViewList1[i].sPrice,
          "qty": cartViewList1[i].quantity,
          "discount": cartViewList1[i].price,
          "is_required": cartViewList1[i].isRequride,
        };
        print("££££££££!!!!!!!!!" + map.toString());
        list.add(jsonEncode(map));
      }
      request.fields.addAll({"ProductData": list.toString()});
      for (int i = 0; i < imgs.length; i++) {
        request.files
            .add(await http.MultipartFile.fromPath('image$i', '${imgs[i]}'));
      }
      request.headers.addAll(headers);
      var response = await request.send();
      var responsed = await http.Response.fromStream(response);
      var responseData = json.decode(responsed.body);
      showToastMessage(responseData["ResponseMsg"]);
      OrderPlacedSuccessfully();
      print("|||||||||" + responseData["ResponseMsg"].toString());
      emptyAllDetailsInStore(pList1: cartViewList1);
    } catch (e) {
      print('Error ::: ${e.hashCode}');
      print('Error ::: ${e.toString()}');
    }
  }

  emptyPriscriptionDetails() {
    for (var i = 0; i < cartViewList.length; i++) {
      cart.delete(cartViewList[i].id);
    }
    subTotal = 0;
    total = 0;
    addressLat = "";
    addressLong = "";
    addresTitle = "";
    subTotal = 0.0;
    couponAmt = 0.0;
    couponId = "";
    copResult = "";
    couponMsg = "";
    preScriptionControllre.path = [];
    isOrderLoading = false;
    update();
  }

  priscriptionComplited({
    String? oid,
    wallAmt,
    dCharge,
    couID,
    couAmt,
    subTotal,
    sCharge,
    aType,
    lats,
    oTotal,
    longs,
    otid,
    address,
    aNote,
    pMethodId,
    oType,
    oTimeSlot,
  }) async {
    try {
      Map map = {
        "oid": oid,
        "uid": getData.read("UserLogin")["id"],
        "wall_amt": wallAmt,
        "d_charge": dCharge,
        "cou_id": couID,
        "cou_amt": couAmt,
        "subtotal": subTotal,
        "s_charge": sCharge,
        "a_type": aType,
        "lats": lats,
        "o_total": oTotal,
        "longs": longs,
        "trans_id": otid,
        "address": address,
        "a_note": aNote,
        "p_method_id": pMethodId,
        "o_type": oType,
        "o_timeslot": oTimeSlot,
      };
      print(".+.+.+.+.+.+.+.+.+.+" + map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.priscriptionComplete);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        showToastMessage(result["ResponseMsg"]);
        OrderPlacedSuccessfully();
        emptyPriscriptionDetails();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

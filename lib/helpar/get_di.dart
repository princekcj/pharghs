import 'package:get/get.dart';
import 'package:pharmafast/controller/addlocation_controller.dart';
import 'package:pharmafast/controller/cart_controller.dart';
import 'package:pharmafast/controller/catdetails_controller.dart';
import 'package:pharmafast/controller/fav_controller.dart';
import 'package:pharmafast/controller/home_controller.dart';
import 'package:pharmafast/controller/login_controller.dart';
import 'package:pharmafast/controller/myorder_controller.dart';
import 'package:pharmafast/controller/notification_controller.dart';
import 'package:pharmafast/controller/prescription_controller.dart';
import 'package:pharmafast/controller/productdetails_controller.dart';
import 'package:pharmafast/controller/search_controller.dart';
import 'package:pharmafast/controller/signup_controller.dart';
import 'package:pharmafast/controller/stordata_controller.dart';
import 'package:pharmafast/controller/wallet_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => CatDetailsController());
  Get.lazyPut(() => AddLocationController());
  Get.lazyPut(() => PreScriptionControllre());
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => SignUpController());
  Get.lazyPut(() => HomePageController());
  Get.lazyPut(() => StoreDataContoller());
  Get.lazyPut(() => CartController());
  Get.lazyPut(() => ProductDetailsController());
  Get.lazyPut(() => FavController());
  Get.lazyPut(() => MyOrderController());
  Get.lazyPut(() => WalletController());
  Get.lazyPut(() => MySearchController());
  Get.lazyPut(() => NotificationController());
}

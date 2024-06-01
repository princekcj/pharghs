// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  double? price;

  @HiveField(2)
  int? quantity;

  @HiveField(3)
  double? productPrice;

  @HiveField(4)
  String? strTitle;

  @HiveField(5)
  String? per;

  @HiveField(6)
  String? isRequride;

  @HiveField(7)
  String? qLimit;

  @HiveField(8)
  String? storeID;

  @HiveField(1)
  double? sPrice;

  // @HiveField(4)
  // late String? isRequride;
  // CartItem(this.id, this.price, this.quantity);
}

// ignore_for_file: avoid_renaming_method_parameters, depend_on_referenced_packages

import 'package:hive/hive.dart';
import 'package:pharmafast/utils/cart_item.dart';

class CartItemAdapter extends TypeAdapter<CartItem> {
  @override
  final int typeId = 1;

  @override
  CartItem read(BinaryReader reader) {
    var item = CartItem();
    item.id = reader.readString();
    item.price = reader.readDouble();
    item.quantity = reader.readInt();
    item.productPrice = reader.readDouble();
    item.strTitle = reader.readString();
    item.per = reader.readString();
    item.isRequride = reader.readString();
    item.qLimit = reader.readString();
    item.storeID = reader.readString();
    item.sPrice = reader.readDouble();
    return item;
  }

  @override
  void write(BinaryWriter writer, CartItem item) {
    writer.writeString(item.id.toString());
    writer.writeDouble(item.price!);
    writer.writeInt(item.quantity!);
    writer.writeDouble(item.productPrice!);
    writer.writeString(item.strTitle.toString());
    writer.writeString(item.per.toString());
    writer.writeString(item.isRequride.toString());
    writer.writeString(item.qLimit.toString());
    writer.writeString(item.storeID.toString());
    writer.writeDouble(item.sPrice!);
  }
}

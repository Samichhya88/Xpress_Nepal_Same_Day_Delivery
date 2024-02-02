import 'dart:convert';

import 'package:same_day_delivery_client/model/product.model.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;
  final String addedDate = DateTime.now().toString();
  bool isChecked = false;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
      'addedDate': addedDate,
      'isChecked': isChecked,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      title: json['title'],
      quantity: json['quantity'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }

  String toJsonString() {
    return ("""{
      "id": "$id",
      "title": "$title",
      "quantity": $quantity,
      "price": $price,
      "imageUrl": "$imageUrl",
      "addedDate": "$addedDate",
      "isChecked": $isChecked
    }""");
  }

  factory CartItem.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return CartItem(
      id: json['id'],
      title: json['title'],
      quantity: json['quantity'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }

  factory CartItem.fromProductModel(ProductModel product) {
    return CartItem(
      id: product.productId,
      title: product.productName,
      quantity: 1,
      price: product.productPrice.toDouble(),
      imageUrl: product.productImage,
    );
  }

  void isCheckedToggle() {
    isChecked = !isChecked;
  }
}

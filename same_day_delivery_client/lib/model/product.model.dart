import 'dart:convert';

class ProductModel {
  String productId;
  String sellerId;
  String productName;
  num productPrice;
  String productImage;
  String productDescription;
  String productDate;
  String productLocation;

  ProductModel({
    required this.productId,
    required this.sellerId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productDescription,
    required this.productDate,
    required this.productLocation,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': productId,
      'seller_id': sellerId,
      'product_name': productName,
      'product_price': productPrice,
      'product_image': productImage,
      'product_description': productDescription,
      'product_date': productDate,
      'product_location': productLocation,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['_id'],
      sellerId: json['seller_id'],
      productName: json['product_name'],
      productPrice: json['product_price'],
      productImage: json['product_image'],
      productDescription: json['product_description'],
      productDate: json['product_date'],
      productLocation: json['product_location'] ?? "",
    );
  }

  String toJsonString() {
    return ("""{
      "productID": "$productId",
      "sellerID": "$sellerId",
      "productName": "$productName",
      "productPrice": $productPrice,
      "productImage": "$productImage",
      "productDescription": "$productDescription",
      "productDate": "$productDate",
      "productLocation": "$productLocation"
    }""");
  }

  factory ProductModel.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return ProductModel(
      productId: json['productID'],
      sellerId: json['sellerID'],
      productName: json['productName'],
      productPrice: json['productPrice'],
      productImage: json['productImage'],
      productDescription: json['productDescription'],
      productDate: json['productDate'],
      productLocation: json['productLocation'] ?? "",
    );
  }
}

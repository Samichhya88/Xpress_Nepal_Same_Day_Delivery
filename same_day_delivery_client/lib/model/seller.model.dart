import 'package:same_day_delivery_client/model/product.model.dart';

class Seller {
  String sellerId;
  String sellerName;
  String sellerEmail;
  String sellerPassword;
  String sellerPhone;
  String sellerAddress;
  DateTime sellerDate;
  List<ProductModel>? products;

  Seller({
    required this.sellerId,
    required this.sellerName,
    required this.sellerEmail,
    required this.sellerPassword,
    required this.sellerPhone,
    required this.sellerAddress,
    required this.sellerDate,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': sellerId,
      'seller_name': sellerName,
      'seller_email': sellerEmail,
      'seller_password': sellerPassword,
      'seller_phone': sellerPhone,
      'seller_address': sellerAddress,
      'seller_date': sellerDate,
      'products': products!.map((product) => product.toJson()).toList(),
    };
  }

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      sellerId: json['_id'],
      sellerName: json['seller_name'],
      sellerEmail: json['seller_email'],
      sellerPassword: json['seller_password'],
      sellerPhone: json['seller_phone'],
      sellerAddress: json['seller_address'],
      sellerDate: json['seller_date'],
      products: json['products'] != null
          ? (json['products'] as List)
              .map((product) => ProductModel.fromJson(product))
              .toList()
          : [],
    );
  }
}

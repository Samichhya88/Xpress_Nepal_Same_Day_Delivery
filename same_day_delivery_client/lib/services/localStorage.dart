import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:same_day_delivery_client/model/product.model.dart';
import 'package:same_day_delivery_client/model/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  static Future<bool> saveCartitems(
      {required List<ProductModel> cartItems}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final existingItems = prefs.getStringList('cartItems') ?? [];
      final List<String> cartItemsString = [];
      for (var item in cartItems) {
        //check if the item already exists in the cart
        if (existingItems.contains(item.toJsonString())) {
          continue;
        }
        cartItemsString.add(item.toJsonString());
      }
      existingItems.addAll(cartItemsString);
      prefs.setStringList('cartItems', existingItems);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  static Future<List<ProductModel>?> getCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartItems = prefs.getStringList('cartItems');
    if (cartItems == null) {
      return null;
    }
    final List<ProductModel> cartItemsList = [];
    for (var item in cartItems) {
      cartItemsList.add(ProductModel.fromJsonString(item));
      print(cartItemsList);
    }
    if (kDebugMode) {
      print(cartItemsList);
    }
    return cartItemsList;
  }

  static Future<void> removeCartItems(List<ProductModel> products) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final existingItems = prefs.getStringList('cartItems') ?? [];
    final List<String> cartItemsString = [];
    for (var item in products) {
      cartItemsString.add(item.toJsonString());
    }
    existingItems.removeWhere((element) => cartItemsString.contains(element));
    prefs.setStringList('cartItems', existingItems);
  }

  static Future<void> clearCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartItems');
  }

  static Future<void> saveUserType(String userType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userType', userType);
  }

  static Future<String?> getUserType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userType');
  }

  static Future<void> removeUserType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userType');
  }

  static Future<void> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toJsonString());
  }

  static Future<UserModel?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    print("userString: $userString");
    if (userString == null) {
      return null;
    }
    return UserModel.fromJsonString(userString);
  }

  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  static Future<void> saveRider(String riderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> riders = prefs.getStringList('riders') ?? [];
    if (!riders.contains(riderId)) {
      riders.add(riderId);
    }
    prefs.setStringList('riders', riders);
  }

  static Future<List<String>?> getRider() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('riders');
  }

  static Future<void> rateRider(String riderId, double rating) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("rider-$riderId", rating.toString());
  }

  static Future<double?> getRiderRating(String riderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final rating = prefs.getString("rider-$riderId");
    if (rating == null) {
      return null;
    }
    return double.parse(rating);
  }
}

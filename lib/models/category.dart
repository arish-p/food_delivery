import 'dart:convert';
import 'package:food_dilivery/buffer.dart';
import 'package:food_dilivery/functions/functions.dart';
import 'package:food_dilivery/models/product.dart';

class CategoryFields{
  static const String id = 'id';
  static const String name = 'name';


  static List<String> getFields() => [id, name];
}

class Category{
  int id;
  String name;
  List<Product>? products;

  Category({required this.name, required this.id});



  void saveInBuffer(List<Product> products){
    this.products = products;
  }

  static Category fromJson(Map<String, dynamic> json) => Category(
    id: jsonDecode(json[CategoryFields.id]),
    name: json[CategoryFields.name],
  );
}
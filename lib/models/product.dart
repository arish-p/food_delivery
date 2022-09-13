import 'dart:convert';

class ProductFields {
  static const String id = 'id';
  static const String sectionID = 'section_id';
  static const String name = 'name';
  static const String price = 'price';
  static const String img = 'image';
}



class Product {
  int id;
  int? sectionId;
  String name;
  double price;
  bool? isAction;
  bool? isTrash = false;
  String img;

  Product(
      {required this.id, required this.name, required this.price, required this.img, this.sectionId, this.isAction, this.isTrash});

  static Product fromJson(Map<String, dynamic> json) =>
      Product(
        id: jsonDecode(json[ProductFields.id]),
        sectionId: jsonDecode(json[ProductFields.sectionID]),
        name: json[ProductFields.name],
        price: jsonDecode(json[ProductFields.price]),
        img: json[ProductFields.img],
      );
}
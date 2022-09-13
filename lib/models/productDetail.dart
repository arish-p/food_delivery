import 'dart:convert';

class ProductDetailFields {
  static const String id = 'id';
  static const String sectionID = 'section_id';
  static const String compound = 'compound';
  static const String name = 'name';
  static const String price = 'price';
  static const String img = 'image';
}


class ProductDetail{
  int id;
  int sectionId;
  String name;
  String compound;
  double price;
  bool? isAction;
  bool? isTrash = false;
  String img;
  int? idData;

ProductDetail({required this.id, required this.sectionId, required this.name,
  required this.compound,
  required this.price,
  required this.img,this.idData,  this.isAction, this.isTrash});

  static ProductDetail fromJson(Map<String, dynamic> json) =>
      ProductDetail(
        id: jsonDecode(json[ProductDetailFields.id]),
        sectionId: jsonDecode(json[ProductDetailFields.sectionID]),
        name: json[ProductDetailFields.name],
        compound: json[ProductDetailFields.compound] ,
        price: jsonDecode(json[ProductDetailFields.price]),
        img: json[ProductDetailFields.img],
      );


}
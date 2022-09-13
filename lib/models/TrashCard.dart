import 'package:flutter/cupertino.dart';

class TrashCard with ChangeNotifier {
  String image;
  String name;
  double price;
  int count;

  TrashCard({ required this.image, required this.name, required this.price, required this.count});

  void updateCount(int value){
    count = value;
  }
}
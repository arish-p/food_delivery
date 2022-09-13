import 'package:flutter/cupertino.dart';
import 'package:food_dilivery/models/category.dart';

class CategoriesProvider with ChangeNotifier{
  List<Category>? categories;
  int currentCategory = 0;


  void setCategories(List<Category> categories){
      this.categories = categories;
  }
  void updateCurrentCategory(int index){
    currentCategory = index;
  }
}
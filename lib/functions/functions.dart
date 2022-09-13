import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:food_dilivery/buffer.dart';
import 'package:food_dilivery/data/Images.dart';
import '../data/Categories.dart';
import '../data/dataProvider/OrdersProvider.dart';
import '../googleSheets/foodDiliverySheetsApi.dart';
import '../models/category.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/productDetail.dart';
import 'package:provider/provider.dart';




//Функция получения каттегорий (запускается в самом начале) + добавление в буфер
Future<List<Category>> getCategory() async{

  //Заглушка
 // await Future.delayed(const Duration(seconds: 3));

  Buffer.bufferCategories = await FoodDiliverySheetsApi.getAllCategory();
  Buffer.bufferProducts = await FoodDiliverySheetsApi.getAllProducts();
  Buffer.bufferProductsDetail = await FoodDiliverySheetsApi.getAllDetail();

  return Buffer.bufferCategories!;

}


//Функция получения изображений с акциями + добавление в буфер
Future<List<Image>> getActionImage() async{

  //Заглушка
  await Future.delayed(const Duration(seconds: 3));

  Buffer.bufferActionImage = images;

  return Buffer.bufferActionImage!;

}

Future<List<Product>> getProducts(int id) async{
  await Future.delayed(const Duration(seconds: 3));

  List<Product> products = [];

  for(var product in Buffer.bufferProducts!){
    if(product.sectionId == id){
      products.add(product);
    }
  }
  saveBufferProductsById(id, products);


  return products;
}

void saveBufferProductsById(int id, List<Product> products){
  Buffer.bufferCategories![getIndexBufCategory(id)].products = products;
}


// Проверка на содержание products в category по section_id
bool checkBuf(int id){
  for(var category in Buffer.bufferCategories!){
    if(category.id == id){
      if(category.products == null){
        print(false);
        return false; //буффера каттегорий нет
      }
      else {
        return true; //буффер категорий есть
      }
    }
  }
  return throw ("не существует такого section_id");
}

//
int getIndexBufProducts(int id){

  for(int i =0; i<Buffer.bufferProducts!.length; i++){
    if(Buffer.bufferProducts![i].id == id){
      return i; //Возвращаем индекс в листе данных
    }
  }
  return throw("Не существует такого section_id"); // В буфере есть данные
}

int getIndexBufCategory(int id){
  print(id);

  for(int i =0; i<Buffer.bufferCategories!.length; i++){
    if(Buffer.bufferCategories![i].id == id){
      return i; //Возвращаем индекс в листе данных
    }
  }
  return throw("Не существует такого section_id"); // В буфере есть данные
}

Future<ProductDetail> getProductDetail(int id) async {

  await Future.delayed(const Duration(seconds: 1));


  for(var productDetaiil in Buffer.bufferProductsDetail!){
    if(productDetaiil.id == id){
      int idData = getIndexBufProducts(id);
      Product product = Buffer.bufferProducts![idData];
      return ProductDetail(
          id: productDetaiil.id,
          sectionId: productDetaiil.sectionId,
          name: productDetaiil.name,
          compound: productDetaiil.compound ,
          price: productDetaiil.price,
          idData: idData,
          isAction: productDetaiil.isAction,
          isTrash: product.isTrash,
          img: productDetaiil.img);
    }
  }
  return throw("Нет такого sectionId");
}


void clickTrash(BuildContext context, Order? order, idProduct){
  if(order == null){
    print("Добавлен заказ под id: ${idProduct}");
    context.read<OrderProviders>().addOrder(Order(idProduct));
  }else{
    print("Удалён заказ под id: ${idProduct}");
    context.read<OrderProviders>().deleteOrderById(idProduct);
  }
}
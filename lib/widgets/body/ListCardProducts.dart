import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_dilivery/buffer.dart';
import 'package:food_dilivery/functions/functions.dart';
import 'package:food_dilivery/models/category.dart';
import 'package:food_dilivery/models/product.dart';

import '../widgets.dart';

class ListCardProducts extends StatefulWidget {
  ListCardProducts({Key? key, required this.category}) : super(key: key);
  Category category;

  @override
  State<ListCardProducts> createState() => _ListCardProductsState();
}

class _ListCardProductsState extends State<ListCardProducts> {
  late Future<List<Product>?> products;

  @override
  void initState() {
    products = getProducts(widget.category.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (checkBuf(widget.category.id) == false) ? FutureBuilder<List<Product>?>(
      future: products,
      builder: (context,AsyncSnapshot<List<Product>?> snapshot){
          if(snapshot.hasData){
            List<Product>? products = snapshot.data;
            if(products == null){
              return Container();
            }else{
              return GridViewList(products: products);
            }
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }else{
            return const Center(child: CircularProgressIndicator());
          }
      }
    ) : GridViewList(products: Buffer.bufferCategories![getIndexBufCategory(widget.category.id)].products!);
  }

}



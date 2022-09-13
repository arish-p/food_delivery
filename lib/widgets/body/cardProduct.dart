import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_dilivery/buffer.dart';
import 'package:food_dilivery/const.dart';
import 'package:food_dilivery/data/dataProvider/OrdersProvider.dart';
import 'package:food_dilivery/data/dataProvider/categoriesProvider.dart';
import 'package:food_dilivery/data/dataProvider/trashProvider.dart';
import 'package:food_dilivery/functions/functions.dart';
import 'package:food_dilivery/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../models/product.dart';



class CardProduct extends StatefulWidget {
  CardProduct({Key? key, required this.product, required this.idProduct }) : super(key: key);
  Product product;
  int idProduct;

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  late String name;

  late double price;

  late bool isAction;

  late String img;

  late bool? isTrash;




  @override
  Widget build(BuildContext context) {


    name = widget.product.name;
    price = widget.product.price;
    //isAction = widget.product.isAction!;
    img = widget.product.img;
    isTrash = widget.product.isTrash;
    Color iconColor;

    Order? order = context.watch<OrderProviders>().getOrderById(widget.idProduct);

    if(order == null){
      iconColor = purpleDark;
    }else{
      iconColor = marineGreen;
    }


    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "detailPage", arguments: widget.idProduct);
      },
      child: Container(
        width: MediaQuery.of(context).size.width/2,
        height: 240,
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0,0),
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    child: Image.asset(img, fit: BoxFit.cover,))),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.headline4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${price.toString()} руб",style: Theme.of(context).textTheme.bodyText1,),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: iconColor,
                        child: IconButton(
                          onPressed: (){
                            clickTrash(context, order, widget.idProduct);
                            /*if(order == null){
                              print("Добавлен заказ под id: ${widget.idProduct}");
                              context.read<OrderProviders>().addOrder(Order(widget.idProduct));
                            }else{
                              print("Удалён заказ под id: ${widget.idProduct}");
                              context.read<OrderProviders>().deleteOrderById(widget.idProduct);
                            }*/
                            /*if(isTrash == false || isTrash == null){
                              Buffer.bufferCategories![context.read<CategoriesProvider>().currentCategory].products![widget.idProduct].isTrash = true;
                              setState(() {
                                iconColor = marineGreen;
                                context.read<TrashProvider>().update(TrashCardWidget(img: img, name: name, price: price, idProduct: widget.idProduct,));
                              });

                            }else{
                              Buffer.bufferCategories![context.read<CategoriesProvider>().currentCategory].products![widget.idProduct].isTrash = false;
                              context.read<TrashProvider>().delete(widget.idProduct);
                              setState(() {
                                iconColor = purpleDark;
                              });

                            }*/
                          },
                          icon: SvgPicture.asset(iconBasket,color: Colors.white,),),
                      )
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),

      ),
    );
  }
}

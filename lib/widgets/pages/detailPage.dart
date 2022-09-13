import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_dilivery/const.dart';
import 'package:food_dilivery/data/dataProvider/OrdersProvider.dart';
import 'package:food_dilivery/functions/functions.dart';
import 'package:food_dilivery/models/productDetail.dart';
import 'package:food_dilivery/widgets/appbar/AppBarUp.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../buffer.dart';
import '../../models/order.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
   DetailPage({Key? key,
   required this.id
   }) : super(key: key);

   int id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
   var boxDivider = const SizedBox(
     height: 20,
   );
   late Future<ProductDetail> productDetail;
   @override
  void initState() {
    productDetail = getProductDetail(widget.id);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    Order? order = context.watch<OrderProviders>().getOrderById(widget.id);
    Color iconColor;

    if(order == null){
      iconColor = purpleDark;
    }else{
      iconColor = marineGreen;
    }


    return Scaffold(
      body: FutureBuilder(
          future: productDetail,
          builder: (BuildContext context,AsyncSnapshot<ProductDetail> snapshot) {
            if(snapshot.hasData){
              ProductDetail productDetail = snapshot.data!;
              return Column(
                children: [
                  AppBarUp(),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Image.asset(productDetail.img, fit: BoxFit.cover,)),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productDetail.name, style: Theme.of(context).textTheme.headline2,),
                        boxDivider,
                        Text(productDetail.compound, style: Theme.of(context).textTheme.bodyText2),
                        boxDivider,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Количество", style: Theme.of(context).textTheme.bodyLarge,),
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: (){
                                if(order == null){}
                                else if(order!.getCount() == 1){
                                  context.read<OrderProviders>().deleteOrderById(widget.id);
                                  order == null;
                                }else{
                                  context.read<OrderProviders>().decreaseById(widget.id);
                                }

                              },
                            ),
                            (order == null)?
                            const Text("0") :
                            Text(context.read<OrderProviders>().getCountOrderById(widget.id).toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: (){
                                if(order == null){
                                  order = Order(widget.id);
                                  context.read<OrderProviders>().addOrder(order!);
                                }else{
                                  context.read<OrderProviders>().increaseById(widget.id);
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(productDetail.price.toString(), style: Theme.of(context).textTheme.bodyLarge),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: iconColor,
                              child: IconButton(
                                onPressed: (){
                                  clickTrash(context, order, widget.id);
                                },

                                icon: SvgPicture.asset(iconBasket,color: Colors.white,),),
                            ),

                          ],
                        ),

                      ],
                    ),
                  )
                ],
              );
            }else if(snapshot.hasError){return  Text(snapshot.error.toString());}
            else{return Center(child: const CircularProgressIndicator());}
          }
      ),
    );
  }
}

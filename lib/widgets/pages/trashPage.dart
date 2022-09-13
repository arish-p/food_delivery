import 'package:flutter/material.dart';
import 'package:food_dilivery/buffer.dart';
import 'package:food_dilivery/data/dataProvider/OrdersProvider.dart';
import 'package:food_dilivery/data/dataProvider/trashProvider.dart';
import 'package:food_dilivery/models/TrashCard.dart';
import 'package:food_dilivery/widgets/appbar/AppBarUp.dart';
import 'package:food_dilivery/widgets/body/cardProduct.dart';
import 'package:food_dilivery/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../models/order.dart';
import '../../models/product.dart';

class TrashPage extends StatefulWidget {
 TrashPage({Key? key}) : super(key: key);

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {





  @override
  Widget build(BuildContext context) {
    List<Order> orders = context.watch<OrderProviders>().getOrders();
    int length = context.watch<OrderProviders>().getSize();
    List<String> items = List<String>.generate(length, (i) => 'Item ${i + 1}');

    return Scaffold(
      appBar: AppBarUp(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Корзина", style: Theme.of(context).textTheme.headline1,),
            SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                  itemCount: context.watch<OrderProviders>().getSize(),
                  itemBuilder: (context,index){
                      Product? productTrash;
                      for(var product in Buffer.bufferProducts!){
                        if(product.id == orders[index].id){
                          productTrash = product;
                        }
                      }
                    return (productTrash != null) ? Dismissible(
                      key: UniqueKey(),

                      onDismissed: (direction){
                        context.read<OrderProviders>().deleteOrderById(productTrash!.id);
                      },

                      child: TrashCardWidget(
                          img: productTrash.img,
                          name: productTrash.name,
                          price: productTrash.price,
                          id: productTrash.id),
                    ) : Container();
                  }),
            ),
          ],
        ),
      )
    );
  }
}

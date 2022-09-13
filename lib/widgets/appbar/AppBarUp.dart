import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_dilivery/const.dart';
import 'package:food_dilivery/data/dataProvider/OrdersProvider.dart';
import 'package:provider/provider.dart';


class AppBarUp extends StatelessWidget with PreferredSizeWidget{
  AppBarUp({Key? key,}) : super(key: key);
  String icon = iconCompany;
  double iconsize = 30;

  @override
  Widget build(BuildContext context) {

    int amount = context.watch<OrderProviders>().getSize();
    return AppBar(
      automaticallyImplyLeading: false,
      title: IconButton(
        onPressed: (){
          Navigator.pushNamedAndRemoveUntil(context, "main", (route) => false);
        },
        icon: SvgPicture.asset(
          icon,
        ),
        iconSize: 100,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){

                },
                icon: SvgPicture.asset(iconPhone, width: 25, height: 25,),
              ),
              IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "trashPage");
                  },
                  icon: Stack(

                    children: [
                      Container(
                        width: 100,
                          child: SvgPicture.asset(iconBasket, width: 25, height: 25)),
                      (amount != 0) ?
                      Positioned(
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: marineGreen,
                          child: Text(amount.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                        right: 15,
                        bottom: 7,
                      ): SizedBox(),
                    ],
                  )
              ),
              IconButton(
                onPressed: (){
                  key.currentState!.openDrawer();

                },
                icon: Icon(Icons.menu, size: iconsize, color: purpleDark),
              ),
            ],
          ),
        )
      ],
      toolbarHeight: 100, //высота для конкретного appBar

    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(100,100);
}
